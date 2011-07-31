From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RFC] Questions for "Git User's Survey 2011"
Date: Sun, 31 Jul 2011 16:53:54 +0300
Message-ID: <CAMP44s2CWvzKyBAskVRq6Vte-CyCKwxBCZbSw_mbp=4a6ngCOw@mail.gmail.com>
References: <201107252233.02088.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 31 15:54:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QnWSv-0000CH-Ij
	for gcvg-git-2@lo.gmane.org; Sun, 31 Jul 2011 15:54:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751584Ab1GaNx5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 31 Jul 2011 09:53:57 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:59618 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751392Ab1GaNx4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 31 Jul 2011 09:53:56 -0400
Received: by fxh19 with SMTP id 19so3707792fxh.19
        for <git@vger.kernel.org>; Sun, 31 Jul 2011 06:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=xj4+Gx58ZUIJyT8QcpnrZpUGF+y5UWXu6/kA9C0g104=;
        b=jE0DQH+6bldd++uD7HPZftJEJzFrQ/WbTeHaI9tqAyGpSxQ6cHLJoCA/Dv5BVHzj8M
         jjjiYvhc81Yj169l0f+K0+8CAIeSP+rrIQ5qaeizOXrE31zmsF9zljftVf1GYmsMBXrC
         diwhL5gZ7HBsPIOgeip1PbpU6H7wTC9IZqHVc=
Received: by 10.204.135.18 with SMTP id l18mr925283bkt.191.1312120434510; Sun,
 31 Jul 2011 06:53:54 -0700 (PDT)
Received: by 10.204.56.15 with HTTP; Sun, 31 Jul 2011 06:53:54 -0700 (PDT)
In-Reply-To: <201107252233.02088.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178257>

2011/7/25 Jakub Narebski <jnareb@gmail.com>:
> I am planning doing annual Git User's Survey, and I'd like to ask for
> feedback.

> =3D=3D=3D 16. Which of the following Git features do you use? =3D=3D=3D
> (multiple choice, with other)
>
> =C2=A0+ localization of command-line messages (i18n)
> =C2=A0+ git bundle (off-line transport)
>
> =C2=A0+ eol conversion (crlf or eol)
> =C2=A0+ gitattributes (any)
> =C2=A0+ custom diff/merge driver
> =C2=A0+ word diff
> =C2=A0+ merge strategy options (e.g. -Xrenormalize)
> =C2=A0+ textconv
>
> =C2=A0+ submodules (subprojects)
> =C2=A0+ subtree merge (optionally git-subtree)
>
> =C2=A0+ partial (sparse) checkout, or assume-unchanged bit
>
> =C2=A0+ separate worktree / core.worktree
> =C2=A0+ multiple worktrees (e.g. git-new-worktree)
> =C2=A0+ gitdir mechanism (.git file pointing to repository)
>
> =C2=A0+ alternates mechanism (sharing object database)
> =C2=A0+ stash (optionally "git stash --keep-index")
> =C2=A0+ shallow clone (e.g. "git clone --depth=3D<n>")
> =C2=A0+ detaching HEAD (e.g. "git checkout --detach")
> =C2=A0+ commit message templates
> =C2=A0+ interactive commit / per-hunk comitting / partial commit
> =C2=A0+ interactive rebase (small scale history editing)
> =C2=A0+ git-filter-branch or equivalent (large history rewriting)
> =C2=A0+ bisect (optionally "git bisect run <script>")
> =C2=A0+ tracking code movement with git-blame ("git blame -M" etc.)
> =C2=A0+ committing with dirty tree (keeping some changes uncommitted)
>
> =C2=A0+ non-default hooks (from contrib/hooks/ or other)
> =C2=A0+ shell completion of commands
> =C2=A0+ git-aware shell prompt
> =C2=A0+ git aliases, shell aliases for git, or own git scripts
>
> =C2=A0+ one-way interaction with other SCMs (from SCM to git)
> =C2=A0+ two-way interaction with other SCMs (from SCM to git, from gi=
t to SCM)
>
> =C2=A0+ git-cvsserver
> =C2=A0+ git notes
>
>
> =C2=A0+ Other, please specify
>
> NOTES:
> ^^^^^^
> The problem is come up not with exhaustive list of features: there ar=
e
> too many of them to list. =C2=A0The problem is coming up with list of
> important and used enough often features.
>
> So: what features should be included in this list? =C2=A0What feature=
s
> should be removed from above list of answers?

*staging*! I have suggested this multiple times, it should be here this=
 one!

- stage add / partial commit / interactive commit / per-hunk comitting
(e.g. git add -u/-i/-p)
+ stage / partial or interactive commits (e.g. git add -u/-i/-p, git
diff --cached)

> =3D=3D=3D 19. Overall, how happy are you with Git? =3D=3D=3D
> (single choice)
>
> =C2=A0* unhappy
> =C2=A0* not so happy
> =C2=A0* happy
> =C2=A0* very happy
> =C2=A0* completely ecstatic
>
> NOTES:
> ^^^^^^
> I'm not sure if this question is at all useful.
>
> There is also problem, that the current wording is considered biased
> by some, but on the other hand changing wording of answers would make
> it impossible to compare it to answers from previous surveys...

What wording would you use?

> =3D=3D=3D 20. In your opinion, which areas in Git need improvement? =3D=
=3D=3D
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Please state your preference.
> (matrix)
>
> =C2=A0 Columns: don't need / a little / some / much
> =C2=A0+ user-interface
> =C2=A0+ documentation
> =C2=A0+ performance
> =C2=A0+ more features
> =C2=A0+ tools (e.g. GUI)
> =C2=A0+ localization (translation)
>
> NOTES:
> ^^^^^^
> Are there any general areas that are missing from this list?
> What are they?

IDE integration, portability?

> =3D=3D About this survey. Open forum. =3D=3D
>
> =3D=3D=3D 26. How did you hear about this Git User's Survey? =3D=3D=3D
> (single choice, with other)
>
> =C2=A0* git mailing list
> =C2=A0* git-related mailing list (e.g. msysGit, Git for Human Beings)
> =C2=A0* mailing list or forum of some project
> =C2=A0* #git IRC channel topic
> =C2=A0* announcement on IRC channel
> =C2=A0* git homepage
> =C2=A0* git wiki
> =C2=A0* git hosting site (or blog related to such site)
> =C2=A0* software-related web site
> =C2=A0* news or social news site (e.g. Digg, Reddit)
> =C2=A0* blog (or blog planet)
> =C2=A0* other kind of web site
> =C2=A0* Twitter or other microblogging platform
>
> =C2=A0* other - please specify
>
> NOTES:
> ^^^^^^
> This list would of course be updated to reflect the list of (planned)
> announcement channels.
>
> There of course will be announcement on Git Mailing List, and perhaps
> also on msysGit list / Google Group, and on Git For Human Beings
> Google Group (if it exists). =C2=A0I'll announce it on #git, and ask =
op to
> put short announcement in channel description, and I can announce it
> on other IRC channels. =C2=A0I would add announcement to main page of=
 Git
> Wiki, and as Git Homepage administrator to put announcement about Git
> User's Survey.
>
> I usually tried to contact administrators of git hosting sites,
> including git.kernel.org, repo.or.cz, GitHub, Gitorious, Assembla,
> Codebase and Unfuddle, asking them to put announcement about
> Git User's Survey either somewhere on the site, or in their blog
> (if there is any). =C2=A0What git hosting sites it is worth to ask?

Google+ (maybe facebook).

> I would like to have announcement of Git User's Survey 2010 at
> LWN.net, but this would need to be send at least two weeks in advance=
,
> if I remember correctly. =C2=A0Is it worth it? =C2=A0What other news =
site should
> I (or you) send announcement to?
>
> If you can Digg / Reddit announcment on some site, please do. =C2=A0I=
 can
> announce Git User's Survey 2-1- at Twitter, Identi.ca and Plurk, but =
I
> don't have wide area of followers. =C2=A0So please RT.

I can post it on reddit :)

> Should we contact some bloggers (besides asking Junio to put
> announcement on his blog) to post an anouncement? =C2=A0Which blogger=
s
> would respond positively (perhaps Linus...)?

I can post it on gitlog. It looks like there are now many people checki=
ng it.

--=20
=46elipe Contreras
