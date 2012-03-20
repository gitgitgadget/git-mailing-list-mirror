From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Git and Google Summer of Code 2012
Date: Tue, 20 Mar 2012 16:37:10 +0100
Message-ID: <201203201637.10417.jnareb@gmail.com>
References: <001636c5c21b02c35904bba0ff9a@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "=?iso-8859-2?q?Andr=E9?= Walker" <andre@andrewalker.net>
X-From: git-owner@vger.kernel.org Tue Mar 20 16:37:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SA17j-0000Og-Cj
	for gcvg-git-2@plane.gmane.org; Tue, 20 Mar 2012 16:37:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757076Ab2CTPhQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Mar 2012 11:37:16 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:47895 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755919Ab2CTPhO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Mar 2012 11:37:14 -0400
Received: by wibhq7 with SMTP id hq7so237523wib.1
        for <git@vger.kernel.org>; Tue, 20 Mar 2012 08:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=IESEOnyaOx44U1G1083ZQApeU64G/eichoPXd6+R5xE=;
        b=n56K4VP+2wYqEJAsv8CyeOP2LMVHr62QzJETC5qFwNk3em9en+SdkaimwdJWI1ibDt
         a0/wPlwzRUOV0Uv0nkKv7fzXD+IlSb9ARBgcOs5+9ZWK523jcMb3AycxRGlxwKaSj7EM
         czBHN6qJpV5RyKgYvEaaZgXnQm6MDRKQ6MkoWLmvmGSm/GNP6lfPNHyeZ0tPJ1vd55HH
         txGXj3vXRbwNz/FhMKFzv4KZr4RM6+evAU+REpWUI4olCObXRWzeLw2SjsMg9jzpgDxg
         fb1cVHjzelMTfDoueH+BCfiTaoHTuJErIZNgi9kwYkCLLExqT3M6/GoEniCXuVCwp2MF
         LuGg==
Received: by 10.180.83.72 with SMTP id o8mr873972wiy.5.1332257832355;
        Tue, 20 Mar 2012 08:37:12 -0700 (PDT)
Received: from [192.168.1.13] (abvw11.neoplus.adsl.tpnet.pl. [83.8.220.11])
        by mx.google.com with ESMTPS id 17sm16564285wis.0.2012.03.20.08.37.11
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 20 Mar 2012 08:37:11 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <001636c5c21b02c35904bba0ff9a@google.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193514>

On Tue, 20 Mar 2012, Andr=E9 Walker wrote:

> Hello Jakub, I tweeted to you, but as your last tweet was from Januar=
y, I'm =20
> guessing here [personal email via Google Profile] is probably a bette=
r
> place to talk.

Actually the discussion of GSoC project application ideas with mentorin=
g
organization[1] should take place in the open, on git mailing list,
git@vger.kernel.org.  (You don't need to be subscribed to send email to
it, and there is custom on this mailing list of Cc-ing all people
participating in discussion; you can read git mailing list via other
interfaces e.g. via GMane.)

Perhaps this should be stated more clearly, for example in application
template[2].

[1]: http://www.google-melange.com/gsoc/events/google/gsoc2012
[2]: https://github.com/peff/git/wiki/SoC-2012-Template

> I'm a Computer Science student from a Brazilian university, and I
> have participated in GSoC last year with The Perl Foundation.
>
> I reworked the Catalyst MVC framework to use an Inversion of Control
> framework called Bread::Board instead of it's home grown component
> loading system. I was supposed to continue my work on it this year,
> we were going to release Catalyst v6.0 with it, but TPF was not  =20
> accepted in GSoC. I guess we'll have to ship it without GSoC then.
>
> Anyhow, I'd like to participate in it again this year, even if not =20
> continuing what I began last year. Preferably using Perl, but I guess=
 I =20
> could try something different. And looking in the accepted orgs for G=
SoC, =20
> Git seemed a very cool option, I'd be very honored to work on it. I u=
se git =20
> on most of my projects, but I have never delved in it's code.
>
> From the ideas page, I got interested in two items: "Modernizing and
> expanding Git.pm", and "Linus's ultimate content tracking tool".
> To be honest, the latter sounded awesome! But I don't know if I could
> be able to pull it off, as I don't know how complex it would be.

=46rom what I understand "Linus's ultimate content tracking tool" is
rather a sketch of an idea, rather than concrete project proposal.
You would have to carve a project from this proposal yourself.

> I'd be willing to try though, if I could talk to the relevant people,
> understand how the implementation would work, etc.

People on git mailing list could help there, perhaps starting with
person that suggested it.

> And, well, in the first one (Modernizing Git.pm) they pointed  =20
> you as a possible mentor, so I'd like to know. First, how much of Git=
 is =20
> actually in Perl? In other words, how much of it is implemented in Gi=
t.pm =20
> and related modules, or who would use it exactly?=20

There are quite a few git commands implemented in Perl, and there were
even more before "builtin-ification" of git code (moving to C).  Those
include the interactive part of git-add (git-add--interactive helper),
git-cvsimport, git-cvsserver and git-svn, git-send-email, git-difftool
and gitweb.  Not all of those use Git.pm module (git-cvsimport,=20
git-cvsserver and gitweb do not); changing this might be part of GSoC
project.

Git.pm currently does mainly cover safe and portable (ActiveState Perl)
invoking of git commands, and a bit of converting / translating
output to Perl (e.g. config_bool() method).

It is by no means complete; some of code could be refactored and moved
from individual commands to Git.pm module.

> Also, why is it not on CPAN? Wouldn't it be useful to other people to
> write interfaces in Perl for Git?

It is not on CPAN probably because Git Development Community lack(s|ed)
a Perl hacker, having only Perl dabblers ;-P

More seriously, putting Git.pm on CPAN might be a part of this GSoC
project.  Not that CPAN lacks git modules: Git::Class, Git::PurePerl,
Git::Repository, Git::Wrapper, Git::XS (libgit2 based)...

Note however that Git.pm must (in my opinion) remain "dual lived" modul=
e,
i.e. reside in git.git repository and be installable alongside git
with nothing but git sources.  This also means that any extra non-core
(or even not installed by default with "perl" package) modules that
Git.pm requires to work need to have copy in git.git repository just
like private-Error.pm (should be 'inc/Error.pm') does currently.

Git.pm might ultimately be put in separate repository, and subtree-merg=
ed
into git.git like git-gui and gitk subsystems (or as submodule), but th=
at
would require having real maintainer for this module.

> It mentions replacing Error and Error::Simple for Try::Tiny and  =20
> Exception::Class. What else should be modernized? And where else is t=
here =20
> room for expansion?

You could borrow from IPC::Run, Capture::Tiny and similar modules to ma=
ke
it possible to capture stderr of git commands to separate string or
separate filehandle, or just silencing stderr completely.  Perhaps even
allowing creating pipelines.

You could polish and modernize Git::Object, Git::Commit, Git::Tag,
Git::Repo and Git::RepoRoot from GSoC 2008 project[2], and add similar
modules for other concepts: diff (tree level and patchset level), tree
(directory), refs and refspec, etc.  All those with tests.

[2]: git://repo.or.cz/git/gitweb-caching.git
     http://repo.or.cz/w/git/gitweb-caching.git (gitweb)

You could separate somehow the idea of git commands that do not
require repository like "git version" or "git config --file", or
"git init" (Git::Cmd?), those that require repository but not working
area like "git log" or "git show" (Git::Repo?), and those that require
working area like "git status" or "git pull" (Git::Repo::Workdir?).

You could, for example based on existing gitweb code, create Git::Confi=
g
module that would read all configuration at once with `git config -l`,
and not use one git command for one variable like current $git->config(=
)
does.

You could create interfaces to persistent "git cat-file --batch",
"git cat-file --batch-check" and "git diff-tree --stdin".  IIRC gsoc200=
8
project includes something like that.


And of course borrow^W steal interesting parts of Git::* modules
available on CPAN.

> Do you think we could unite both projects, or it would  =20
> be too much work? And if you're not the person I should be asking abo=
ut the =20
> content tracking tool, could you point me to that person?

I think it might be too much work, though prototyping "Linus's ultimate
content tracking tool" in Perl might be good idea...

HTH
--=20
Jakub Narebski
Poland
