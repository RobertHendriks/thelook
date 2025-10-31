view: cross_view_filtered_measures {
  measure: sum_margin_calvin_klein_option_2_crossview {
    label: "€ Calvin Klein Margin Option 2 {Cross View}"
    description: "The amount of margin made on Calvin Klein products."
    type: sum
    sql:
    CASE WHEN ${products.brand} = 'Calvin Klein'
            THEN ${order_items.sale_price} - ${inventory_items.cost}
      ELSE NULL
      END ;;
    value_format_name: eur
  }

}

# view: cross_view_filtered_measures {
#   # Or, you could make this view a derived table, like this:
#   derived_table: {
#     sql: SELECT
#         user_id as user_id
#         , COUNT(*) as lifetime_orders
#         , MAX(orders.created_at) as most_recent_purchase_at
#       FROM orders
#       GROUP BY user_id
#       ;;
#   }
#
#   # Define your dimensions and measures here, like this:
#   dimension: user_id {
#     description: "Unique ID for each user that has ordered"
#     type: number
#     sql: ${TABLE}.user_id ;;
#   }
#
#   dimension: lifetime_orders {
#     description: "The total number of orders for each user"
#     type: number
#     sql: ${TABLE}.lifetime_orders ;;
#   }
#
#   dimension_group: most_recent_purchase {
#     description: "The date when each user last ordered"
#     type: time
#     timeframes: [date, week, month, year]
#     sql: ${TABLE}.most_recent_purchase_at ;;
#   }
#
#   measure: total_lifetime_orders {
#     description: "Use this for counting lifetime orders across many users"
#     type: sum
#     sql: ${lifetime_orders} ;;
#   }
# }
