{% macro cents_to_dollar(column_name, decimal_places=2) -%}
    round({{column_name}}/100.0, {{decimal_places }})
{%- endmacro %}