from django.views.generic.base import TemplateView


class FilesView(TemplateView):
    template_name = 'webfolder/files.html'

    def get_context_data(self, **kwargs):
        context = super(FilesView, self).get_context_data(**kwargs)
        return context


class FilesViewDetail(TemplateView):
    template_name = 'webfolder/files_detail.html'

    def get_context_data(self, **kwargs):
        context = super(FilesViewDetail, self).get_context_data(**kwargs)
        return context
