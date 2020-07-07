require 'rails_helper'

RSpec.describe Video do
  it {should belong_to :tutorial}
  it {should have_many(:users).through(:user_videos)}
  it {should have_many(:user_videos).dependent(:destroy)}

  describe 'class methods' do
    it '.bookmarked_videos' do
      tutorial1 = create(:tutorial, title: "How to Tie Your Shoes")
      tutorial2 = create(:tutorial, title: "How to Cook a Steak")
      video1 = create(:video, title: "The Bunny Ears Technique", tutorial: tutorial1)
      video2 = create(:video, title: "The Around the Tree Technique", tutorial: tutorial1)
      video3 = create(:video, title: "Steak Seasoning", tutorial: tutorial2, position: 0)
      video4 = create(:video, title: "Classic Sear", tutorial: tutorial2, position: 1)
      video5 = create(:video, title: "Reverse Sear", tutorial: tutorial2, position: 2)
      video6 = create(:video, title: "Resting", tutorial: tutorial2, position: 3)
      user = create(:user)
      user2 = create(:user)
      UserVideo.create({user_id: user.id, video_id: video1.id})
      UserVideo.create({user_id: user.id, video_id: video5.id})
      UserVideo.create({user_id: user.id, video_id: video6.id})
      UserVideo.create({user_id: user.id, video_id: video3.id})
      UserVideo.create({user_id: user.id, video_id: video4.id})

      UserVideo.create({user_id: user2.id, video_id: video3.id})
      UserVideo.create({user_id: user2.id, video_id: video4.id})

      expected_return = {
        tutorial1 => [video1],
        tutorial2 => [video3, video4, video5, video6]
      }

      expect(user.videos.bookmarked_videos).to eq(expected_return)
    end
  end
end
