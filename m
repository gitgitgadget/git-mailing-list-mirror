From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] Git User's Survey 2009 - second trial run, and question  about announcing it
Date: Sun, 5 Jul 2009 00:40:20 +0200
Message-ID: <200907050040.21991.jnareb@gmail.com>
References: <200907030130.24417.jnareb@gmail.com> <94a0d4530907031619x3d1296eenf9198b4ab5e43f67@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 05 00:40:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MNDuS-0006bX-DW
	for gcvg-git-2@gmane.org; Sun, 05 Jul 2009 00:40:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752817AbZGDWk0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Jul 2009 18:40:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752704AbZGDWk0
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Jul 2009 18:40:26 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:52115 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752508AbZGDWkZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Jul 2009 18:40:25 -0400
Received: by fxm18 with SMTP id 18so2903963fxm.37
        for <git@vger.kernel.org>; Sat, 04 Jul 2009 15:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=YGnWHTPmGOE/dWn3ZfvvqKLbFUoiGzjk/MJPxt0iF+w=;
        b=EOZqieo4HHaoJCc/desGd4XZI7DqkmQc2cZHzJAC3T3Cfiq/TeQOT7mjqOv0I9IvlI
         3avVQT8Os8QcxwzpykxPdWzW7I6dyyWeiFQD0QSESBr8FCvQgIcpA4kquU+OEfSNM1CQ
         9gcDa9841QRLNFTawOqMSDQ+5uBG6gjApJn4A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=CNB5qYlCGI8LRyy8d4Q5Vlzd1thP0KW8ZuxxhcJsJOIFCZS5e/ewUeoXLgXe3n9z7x
         CnDouKsaSom5emSj9fhcC/1lACZu+rKjCFBtm2YmMIGjeyglsXc+jJ/wqDM1cn+/AK+N
         8axijha+7bJQbZUjECaoo51c91HYtp33raOvg=
Received: by 10.204.113.12 with SMTP id y12mr2819775bkp.214.1246747225938;
        Sat, 04 Jul 2009 15:40:25 -0700 (PDT)
Received: from ?192.168.1.13? (absh167.neoplus.adsl.tpnet.pl [83.8.127.167])
        by mx.google.com with ESMTPS id 21sm8838751fkx.44.2009.07.04.15.40.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 04 Jul 2009 15:40:24 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <94a0d4530907031619x3d1296eenf9198b4ab5e43f67@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122730>

On Sat, 4 July 2009, Felipe Contreras wrote:
> 2009/7/3 Jakub Narebski <jnareb@gmail.com>:

> > The last replacements reminds me of the problem of announcing this
> > survey.  Where to submit note announcing "Git User's Survey 2009"
> > (tentative date of survey is 15 July 2009 -- 15 September 2009)?
> > How such note should look like?
> 
> I'm not sure what you mean. I think the best place to announce these
> kinds of things is through a post in an official blog.

The problem is that there isn't "official blog" for Git.  There is
gitster's (Junio C Hamano, git maintainer) blog at
  http://gitster.livejournal.com/
there is yours 'A git blog looking to be official' at
  http://gitlog.wordpress.com/

Let me quote appropriate question from "Git User's Survey 2009" which
lists possible announcement mechanisms I did think of:

  29. How did you hear about this Git User's Survey?
    * git mailing list
    * git-related mailing list (msysGit, Git for Human Beings, ...)
    * mailing list or forum of some project
    * #git IRC channel topic
    * announcement on IRC channel
    * git homepage
    * git wiki
    * git hosting site
    * software-related web site
    * news web site or social news site
    * blog
    * other kind of web site
    * Twitter or other microblogging platform
    * other - please specify

I will send announcement to Git mailing list (i.e. here) using
"[ANNOUNCE]" in email subject, which means that 'GIT Mailing List
RSS Feeds' script would pick it up for 'announce' feed
  http://gitrss.q42.co.uk/announce.rss
which means that Ohloh would have it in "News" section for Git project:
  http://www.ohloh.net/p/git
(and it is easy to add announcement in "Journal Entries" at Ohloh).

I can add announcement about Git User's Survey 2009 at Git Wiki and
create page about it at
  http://git.or.cz/gitwiki/GitSurvey2009
I can ask Scott Chacon to put announcement on Git Homepage at
  http://git-scm.com

What other places to ask to put note about this survey?  For past
surveys I was sending announcement to mailing list of projects using
git (http://git.or.cz/gitwiki/GitProjects)... well, at least those
which didn't require subscribing to mailing list before postiting on
it (and even that for some cases can be worked around by sending
announcement via GMane).  But with number of projects using git so
large nowadays I don't think it is good approach...

> > 8. How do/did you obtain Git (install and/or upgrade)?
> >    * binary package (includes automatic updates in usual situation)
> >    * source package or script
> >    * source tarball
> >    * pull from (main) repository
> >
> > Explanation: binary package covers pre-compiled binary (e.g. from rpm
> > or deb binary packages); source package covers things like deb-src and
> > SRPMS/src.rpm; source script is meant to cover installation in
> > source-based distributions, like 'emerge' in Gentoo, and it includes
> > automatic update in source-based Linux distributions.
> >
> > Note that this question is multiple choices question because one can
> > install Git in different ways on different machines or on different
> > operating systems.
> 
> It's a bit complicated and missing some, how about:
> 8. How do/did you obtain Git?
>  * package management (apt, yum, etc.)
>  * binary package or installer (.deb, .exe) <-
>  * source package or script (deb-src, src.rpm)
>  * source tarball
>  * pull from (main) repository

It might be better formulation.  Currently updates using automatic 
updates (apt, yum, YaST, Package Manager) is split into two: binary
package for distributions using binary packages for update (most 
distributions: Ubuntu, Debian, Fedora, SuSE) and source package for
source based distributions (like Gentoo or Sourcemage).

I will think about it (and about adding "sysadmin job" answer too).

> - 9. What operating system do you use Git on?
> + 9. On which operating system(s) do you use Git?

Thanks, this is better.

> 
> - 13. Which git hosting site do you use for your projects?
> + 13. Which hosting site(s) do you use for your projects?

Well, on one hand side among possible answers there is "generic site
without git support".  On the other hand this question is about where
you host your projects that you use git for.

I think I'll leave "git" in question, but use "site(s)".

> > 20. Overall, how happy are you with Git?
> >    * unhappy
> >    * not so happy
> >    * happy
> >    * very happy
> >    * completely ecstatic
> 
> Let's leave room for git haters too:
>  * I hate it

Well, "I hate it" is "unhappy".  But on the other hand I'd like to have
here set of answers with 'neutral' in the middle, and symmetric around
this middle answer.  Perhaps:

    * unhappy
    * not so happy
    * average
    * somewhat happy
    * very happy

Also I agree with Junio that I'd rather git haters didn't answer this
survey...
 
> - 21. In you opinion, which areas in Git needs improvement?
> + 21. In you opinion, which areas of Git need improvement?
> 
> - 23. How do you compare current version with version from year ago?
> + 23. How do you compare the current version with the one from one year ago?

Thanks.
 
> > 25. Have you tried to get Git help from other people?
> > 26. What channel did you use to request help?
> > 27. If yes, did you get these problems resolved quickly and to your liking?
> 
> "If yes" on 27 is out of context:
> 
> - 25. Have you tried to get Git help from other people?
> + 25. Have you tried to get help regarding Git from other people?
> 26. If yes, did you get these problems resolved quickly and to your liking?
> 27. What channel did you use to request help?

Ooops.  I'll fix it.

> - 28. Which communication channels do you use?
> + 28. Which communication channel(s) do you use?

Thanks
 
> - 29. How did you heard about this Git User's Survey?
> + 29. How did you hear about this survey?

I'll fix grammar, but I'd leave "Git User's Survey" here.

> - 30. What other comments or suggestions do you have that are not
> covered by the questions above?
> + 30. Any other comments or suggestions?

Perhaps.


Thanks a lot for your review and comments!

-- 
Jakub Narebski
Poland
