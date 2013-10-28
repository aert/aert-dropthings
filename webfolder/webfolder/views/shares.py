from django.views.generic.base import TemplateView


class SharesView(TemplateView):
    template_name = 'webfolder/shares.html'

    def get_context_data(self, **kwargs):
        context = super(SharesView, self).get_context_data(**kwargs)
        return context
