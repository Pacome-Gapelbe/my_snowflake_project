{% macro payment_method(table, database=target.database, schema=target.schema) %}
    {% set payment_sql %}
        select distinct paymentmethod as payment_method
        from {{ database }}.{{ schema }}.{{ table }}
    {% endset %}

    {% set results = run_query(payment_sql) %}

    {% if execute %}
        {% set result_list = results.columns[0].values() %}
    {% else %}
        {% set result_list = [] %}
    {% endif %}

    {{ log('Here is the list of the payment methods: ' ~ result_list, info=True) }}
{% endmacro %}
