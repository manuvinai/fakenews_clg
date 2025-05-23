
from django.urls import path
from . import views
urlpatterns = [
    path('',views.login),
    path('adminhome',views.adminhome),
    path('view_user',views.view_user),
    path('view_complaint',views.view_complaint),
    path('complaint_search',views.complaint_search),
    path('view_feedback',views.view_feedback),
    path('feedback_search',views.feedback_search),
    path('view_blockandunblock', views.view_blockandunblock),
    path('search_user_block', views.search_user_block),
    path('login_btnclk', views.login_btnclk),
    path('block_user/<id>', views.block_user),
    path('unblock_user/<id>', views.unblock_user),
    path('send_reply/<id>',views.send_reply),
    path('edit_reply/<id>',views.edit_reply),
    path('edit_reply_post',views.edit_reply_post),
    path('send_reply_post',views.send_reply_post),
    path('change_pswd',views.change_pswd),
    path('change_PWD',views.change_PWD),
    path('android_login', views.android_login),
    path('user_register',views.user_register),
    path('user_complaint',views.user_complaint),
    path('user_post',views.user_post),
    path('user_comments',views.user_comments),
    path('user_feedback',views.user_feedback),
    path('admin_viewpost',views.admin_viewpost),
    path('view_users',views.view_users),
    path('send_request',views.send_request),


    path('user_sent_feedback',views.user_sent_feedback),
    path('user_view_complaint',views.user_view_complaint),
    path('view_accepted_friend_requests',views.view_accepted_friend_requests),
    path('view_friends_req',views.view_friends_req),
    path('and_accept_friendrequest',views.and_accept_friendrequest),
    path('and_reject_friendrequest',views.and_reject_friendrequest),
    path('user_viewchat',views.user_viewchat),
    path('view_profile',views.view_profile),
    path('edit_profile',views.edit_profile),
    path('user_sendchat',views.user_sendchat),
    path('viewfrdrequest',views.viewfrdrequest),
    path('user_view_own_friend_request',views.user_view_own_friend_request),
    path('and_change_password_post',views.and_change_password_post),
    path('forgot_password',views.forgot_password),
    path('generate_random_password',views.generate_random_password),
    path('view_post',views.view_post),
    path('add_post',views.add_post),
    path('comments/',views.add_comment),
    path('view_my_post',views.view_my_post),
    path('comments/<post_id>/',views.get_comments),

]
