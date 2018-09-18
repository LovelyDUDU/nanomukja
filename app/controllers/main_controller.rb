class MainController < ApplicationController
  include Math
  
  
  def index
  end

  def signin
  end

  def signup
  end

  def map_page
    unless user_signed_in?
      redirect_to "/users/sign_in"
    end

  end

  def position_ok
    @user = User.find(current_user.id)
    
    @user.latitude = params[:latitude]
    @user.longitude = params[:longitude]
    @user.save
    current_user.latitude= @user.latitude
    current_user.longitude=@user.longitude
    redirect_to '/'
  end


  def login
  end
  
  
  def first
    
      @temp = User.new
      
      if user_signed_in?
        @cur_user = User.find(current_user.id)
        if params[:latitude] == nil || params[:longitude] == nil then
          @temp.latitude = 37.592574
          @temp.longitude = 127.024742
        else
          @temp.latitude = current_user.latitude
          @temp.longitude = current_user.longitude
        end
      else
        @cur_user = User.new
        if params[:latitude] == nil || params[:longitude] == nil then
          @temp.latitude = 37.592574
          @temp.longitude = 127.024742
        else
          @temp.latitude = params[:latitude]
          @temp.longitude = params[:longitude]
        end
      end
      
        
      @users = User.all
        
      @results = Array.new
      @myLat = @temp.latitude
      @myLong = @temp.longitude
      
      
      @users.each do |u| 
        if u.latitude != 0.0 && u.longitude != 0.0 then
         
          distance = calDistance2(@myLat.to_f, @myLong.to_f, u.latitude.to_f, u.longitude.to_f) * 1000
          
          if 500.0 > distance
            @results << u
          end
        end
        
      end
      
      if @results != nil 
        @results.sort! { |a, b|  b.star_score <=> a.star_score }
      end
      
      
      @photo_addr = Array.new(3)
      
      for i in 0..2
        
        if @results.at(i) == nil
          temp_user = User.new
          temp_user.name = ""
          temp_user.profile_photo_addr = "default.png"
          @photo_addr[i] = "default.png"
          @results << temp_user
        elsif @results.at(i).profile_photo_addr.to_s == ""
          @photo_addr[i] = "default.png"
        else
          @photo_addr[i] = @results.at(i).profile_photo_addr.to_s
        end
        
        
      end
      
      
      
  end
  
  def <=>(other)
    self.star_score <=> other.star_score
  end



  
  
  def get_star_score(user)
    
    @myPosts = Post.where(writer: user.id)
    temp_total_star = 0
    temp_total_count = 0
    @myPosts.each do |mp|
      temp_total_count = temp_total_count + mp.comment_cnt
      temp_total_star = temp_total_star + mp.total_star
    end
    
    if temp_total_count == 0
      return 0.0
    else
      return temp_total_star.to_f / temp_total_count.to_f    
    end

      
  end
  
  
  
  def get_location
    
  end
  
  

  def second
    unless user_signed_in?
      redirect_to "/users/sign_in"
    end
    @user = User.all
    
    
    
    radius = params[:radius]
    chk = params[:chk]    #체크박스 파라미터

    @posts = Array.new    #Post 배열 생성
    for i in 1..6

      @temp = Post.where(category: chk[i.to_s])  #where절로 가져온 배열 temp에 넣기
      @temp.each do |t|
        @posts << t                 #temp에 있는 각 원소들 @posts에 차곡차곡 넣기
      end

    end
 
    u = User.find(current_user.id)
    @myLat = u.latitude.to_f
    @myLong =u.longitude.to_f

    @results = Array.new
    @posts.each do |p|
      distance = calDistance2(@myLat, @myLong, p.lat.to_f, p.lng.to_f)* 1000
      
      if radius.to_f > distance
        @results << p

      end
      
    end


  end

  def calDistance(myLat, myLong, destLat, destLong)
        theta = myLong - destLong
        dist = Math.sin(deg2rad(myLat))*Math.sin(deg2rad(destLat)) + Math.cos(deg2rad(myLat)) * Math.cos(deg2rad(destLat)) * Math.cos(deg2rad(theta))

        dist = Math.acos(dist)
        dist = rad2deg(dist)
        dist = dist * 60 * 1.1515

        dist = dist*1609.344
      return dist
  end

  def calDistance2(lat1, lon1, lat2, lon2)
    p = 0.017453292519943295
    a = 0.5-Math.cos((lat2 - lat1)*p)/2 + Math.cos(lat1*p)*Math.cos(lat2*p)*(1 - Math.cos((lon2 - lon1)*p))/2
    return 12742 * Math.asin(Math.sqrt(a))
  end


  # def deg2rad(deg)
  #   return (deg*Math::PI/180.0)
  # end
  # def rad2deg(rad)
  #   return (rad * 180 / Math::PI)
  # end
  
  def deg2rad(deg)
    return (deg*Math::PI/180.0)
  end
  def rad2deg(rad)
    return (rad * 180.0 / Math::PI)
  end
  
  

  def third
  end

  def temp
  end

  def read
    @post = Post.find(params[:post_id])
    @user = User.find(@post.writer)
    if @user.profile_photo_addr.to_s == ""
      @user_photo = "/default.png"
    else
      @user_photo = @user.profile_photo_addr
    end
    @comments = Comment.where(post_id: @post.id)
  end
  
  def comment_reg
    @comment = Comment.new
    @comment.post_id = params[:post_id]
    @comment.writer = params[:writer]
    @comment.content = params[:content]
    @comment.star_score = params[:rating]
    @comment.save
    
    
    
    #여기 해당 post 별점 평균 계산하는거 추가해야함
    @post = Post.find(@comment.post_id)
    
    @post.total_star = @post.total_star + @comment.star_score
    @post.comment_cnt = @post.comment_cnt + 1
    
    @post.avg_star_score = @post.total_star.to_f / @post.comment_cnt.to_f
    @post.save
    
    @user = User.find(@post.writer)
    @user.star_score = get_star_score(@user)
    @user.save
    
    redirect_to '/read/'+@comment.post_id.to_s
  end
  
  
  def send_message
    unless user_signed_in?
      redirect_to "/users/sign_in"
    end
    
    @user = User.find(params[:user_id])
  end

  def send_message_ok
    @message = Message.new
    @message.sender_id = current_user.id
    @message.receiver_id = params[:receiver_id]
    @message.message = params[:content]
    @message.save
    
    redirect_to '/profile/'+params[:receiver_id]
  end
  
  def read_message
    @results = Message.where(receiver_id: current_user.id)
    
  end
  

  def profile
    unless user_signed_in?
      redirect_to "/users/sign_in"
    end
    
    @user = User.find(params[:user_id])
    @results = Post.where(writer: params[:user_id])
    
    if @user.back_photo_addr.to_s == ""
      @back_photo = "/noodles.png"
    else
      @back_photo = @user.back_photo_addr
    end
    p @user.back_photo_addr
    
    if @user.profile_photo_addr.to_s == ""
      @profile_photo = "/sushi.png"
    else
      @profile_photo = @user.profile_photo_addr
    end
    
    @user_following = Follow.where(following_id: params[:user_id])
    @user_follower = Follow.where(follower_id: params[:user_id])
    if current_user !=nil
      @my_follow_list = Follow.where(following_id: current_user.id);
      @isFollow = false;
      @my_follow_list.each do |f|
        if f.follower_id == params[:user_id]
          @isFollow = true;
          break;
        end
      end
    end
    
    # @isFollow = @my_follow_list.follower_id.include?(params[:user_id]);
    
  end

  def follow_request
    
    @follow = Follow.new()
    @follow.following_id = current_user.id
    @follow.follower_id = params[:user_id]
    @follow.save
    redirect_to '/profile/'+params[:user_id]
  end
  
  
  def follow_cancel
    
    @follow = Follow.where(following_id: current_user.id, follower_id: params[:user_id])
    
    @follow.first.delete
    redirect_to '/profile/'+params[:user_id]
  end
  
  def post_update
    @post = Post.find(params[:post_id])
    if @post.food_photo.to_s == ""
      @food_photo = "default.png"
    else
      @food_photo = @post.food_photo
    end
    @user = User.find(@post.writer)
    
  end
  
  def post_update_ok
    
    @p = Post.find(params[:post_id])
    
    @p.food_photo = params[:food_photo]
    @p.content = params[:content]
    @p.total_price = params[:total_price]
    @p.people_num = params[:people_num]
    @p.final_date = params[:final_date]
    @p.lat = params[:post_lat]
    @p.lng = params[:post_long]
    @p.category = params[:category]
    @p.save

    redirect_to '/profile/'+current_user.id.to_s
  end

  def post_delete
    @post = Post.find(params[:post_id])
    @comments = Comment.where(post_id: params[:post_id])
    
    @comments.each do |c|
      c.delete
    end
    
    
    @post.delete
    
    @user = User.find(@post.writer)
    @user.star_score = get_star_score(@user)
    @user.save
    
    redirect_to '/profile/'+current_user.id.to_s
  end
  
  
  
  
  def back_photo_reg
    
    @user = User.find(params[:user_id])
    @user.back_photo_addr = params[:photo_addr]
    @user.save
    redirect_to '/profile/'+params[:user_id]
  end
  
  def profile_photo_reg
    
    @user = User.find(params[:user_id])
    @user.profile_photo_addr = params[:photo_addr]
    @user.save
    redirect_to '/profile/'+params[:user_id]
  end
  
  def profile_introduce_reg
    @user = User.find(params[:user_id])
    @user.introduce = params[:content]
    @user.save
    redirect_to '/profile/'+params[:user_id]
  end
  
  

  def write
    unless user_signed_in?
      redirect_to "/users/sign_in"
    end
  end

  def test
    
  end
  
  def write_ok

    @p = Post.new
    @p.writer = current_user.id;
    @p.name = params[:name]
    @p.food_photo = params[:food_photo]
    @p.content = params[:content]
    @p.total_price = params[:total_price]
    @p.people_num = params[:people_num]
    @p.final_date = params[:final_date]
    @p.lat = params[:post_lat]
    @p.lng = params[:post_long]
    @p.category = params[:category]
    @p.save

    redirect_to '/'
  end  
   
  
end

