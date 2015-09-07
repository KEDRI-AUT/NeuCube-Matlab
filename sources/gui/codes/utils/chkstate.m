        if show_progress_bar && ~ishandle(hbar)
            output_information('User terminated!',handles);
            set(gcf,'pointer','arrow');
            error('User terminated!');
        end