{% macro grant_access(schema=target.schema, role= target.role) %}
    {% set sql %}
        grant usage on schema {{schema}} to role {{role}};
        grant select on all tables in schema {{schema}} to role {{role}};
        grant select on all views in schema {{schema}} to role {{role}};
   {% endset %}

   {{ log('Granting access to  schema ' ~ schema ~ ' to role ' ~ role ~ '' , info=True)}}
        {%do run_query(sql) %}
    {{ log('Access granted to schema ' ~ schema ~ ' to role ' ~ role ~ '' , info=True)}}
  
    

{% endmacro %}