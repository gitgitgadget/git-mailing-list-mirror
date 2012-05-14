From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Index format v5
Date: Mon, 14 May 2012 23:08:58 +0200
Message-ID: <4FB1746A.6090408@alum.mit.edu>
References: <CALgYhfMKdbv8TiT4ALDSvD3pSXHEPLWHM09DxYnRmRdBWRjh8Q@mail.gmail.com> <4FA7E703.7040408@alum.mit.edu> <20120508141137.GA3937@tgummerer.surfnet.iacbox> <4FAA2CAF.3040408@alum.mit.edu> <20120510121911.GB98491@tgummerer> <4FAC0633.90809@alum.mit.edu> <20120511171230.GA2107@tgummerer> <4FB01080.6010605@alum.mit.edu> <20120514150113.GD2107@tgummerer>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, trast@student.ethz.ch, gitster@pobox.com,
	peff@peff.net, spearce@spearce.org, davidbarr@google.com
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 14 23:16:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SU2cq-0002te-9w
	for gcvg-git-2@plane.gmane.org; Mon, 14 May 2012 23:16:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758038Ab2ENVQK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 May 2012 17:16:10 -0400
Received: from ALUM-MAILSEC-SCANNER-4.MIT.EDU ([18.7.68.15]:62055 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757747Ab2ENVQJ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 May 2012 17:16:09 -0400
X-Greylist: delayed 422 seconds by postgrey-1.27 at vger.kernel.org; Mon, 14 May 2012 17:16:09 EDT
X-AuditID: 1207440f-b7fe16d000000920-cd-4fb17472426d
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 27.F6.02336.27471BF4; Mon, 14 May 2012 17:09:06 -0400 (EDT)
Received: from [192.168.69.140] (p4FC0CFBD.dip.t-dialin.net [79.192.207.189])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q4EL8xLO018905
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 14 May 2012 17:09:02 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:12.0) Gecko/20120430 Thunderbird/12.0.1
In-Reply-To: <20120514150113.GD2107@tgummerer>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOKsWRmVeSWpSXmKPExsUixO6iqFtUstHfYEW3pcWjk5uZLLqudDNZ
	NPReYbb40dLDbDH/0ERWiwurb7NbrNy1kMmB3WPnrLvsHgs2lXo8693D6HHxkrLHn/N7WD3m
	flrE6vF5k1wAexS3TVJiSVlwZnqevl0Cd8bZ5h+sBRs0KtYeXMnUwLhRvouRk0NCwERi38sd
	bBC2mMSFe+uBbC4OIYHLjBI3zx1ghnDOMkmc33CVHaSKV0BboufAfWYQm0VAVaLp3E4wm01A
	V2JRTzNTFyMHh6hAmMTqBxoQ5YISJ2c+YQGxRQS0JCZ97WMFsZkFWhglXs+LACkXFpCR2LDe
	C2LVMyaJnzfawWo4BfQk1s+ayQJSwyxgLfFtdxFEq7zE9rdzmCcwCsxCsmEWQtUsJFULGJlX
	Mcol5pTm6uYmZuYUpybrFicn5uWlFuma6OVmluilppRuYoREAf8Oxq71MocYBTgYlXh4X5pu
	8BdiTSwrrsw9xCjJwaQkyqtVvNFfiC8pP6UyI7E4I76oNCe1+BCjBAezkghvuRpQjjclsbIq
	tSgfJiXNwaIkzqu+RN1PSCA9sSQ1OzW1ILUIJivDwaEkwfsIZKhgUWp6akVaZk4JQpqJgxNk
	OJeUSHFqXkpqUWJpSUY8KErji4FxCpLiAdp7BqSdt7ggMRcoCtF6itGY48/DRdcYOWZ8ApJC
	LHn5ealS4ryXQEoFQEozSvPgFsHS3ytGcaC/hXkvgFTxAFMn3LxXQKuYgFbxC6wDWVWSiJCS
	amBUCGBKPXf8d+yDgn3LN+a+PRqw6tEOW9VQp66ASQcPfg1hWCWvs698XduNkqQz 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197812>

On 05/14/2012 05:01 PM, Thomas Gummerer wrote:
> Thanks a lot for your feedback. I've now refactored the code and
> thanks to your suggestions hopefully made it simpler and easier
> to read. The reader should now read exactly the data from the
> spec.

Yes, the style is much better now.  Here is the next round of feedback:

1. f is still a global variable.  This is unnecessary.

2. read_name() is indented incorrectly.

3. The signature and version number should be checked within 
read_header() *before* reading anything else.  Otherwise, if some random 
file is given to the script, it will read some random, probably very 
large number for "nextensions" and then try to read that number of 
extension offsets into RAM.  It would be a pretty innocent error to have 
the wrong version of the index file lying around, and the script should 
detect such an error quickly and painlessly rather than triggering a lot 
of pointless disk activity (and likely an out-of-memory error) before 
figuring out that it shouldn't be reading the file in the first place.

4. For readability reasons, it is better to raise an exception 
immediately in an error situation rather than put the error-handling 
code in the "else" part of an if statement; i.e., instead of

     if not error_condition:
         non-error-actions
     else:
         raise exception

use

     if error_condition:
         raise exception

     non-error-actions

The reasons are: (a) the reader can see immediately what will happen in 
the error case, then forget it and continue on with the "normal" flow 
instead of having to remember the "if" condition through the whole long 
"then" block before finally seeing the point in the "else" block; (b) 
then the "normal" case doesn't have to be within the if statement at 
all, thereby requiring less block nesting and less indentation.  For 
example:

> -    if crc == datacrc:
> -        return dict(signature=signature, vnr=vnr, ndir=ndir, nfile=nfile,
> -                nextensions=nextensions, extoffsets=extoffsets)
> -    else:
> -        raise Exception("Wrong header crc")
> +    if crc != datacrc:
> +        raise Exception("Wrong header crc")
> +
> +    return dict(signature=signature, vnr=vnr, ndir=ndir, nfile=nfile,
> +                nextensions=nextensions, extoffsets=extoffsets)

5. If the first limit of a range() or xrange() is zero, it is usually 
omitted; e.g., "xrange(0, nextensions)" -> "xrange(nextensions)".

6. It is possible to precompile "struct" patterns, which should be 
faster and also allows you to ask the Struct object its size, reducing 
the number of magic numbers needed in the code.  And fixed-length 
strings can also be read via struct.  For example:

> DIR_DATA_STRUCT = struct.Struct("!HIIIIII 20s")
>
>
> def read_dirs(f, ndir):
>     dirs = list()
>     for i in xrange(0, ndir):
>         (pathname, partialcrc) = read_name(f)
>
>         (filedata, partialcrc) = read_calc_crc(f, DIR_DATA_STRUCT.size, partialcrc)
>         (flags, foffset, cr, ncr, nsubtrees, nfiles,
>                 nentries, objname) = DIR_DATA_STRUCT.unpack(filedata)
>     # ...

7. The "if dirnr == 0" stuff in read_files() should probably be done in 
read_index_entries() (the first invocation is the only place dirnr==0, 
right?)

8. read_files() only returns a result "if len(directories) > dirnr". 
But actually I don't see the purpose for the check.  Earlier in the 
function you dereference directories[dirnr] several times, so it *must* 
be that dirnr < len(directories).  I think you can take out this test 
and unindent its block.

9. read_files() doesn't need to return "entries".  Since entries is an 
array that is only mutated in place, the return value will always be the 
same as the "entries" argument (albeit fuller).

10. It would make sense to extract a function read_file(), which reads a 
single file entry from the current position in the current file (using 
code from read_files()).  Similarly for read_dir()/read_dirs().

11. It is good form to move the file-level code into a main() function, 
then call that from the bottom of the file, something like this:

 > def main(args):
 >     ....
 >
 > main(sys.argv[1:])

This avoids creating global variables that are accidentally used within 
functions.


What is your plan for testing this code, and later the C version?  For 
example, you might want to have a suite of index files with various 
contents, and compare the "git ls-files --debug" output with the output 
that is expected.  How would you create index files like this?  Via git 
commands?  Or should one of your Python scripts be taught how to do it?

To make testing easier, you probably don't want to hard-code the name of 
the input file in git-read-index-v5.py, so that you can use it to read 
arbitrary files.  For example, you might want to honor the 
GIT_INDEX_FILES environment variable in some form, or to take the name 
of the index file as a command-line argument.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
