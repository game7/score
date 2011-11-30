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
                              
          def new
            @instance = @#{instance_name} = #{class_name}.new
          end
        
          def create
            if (@instance = @#{instance_name} = #{class_name}.create(params[:#{instance_name}])).valid?
              (request.xhr? ? flash.now : flash).notice = t(
                'score.crudify.created',
                :what => @what
              )
            end
          end
        
          def edit
            # object gets found by find_#{instance_name} function
          end
        
          def update
            if @#{instance_name}.update_attributes(params[:#{instance_name}])
              (request.xhr? ? flash.now : flash).notice = t(
                'score.crudify.updated',
                :what => @what
              )
            end
          end
        
          def destroy
            # object gets found by find_#{instance_name} function
            if @#{instance_name}.destroy
              (request.xhr? ? flash.now : flash).notice = t(
                'score.crudify.destroyed',
                :what => @what
              )
            end
          end
        
          def find_#{instance_name}
            @instance = @#{instance_name} = #{class_name}.find(params[:id])
          end
          
          def set_what
            @what = "#{singular_name}"
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
    
  end
end

ActionController::Base.send(:include, Score::Crud)