function [] = delete_line_from_file( filepath , line_numbers )

    n_rm_lines = length( line_numbers );

    if( n_rm_lines > 1 ) 
       
        for k=n_rm_lines:-1:1
            delete_line_from_file( filepath , line_numbers(k) );
        end
        
    else
        
        
        [pathstr, file, ext] = fileparts(filepath);
        backfile = fullfile(pathstr, [file '.bak']);
        if strcmp(filepath, backfile)
          error('I refuse to edit a backup file! Nothing has been changed.');
        end
        outfile = tempname;   %a temporary file in TMP directory
        fin = fopen(filepath, 'r');
        if fin < 0; error('Input file does not exist'); end 
        fout = fopen(outfile, 'w');
        if fout < 0
          fclose(fin);
          error('Could not open temporary output file');
        end
        %read lines before the one to be deleted and write them to output
        for K = 1 : line_numbers - 1;
          inline = fgets(fin);
          if ~ischar(inline); break; end;  %end of file?
          fwrite(fout, inline);
        end

        if ~ischar(inline); end   %in case EOF
        inline = fgets(fin);      %and do nothing with it

        %copy all remaining input lines to output file
        while ischar(inline)
          inline = fgets(fin);
          if ischar(inline)   %not if we hit EOF
            fwrite(fout, inline);
          end
        end
        fclose(fin);
        fclose(fout);
        %M'Kay, we did the copying and have a file with the desired
        %result. Now put it in the proper place
        [status,MESSAGE,MESSAGEID] = movefile(filepath, backfile);
        if ~status
          if strcmp(filepath, backfile)
            fprintf(2, 'Good thing your programmer is paranoid about people overriding\nsanity checks, because something went wrong and you nearly lost your file!\n');
          else
            delete(backfile);
          end
          error('Could not rename file to .bak, file left untouched');
        else
          status = movefile(outfile, filepath);
          if ~status
            error( ['Could not rename temp file to original name, original moved to ', backfile]);
          end
        end
    end

end