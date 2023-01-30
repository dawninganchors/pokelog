module TraineesHelper
  # Helper for the trainee#show view that takes multiple Trainee objects
  # and renders a path to view them e.g. /trainees/1,2,3
  #
  # @param [Array<Trainee>] trainees to show
  # @return path to the trainees#show for those trainees
  def multi_trainees_path(trainees)
    trainee_path trainees.map(&:id).join(",")
  end

  # Constructs a title for trainees#show. With one trainee displayed it calls
  # Trainee#title, or the nickname on mobile. With multiple trainees displayed
  # it will display something like "3 Trainees" on all sizes.
  #
  # @param [Array<Trainee>] trainees being displayed
  # @return [Hash] with :title and :mobile_title values
  def trainees_show_title(trainees)
    # Deserialized JSON data works too
    if trainees.first.is_a? Hash
      trainees[0] = Trainee.find trainees.first["id"]
    end

    multi_title = "#{trainees.size} Trainees"
    trainees.size > 1 ? { title: multi_title, mobile_title: multi_title } : {
      title: trainees.first.title,
      mobile_title: trainees.first.nickname
    }
  end

  # Determines if a user is allowed to edit a trainee,
  # i.e. if logged in and the trainee's owner.
  def yours?(trainee)
    logged_in? && trainee.user == @current_user
  end

  # Determines if a user isn't allowed to edit a trainee.
  def not_yours?(trainee)
    !yours? trainee
  end
end