abstract class SocialLayOutStates {}

class SocialLayOutInit extends SocialLayOutStates {}

class UserDataLoadingState extends SocialLayOutStates {}

class UserDataSuccessState extends SocialLayOutStates {}

class UserDataErrorState extends SocialLayOutStates {}

class ChangeBottomNavigateState extends SocialLayOutStates {}

class PostsState extends SocialLayOutStates {}

class SaveProfileToServerSuccessState extends SocialLayOutStates {}

class SaveProfileToServerErorrState extends SocialLayOutStates {}

class LoadingSaveProfileImageState extends SocialLayOutStates {}

class SaveCoverToServerSuccessState extends SocialLayOutStates {}

class SaveCoverToServerErorrState extends SocialLayOutStates {}

class LoadingSaveCoverImageState extends SocialLayOutStates {}

class UpdateUserSuccessState extends SocialLayOutStates {}

class UpdateUserErorrState extends SocialLayOutStates {}

class SignOutSuccessState extends SocialLayOutStates {}

//PostImage to storage
class SavePostImageToServerSuccessState extends SocialLayOutStates {}

class SavePostImageeToServerErorrState extends SocialLayOutStates {}

class LoadingSavePostImageState extends SocialLayOutStates {}

//createPost
class CreatePostSuccessState extends SocialLayOutStates {
  final PostImage;

  CreatePostSuccessState(this.PostImage);
}

class CreatePostErrorState extends SocialLayOutStates {}

class CreatePostLoaginState extends SocialLayOutStates {}

//GetPosts

class GetPostsSuccessState extends SocialLayOutStates {
  final postsid;

  GetPostsSuccessState(this.postsid);
}

class GetPostsErorrState extends SocialLayOutStates {}

class GetPostsLoadingState extends SocialLayOutStates {}

//picked PostImage
class PickedPostSuccessState extends SocialLayOutStates {}

class PickedPostErrorState extends SocialLayOutStates {}

class ClosePostImageState extends SocialLayOutStates {}

//update Posts
class UdpatePostSucessState extends SocialLayOutStates {}

class UdpatePostErorrState extends SocialLayOutStates {}

//likes

class LikePostSuccessState extends SocialLayOutStates {}

class LikePostErorrState extends SocialLayOutStates {}

//updatenumberoflike
class UpdateLikeSuccessState extends SocialLayOutStates {}

class UpdateLikeErorrState extends SocialLayOutStates {}

class LodingLikeState extends SocialLayOutStates {}

//SetComments

class SetCommentsSuccessState extends SocialLayOutStates {}

class SetCommentsErorrState extends SocialLayOutStates {}

class LoadingCommentState extends SocialLayOutStates {}

////GetComments

class GetCommentsSuccessState extends SocialLayOutStates {}

class GetCommentsErorrState extends SocialLayOutStates {}

//one comment
class GetOneCommentSuccessState extends SocialLayOutStates {}

class GetOneCommentErorrState extends SocialLayOutStates {}


//GetAllUsers
class GetAllUserSuccessState extends SocialLayOutStates {}
class GetAllUserErorrState extends SocialLayOutStates {}
class GetAllUserLoadingState extends SocialLayOutStates {}



//SendMassege
class SendMassegeSuccessState extends SocialLayOutStates {}
class SendMassegeErorrState extends SocialLayOutStates {}
class GetMassegesSuccessState extends SocialLayOutStates {}
class GetMassegesErorrState extends SocialLayOutStates {}


class ScrollDownState extends SocialLayOutStates {}


//numberOfPosts
class NumberOfPostsSuccessState extends SocialLayOutStates {}