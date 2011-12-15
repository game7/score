require 'active_support'
require 'active_record'
require 'action_controller'

module Score
  module Crud
    
    def self.default_options(model_name)
      class_name = model_name.classify
      instance_name = class_name.demodulize.underscore
      singular_name = instance_name.humanize
      plural_name = singular_name.pluralize
      {
        :class_name => class_name,
        :instance_name => instance_name,
        :singular_name => singular_name,
        :plural_name => plural_name
      }
    end
    
    def self.append_features(base)
      super
      base.send(:include, Score::Crud::HookMethods)
      base.extend(Score::Crud::ClassMethods)
    end
    
    module ClassMethods
      
      def crudify(model_name, options = {})
        options = ::Score::Crud.default_options(model_name).merge(options)
        class_name = options[:class_name]
        instance_name = options[:instance_name]
        singular_name = options[:singular_name]
        plural_name = options[:plural_name]
      
        module_eval %(
      
          def self.crudify_options
            #{options.inspect}
          end
        
          prepend_before_filter :find_#{instance_name},
                                :only => [:update, :destroy, :edit, :show]
          prepend_before_filter :set_what
          prepend_before_filter :set_inflections
          before_filter         :set_partial
                              
          def new
            @instance = @#{instance_name} = #{class_name}.new
            session[:partial] = params[:partial] ? params[:partial] : "#{instance_name}"            
            before_render_new
          end
        
          def create
            @instance = @#{instance_name} = #{class_name}.new(params[:#{instance_name}])  
            ok = before_create
            return ok unless ok === true
            if @instance.valid? && @instance.save
              (request.xhr? ? flash.now : flash).notice = t(
                'score.crudify.created',
                :what => @what
              )
              redirect_to :back unless request.xhr?
            else
              render :action => 'new' unless request.xhr?
            end
          end
        
          def edit
            # object gets found by find_#{instance_name} function
            session[:partial] = params[:partial] ? params[:partial] : "#{instance_name}"            
            before_render_edit
          end
        
          def update
            puts request.xhr?
            ok = before_update
            return ok unless ok === true
            if @#{instance_name}.update_attributes(params[:#{instance_name}])
              (request.xhr? ? flash.now : flash).notice = t(
                'score.crudify.updated',
                :what => @what
              )
              redirect_to :back unless request.xhr?
            else
              render :action => 'edit' unless request.xhr?
            end
          end
        
          def destroy
            # object gets found by find_#{instance_name} function
            ok = before_destroy
            return ok unless ok === true
            if @#{instance_name}.destroy
              (request.xhr? ? flash.now : flash).notice = t(
                'score.crudify.destroyed',
                :what => @what
              )
              redirect_to :back unless request.xhr?
            end
          end
        
          def find_#{instance_name}
            @instance = @#{instance_name} = #{class_name}.find(params[:id])
          end
          
          def set_what
            @what = "#{singular_name}"
          end
          
          def set_partial
            @partial = session[:partial]
          end
          
          def set_inflections
            @inflections = {
              :singular => "#{singular_name}",
              :plural => "#{plural_name}",
              :instance => "#{instance_name}",
              :instances => "#{instance_name}".pluralize
            }
          end
          
          protected :find_#{instance_name},
                    :set_what,
                    :set_inflections
      
        )
        
      end
      
    end
    
    module HookMethods
      
      private
      
        def before_create
          before_action
        end
        
        def before_update
          before_action
        end
        
        def before_destroy
          before_action
        end
        
        def before_action
          true
        end
        
        def before_render_new
        end
        
        def before_render_edit
        end
      
    end
    
  end
end

ActionController::Base.send(:include, Score::Crud)