from django.conf.urls import patterns, url, include
from django.core.urlresolvers import reverse_lazy
from django.views.generic import RedirectView
from .views.files import FilesView
from .views.files import FilesViewDetail
from .views.files import FilesViewNewFile
from .views.friends import FriendsView
from .views.shares import SharesView
from .views.account import AccountDetailView
from .views.account import AccountLogoutView
from .views.account import AccountLoginView

from django.contrib import admin
admin.autodiscover()

urlpatterns = patterns(
    'webfolder.views',
    url(r'^$', RedirectView.as_view(url=reverse_lazy('files'))),
    url(r'^activity$', FilesView.as_view(), name='files'),
    url(r'^activity/(?P<id>\d+)/$', FilesViewDetail.as_view(),
        name='files-detail'),
    url(r'^shares$', SharesView.as_view(), name='shares'),
    url(r'^friends$', FriendsView.as_view(), name='friends'),

    # New...
    url(r'^activity/new-file$', FilesViewNewFile.as_view(), name='files-new'),

    # Account
    url(r'^account/(?P<pk>\d+)/$', AccountDetailView.as_view(), name='account-detail'),
    url(r'^logout$', AccountLogoutView.as_view(), name='account-logout'),
    url(r'^login$', AccountLoginView.as_view(), name='account-login'),
    
    # Admin
    url(r'^admin', include(admin.site.urls)),
)
