# Here we simulate a database connection with Fields
class FieldsService
  include Singleton

  FIELDS = [
    {
      id: 1,
      name: 'Mäeotsa',
      area: 0.93,
      crops: [
        { year: 2020, crop: CropsService::WINTER_WHEAT },
        { year: 2021, crop: CropsService::OATS },
        { year: 2022, crop: CropsService::WINTER_WHEAT },
        { year: 2023, crop: CropsService::OATS },
        { year: 2024, crop: CropsService::WINTER_WHEAT },
      ],
    },
    {
      id: 2,
      name: 'Tiigimanu',
      area: 3.14,
      crops: [
        { year: 2020, crop: CropsService::SPRING_WHEAT },
        { year: 2021, crop: CropsService::OATS },
        { year: 2022, crop: CropsService::RED_CLOVER },
        { year: 2023, crop: CropsService::WINTER_WHEAT },
        { year: 2024, crop: CropsService::BROAD_BEAN },
      ],
    },
    {
      id: 3,
      name: 'Künkatagune',
      area: 5.18,
      crops: [
        { year: 2020, crop: CropsService::SPRING_WHEAT },
        { year: 2021, crop: CropsService::SPRING_WHEAT },
        { year: 2022, crop: CropsService::SPRING_WHEAT },
        { year: 2023, crop: CropsService::SPRING_WHEAT },
        { year: 2024, crop: CropsService::SPRING_WHEAT },
      ],
    },
  ].freeze

  def fetch_fields
    result = []

    FIELDS.each do |field|
      humus_balance = 0
      prior_year_crop_value = nil

      field[:crops].each do |year|
        factor = (year[:crop][:value] == prior_year_crop_value) ? 1.3 : 1.0
        humus_balance += year[:crop][:humus_delta] * field[:area] * factor

        prior_year_crop_value = year[:crop][:value]
      end

      field[:balance] = humus_balance.round(2)

      result << field
    end

    result
  end
end
