From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 0/3] fixup remaining cvsimport tests
Date: Thu, 24 Jan 2013 04:15:50 +0100
Message-ID: <5100A766.8050902@alum.mit.edu>
References: <1357878439-27500-1-git-send-email-chris@rorvick.com> <20130120125838.GK31172@serenity.lan> <CAEUsAPZKd+mw2iK7nd6rTtB8N+B99ud19FkuSx0HVitNxrxxZA@mail.gmail.com> <20130120152857.GM31172@serenity.lan> <7vsj5vlm1d.fsf@alter.siamese.dyndns.org> <CAEUsAPaw8EUcZFbODDj9Z-=3Ppd1CC=jvYDvuyntFkX_3V0ynQ@mail.gmail.com> <50FFB35C.7070809@alum.mit.edu> <20130123110312.GK7498@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Chris Rorvick <chris@rorvick.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Thu Jan 24 04:16:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TyDIY-000886-TW
	for gcvg-git-2@plane.gmane.org; Thu, 24 Jan 2013 04:16:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753181Ab3AXDP6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jan 2013 22:15:58 -0500
Received: from ALUM-MAILSEC-SCANNER-5.MIT.EDU ([18.7.68.17]:63383 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752933Ab3AXDP4 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Jan 2013 22:15:56 -0500
X-AuditID: 12074411-b7fa36d0000008cc-e1-5100a76b6684
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id B3.02.02252.B67A0015; Wed, 23 Jan 2013 22:15:55 -0500 (EST)
Received: from [192.168.69.140] (p57A25B8E.dip.t-dialin.net [87.162.91.142])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r0O3FqCR009195
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 23 Jan 2013 22:15:54 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130106 Thunderbird/17.0.2
In-Reply-To: <20130123110312.GK7498@serenity.lan>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNKsWRmVeSWpSXmKPExsUixO6iqJu9nCHQoPGqicXOuftYLbqudDNZ
	NPReYba4cX4XqwOLx9lHD5g9Ll5S9th9mtXj8ya5AJYobpukxJKy4Mz0PH27BO6MJ/f3MhbM
	4q+YP+szWwPjEp4uRk4OCQETiemv+hkhbDGJC/fWs3UxcnEICVxmlDi+ZT8zhHOGSeLKjnss
	XYwcHLwC2hKvjhqDNLAIqEq0r/vPCmKzCehKLOppZgKxRQXCJHpfnwMbyisgKHFy5hMWEFsE
	qH7apxvsIGOYBdIlZj8SBQkLC1hI7Ni+mRViVRuzxPyfHWD1nAKGEltuXgebySygI/Gu7wEz
	hC0vsf3tHOYJjAKzkKyYhaRsFpKyBYzMqxjlEnNKc3VzEzNzilOTdYuTE/PyUot0TfVyM0v0
	UlNKNzFCgllwB+OMk3KHGAU4GJV4eKvVGQKFWBPLiitzDzFKcjApifImLgMK8SXlp1RmJBZn
	xBeV5qQWH2KU4GBWEuFVqwfK8aYkVlalFuXDpKQ5WJTEefmWqPsJCaQnlqRmp6YWpBbBZGU4
	OJQkeC1AhgoWpaanVqRl5pQgpJk4OEGGc0mJFKfmpaQWJZaWZMSDIjW+GBirICkeoL2WIO28
	xQWJuUBRiNZTjMYc+5+0P2fk2P4bSAqx5OXnpUqJ83qAlAqAlGaU5sEtgqWxV4ziQH8L84aC
	VPEAUyDcvFdAq5iAVu2f9T8AaFVJIkJKqoGxZ5a6o7bO+bkb7oQ1WGhmbkqR/FvDz2W+feIu
	5ri9p3MjXE/MvvuwZb9k+NlTkpmeJroJLTy7kqYlL+44YFHVo+vFO2/e0dZl4a3m 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214389>

On 01/23/2013 12:03 PM, John Keeping wrote:
> On Wed, Jan 23, 2013 at 10:54:36AM +0100, Michael Haggerty wrote:
>> On 01/20/2013 09:17 PM, Chris Rorvick wrote:
>>> I have never used cvs2git, but I suspect Eric's efforts in making it a
>>> potential backend for cvsimport are a better use of time.
> 
> Is it possible to perform an incremental import with cvs2git?  This
> seems to be the one use case where the old cvsimport script (with cvsps
> 2.x) still performs the best.
> 
> I suppose that just re-running the full import will do the right thing
> since the commits in Git should be identical, but would it be possible
> to do better given the right information about a previous run?

No, cvs2git does not support incremental imports.  One user has reported
that he *usually* gets identical commits for the overlapping history
when he re-runs a full import, and last I heard he was using this as a
kind of incremental import.  We make an effort to make imports
reproducible, at least when using a single version of cvs2git (for
example, we process things in deterministic order rather than the order
they happen come out of a file directory or Python hashmap).  But the
cycle-breaking heuristics in particular can give different results if
history is added, not to mention the fact that CVS allows the user to
make changes with retroactive and non-timestamped effects (e.g., adding
or removing files from an existing branch/tag, changing a file's default
branch from vendor to HEAD, changing the log messages of old revisions,
obsoleting revisions).  And if your repository is large, a full import
can take a while.

It would be possible to enhance cvs2git to handle incremental imports
(well, at least if you rule out a few CVS commands that change deep
history).  But I don't believe anybody is working on this.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
