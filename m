From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] Git User's Survey 2010 (resend)
Date: Wed, 07 Jul 2010 14:37:36 -0700 (PDT)
Message-ID: <m3k4p7m0sv.fsf@localhost.localdomain>
References: <201007032158.57700.jnareb@gmail.com>
	<loom.20100707T112304-178@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Yann Dirson <ydirson@free.fr>
X-From: git-owner@vger.kernel.org Wed Jul 07 23:37:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWcJO-0008RE-It
	for gcvg-git-2@lo.gmane.org; Wed, 07 Jul 2010 23:37:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756770Ab0GGVhl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jul 2010 17:37:41 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:58046 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755971Ab0GGVhj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jul 2010 17:37:39 -0400
Received: by fxm14 with SMTP id 14so52727fxm.19
        for <git@vger.kernel.org>; Wed, 07 Jul 2010 14:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=63MMLUjtSwUDMNUotSrM1+VT+gvnRz251O4PYPe9/cQ=;
        b=rImgL/YpFHRmw3OrJoXBQT+u4pe8JxNkU8UT8+pLnfdWsbAKH/xxieyB0DXYwHY4/u
         NhzJpyMjDNsASRikwJ6MbNjmC6Q3JUlAExU3LSga5yB+19t/8GJadv/YhEMC5l/uB2Ea
         ealUcRZyqBLIGV4heBedTZirKGl6OfNXeRbzs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=C5n7OVB3Ji2liEGVEDEOkVJPOFoaRJMgktjjrANygPwyTRlfRUMCkez0wtPeZzn2B5
         wWV9Ky67fwPRYSBFFYam5Qvo0YyFHqJI1TuIPV6vsMUzrGBCvkg+B3U6QG5aXuxfm4Ib
         ESmbTsNSRH76z1Ddt0P0P21FtA4tKFW2jbNco=
Received: by 10.223.109.84 with SMTP id i20mr6381986fap.86.1278538658295;
        Wed, 07 Jul 2010 14:37:38 -0700 (PDT)
Received: from localhost.localdomain (abvr9.neoplus.adsl.tpnet.pl [83.8.215.9])
        by mx.google.com with ESMTPS id 26sm5534071fax.31.2010.07.07.14.37.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 07 Jul 2010 14:37:36 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o67Lb78d002566;
	Wed, 7 Jul 2010 23:37:13 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o67Lan4t002553;
	Wed, 7 Jul 2010 23:36:49 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <loom.20100707T112304-178@post.gmane.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150508>

Yann Dirson <ydirson@free.fr> writes:
> Jakub Narebski <jnareb <at> gmail.com> writes:
> 
> > === 07. I use Git for (check all that apply): ===
> [...]
> >  + work projects
> >  + unpaid projects
> 
> "Unpaid" could be further split between personnal use, cooperating in
> public projects (includes "OSS development" below), working for NGO's
> and the like.

"Unpaid projects" simply means here not work (related).  I am not sure
if adding other options is worth it; I'd rather not have too many
possibile answers for a question.
 
> > === 08. How do/did you obtain Git (install and/or upgrade)? ===
> > (multiple choice, with other)
> [...]
> > Description:
> > ~~~~~~~~~~~~
> > Explanation: "binary package" covers pre-compiled binary (e.g.  from
> > rpm or deb binary packages); "source package" covers things like
> > deb-src and SRPMS / *.src.rpm; "source script" is meant to cover
> > installation in source-based distributions, like 'emerge' in Gentoo.
> 
> Do we care about particular binary packages, like distro-provided,
> distro backports, RPMs for kernel.org and similar "official as in
> listed on git-scm.org" packages, 3rd-party packages (maybe with
> "please specify").

No, I don't think we do worry about this.
 
> > === 09. On which operating system(s) do you use Git? ===
> [...]
> > OpenSolaris died, so I removed it.
> 
> It does not seem to have died, only "free-beer solaris" seems to -
> opensolaris.org still shows activity.  And even so, people may still
> have been using machines installed with it.

Nevertheless it's install base, as shown by previous surveys, is IMVHO
too small for it to have it as a separate option.
 
> > === 11. What Git interfaces and frontends do you use? ===
> [...]
> > The problem with split part is that people can have troubls with
> > distinguising between interfaces, implementations, frontends and tools
> > (although "I don't know ..."  answer should, I think, help here).  The
> > problem with having it everything together is that the list of
> > possible answers gets long and a bit unwieldy.
> 
> "interface" is confusing, as shown by the need for "I only use
> (graphical) tools".  Use "command-line interfaces and frontends"
> instead ?
 
That's a good idea.  Thanks.
 
> > === 12. What kind of Git tools do you use? ===
> > (multiple choice, with other)
> [...]
> >  + graphical blame or pickaxe tool
> 
> Mention gitk as example here ?

You meant here "git gui blame", didn't you?

> > === 16. Which of the following features do you use? ===
> > (multiple choice, with other)
> [...]
> >  + one-way interaction with other SCMs (from SCM to git)
> 
> One-way from git to other SCM ?  I'm sure we care if many people do that :)

One way from SCM to git.

> > === 17. Which of the following features would you like to see implemented in
> git? ===
> 
> + sophisticated diffcore stages (eg. directory rename, indent detection,
>   content move)

Thanks.

BTW. I think wholesame directory rename detection is one of proposed
features already.

> > What features should be mentioned besides those above?  What criteria
> > should we have for including features in this list?
> 
> Not sure if any reasonable idea that appeared on the list should be
> left out.  Answers would provide feedback for features not necessarily
> interesting to the average git@vger reader, but still appealing to our
> users.

I don't think ideas about _internal_ changes need to be here.  Also,
I do not remember _every_ feature proposel that appeared on the list...
 
> > === 22. How do you compare the current version with the version from one year
> ago? ===
> [...]
> > This question was mainly excuse for providing list of main changes
> > from the year ago.  I think that this question should be removed, as
> > it doesn't bring any important information.
> 
> It still says whether the work done on dev side is seen as valuable by
> end users.

Ego stroking ;-))))

I'm not sure if it is worth having this question.  If there were any
big controversial changes, perhaps...

> > === 23. How useful have you found the following forms of Git documentation? ===
> [...]
> >  + on-line help
> 
> Spell as "online" ?  At least I had difficulties to parse it :)
 
O.K.
 
> > === 28. How did you hear about this Git User's Survey? ===
> > (single choice, with other)
> 
> + relaying by co-workers bridging the team to the community

Hmmm... good catch.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
