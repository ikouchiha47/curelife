class DoctorSlot < ApplicationRecord
  # D = [
    # "Sunday",
    # "Monday",
    # "Tuesday",
    # "Wednesday",
    # "Thrusday",
    # "Friday",
    # "Saturday"
  # ]

   validates :checkup_duration, :slot_template, :doctor_id, :location_id, presence: true

  def days=(day_s = [])
    self.days_of_week = pad_days(day_s).map { |d| d.to_i <= 0 ? 0 : 1 }.join(",")
  end

  def slots=(slot_s=[])
    self.bookings = pad_bookings(slot_s, slots.length).join(",")
  end

  def slots
    @slots ||= JSON.parse(self.slot_template)
      .to_a
      .map{|k,v| [pad_slot(k), pad_slot(v)]}
      .map{|k,v| [k.insert(2,':'), v.insert(2, ':')]}
  end

  def booked_slots
    bookings = pad_bookings(self.bookings.split(","), slots.length)
    bookings.each_with_index.map do |flag, i|
      if flag.to_i == 0
        "0"
      else
        slots[i]
      end
    end
  end

  def book(slot_number)
    bookings = pad_bookings(self.bookings.split(","), slots.length)
    return false if slot_number > bookings.length

    return false if bookings[slot_number] == "1"
    bookings[slot_number] = "1"
    return self.update(bookings: bookings.join(","))
  end

  private

    def to_time(str_time)
      DateTime.strptime(str_time, "%H:%M")
    end

    def pad_slot(slot)
      s = slot.to_s
      while s.length < 4
        s = "0" + s 
      end
      s
    end

    def pad_days(days = [])
      while days.length < 7
        days.push("0")
      end
      days
    end

    def pad_bookings(bookings = [], total)
      while bookings.length < total
        bookings.push("0")
      end
      bookings.map(&:to_s)
    end
end
