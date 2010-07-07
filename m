From: Yann Dirson <ydirson@free.fr>
Subject: Re: [RFC] Git User's Survey 2010 (resend)
Date: Wed, 7 Jul 2010 12:28:46 +0000 (UTC)
Message-ID: <loom.20100707T112304-178@post.gmane.org>
References: <201007032158.57700.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 07 14:29:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWTkR-00023Y-LB
	for gcvg-git-2@lo.gmane.org; Wed, 07 Jul 2010 14:29:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754825Ab0GGM3A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jul 2010 08:29:00 -0400
Received: from lo.gmane.org ([80.91.229.12]:60306 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752438Ab0GGM3A (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jul 2010 08:29:00 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1OWTkF-0001wC-1C
	for git@vger.kernel.org; Wed, 07 Jul 2010 14:28:55 +0200
Received: from host.1.68.26.195.rev.coltfrance.com ([host.1.68.26.195.rev.coltfrance.com])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 07 Jul 2010 14:28:55 +0200
Received: from ydirson by host.1.68.26.195.rev.coltfrance.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 07 Jul 2010 14:28:55 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 195.68.26.1 (Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.4) Gecko/20100628 Iceweasel/3.6.4 (like Firefox/3.6.4))
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150466>

Jakub Narebski <jnareb <at> gmail.com> writes:

> === 07. I use Git for (check all that apply): ===
[...]
>  + work projects
>  + unpaid projects

"Unpaid" could be further split between personnal use, cooperating in
public projects (includes "OSS development" below), working for NGO's
and the like.

> === 08. How do/did you obtain Git (install and/or upgrade)? ===
> (multiple choice, with other)
[...]
> Description:
> ~~~~~~~~~~~~
> Explanation: "binary package" covers pre-compiled binary (e.g.  from
> rpm or deb binary packages); "source package" covers things like
> deb-src and SRPMS / *.src.rpm; "source script" is meant to cover
> installation in source-based distributions, like 'emerge' in Gentoo.

Do we care about particular binary packages, like distro-provided,
distro backports, RPMs for kernel.org and similar "official as in
listed on git-scm.org" packages, 3rd-party packages (maybe with
"please specify").

> === 09. On which operating system(s) do you use Git? ===
[...]
> OpenSolaris died, so I removed it.

It does not seem to have died, only "free-beer solaris" seems to -
opensolaris.org still shows activity.  And even so, people may still
have been using machines installed with it.


> === 11. What Git interfaces and frontends do you use? ===
[...]
> The problem with split part is that people can have troubls with
> distinguising between interfaces, implementations, frontends and tools
> (although "I don't know ..."  answer should, I think, help here).  The
> problem with having it everything together is that the list of
> possible answers gets long and a bit unwieldy.

"interface" is confusing, as shown by the need for "I only use
(graphical) tools".  Use "command-line interfaces and frontends"
instead ?


> === 12. What kind of Git tools do you use? ===
> (multiple choice, with other)
[...]
>  + graphical blame or pickaxe tool

Mention gitk as example here ?

> === 16. Which of the following features do you use? ===
> (multiple choice, with other)
[...]
>  + one-way interaction with other SCMs (from SCM to git)

One-way from git to other SCM ?  I'm sure we care if many people do that :)

> === 17. Which of the following features would you like to see implemented in
git? ===

+ sophisticated diffcore stages (eg. directory rename, indent detection,
  content move)

> What features should be mentioned besides those above?  What criteria
> should we have for including features in this list?

Not sure if any reasonable idea that appeared on the list should be
left out.  Answers would provide feedback for features not necessarily
interesting to the average git@vger reader, but still appealing to our
users.


> === 22. How do you compare the current version with the version from one year
ago? ===
[...]
> This question was mainly excuse for providing list of main changes
> from the year ago.  I think that this question should be removed, as
> it doesn't bring any important information.

It still says whether the work done on dev side is seen as valuable by
end users.

> === 23. How useful have you found the following forms of Git documentation? ===
[...]
>  + on-line help

Spell as "online" ?  At least I had difficulties to parse it :)


> === 28. How did you hear about this Git User's Survey? ===
> (single choice, with other)

+ relaying by co-workers bridging the team to the community

HTH,
-- 
Yann
