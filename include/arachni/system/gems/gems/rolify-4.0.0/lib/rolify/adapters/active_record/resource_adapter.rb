require 'rolify/adapters/base'

module Rolify
  module Adapter
    class ResourceAdapter < ResourceAdapterBase
      def find_roles(role_name, relation, user)
        roles = user && (user != :any) ? user.roles : self.role_class
        roles = roles.where('resource_type IN (?)', self.relation_types_for(relation))
        roles = roles.where(:name => role_name.to_s) if role_name && (role_name != :any)
        roles
      end

      def resources_find(roles_table, relation, role_name)
        klasses   = self.relation_types_for(relation)
        relations = klasses.inject('') do |str, klass|
          str = "#{str}'#{klass.to_s}'"
          str << ', ' unless klass == klasses.last
          str
        end
        resources = relation.joins("INNER JOIN #{quote(roles_table)} ON #{quote(roles_table)}.resource_type IN (#{relations}) AND
                                    (#{quote(roles_table)}.resource_id IS NULL OR #{quote(roles_table)}.resource_id = #{quote(relation.table_name)}.#{relation.primary_key})")
        resources = resources.where("#{quote(roles_table)}.name IN (?) AND #{quote(roles_table)}.resource_type IN (?)", Array(role_name), klasses)
        resources = resources.select("#{quote(relation.table_name)}.*")
        resources
      end

      def in(relation, user, role_names)
        roles = user.roles.where(:name => role_names).select("#{quote(role_class.table_name)}.#{role_class.primary_key}")
        relation.where("#{quote(role_class.table_name)}.#{role_class.primary_key} IN (?) AND ((resource_id = #{quote(relation.table_name)}.#{relation.primary_key}) OR (resource_id IS NULL))", roles)
      end

      def applied_roles(relation, children)
        if children
          relation.role_class.where('resource_type IN (?) AND resource_id IS NULL', self.relation_types_for(relation))
        else
          relation.role_class.where('resource_type = ? AND resource_id IS NULL', relation.to_s)
        end
      end

      private

      def quote(column)
        ActiveRecord::Base.connection.quote_column_name column
      end
    end
  end
end
