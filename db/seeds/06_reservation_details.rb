puts "-- reservation_details"

weekday = Price.find_by!(price_name: "平日料金")
holiday = Price.find_by!(price_name: "土日祝日料金")

{
  "RS0000001" => [
    { person_type: "adult", number_of_people: 2, price: weekday.adult_price },
    { person_type: "child", number_of_people: 1, price: weekday.child_price }
  ],
  "RS0000002" => [
    { person_type: "adult",   number_of_people: 2, price: holiday.adult_price },
    { person_type: "student", number_of_people: 1, price: holiday.student_price },
    { person_type: "infant",  number_of_people: 1, price: holiday.infant_price }
  ],
  "RS0000003" => [
    { person_type: "adult", number_of_people: 4, price: holiday.adult_price }
  ],
  "RS0000004" => [
    { person_type: "adult", number_of_people: 1, price: holiday.adult_price },
    { person_type: "child", number_of_people: 2, price: holiday.child_price }
  ],
  "RS0000005" => [
    { person_type: "adult",   number_of_people: 3, price: holiday.adult_price },
    { person_type: "student", number_of_people: 2, price: holiday.student_price },
    { person_type: "infant",  number_of_people: 1, price: holiday.infant_price }
  ],
  "RS0000006" => [
    { person_type: "adult",   number_of_people: 2, price: weekday.adult_price },
    { person_type: "student", number_of_people: 1, price: weekday.student_price }
  ],
  "RS0000007" => [
    { person_type: "adult",  number_of_people: 5, price: holiday.adult_price },
    { person_type: "child",  number_of_people: 3, price: holiday.child_price },
    { person_type: "infant", number_of_people: 2, price: holiday.infant_price }
  ]
}.each do |res_code, details|
  res = Reservation.find_by!(res_code: res_code)

  details.each do |d|
    ReservationDetail.find_or_create_by!(reservation_id: res.id, person_type: d[:person_type]) do |rd|
      rd.number_of_people = d[:number_of_people]
      rd.price            = d[:price]
      rd.subtotal         = d[:number_of_people] * d[:price]
    end
  end
end

puts "   #{ReservationDetail.count} reservation_details created"
