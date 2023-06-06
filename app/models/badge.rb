class Badge < ApplicationRecord
  belongs_to :user

  IMG_FOR_PASSAGE_TEST = { 1 => "https://mir-s3-cdn-cf.behance.net/user/276/8853769.549b42d8ad386.jpg",
                           2 => "http://ru.meneger.net/images/photo/1548618680.jpg",
                           3 => "https://image.emojipng.com/226/5139226.jpg" }.freeze

  def self.img(test_passage)
     IMG_FOR_PASSAGE_TEST[test_passage.test.level] || 1
  end

end