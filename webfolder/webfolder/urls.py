from django.conf.urls import patterns, url
from django.core.urlresolvers import reverse_lazy
from django.views.generic import RedirectView
from .views.files import FilesView
from .views.files import FilesViewDetail
from .views.files import FilesViewNewFile
from .views.friends import FriendsView
from .views.shares import SharesView


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
)
