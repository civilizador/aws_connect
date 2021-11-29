resource "aws_lex_slot_type" "appointment_types" {
  description = "Type of an appointment to schedule"

  enumeration_value {
    value = "general"
  }

  enumeration_value {
    value = "oil-change"
  }

  enumeration_value {
    value = "brakes"
  }
 
  enumeration_value {
    value = "muffler"
  }

  name                     = "AppointmentTypeValue"
  value_selection_strategy = "ORIGINAL_VALUE"
}
