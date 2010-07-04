From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] Git User's Survey 2010 (resend)
Date: Sun, 4 Jul 2010 10:13:35 +0200
Message-ID: <201007041013.40563.jnareb@gmail.com>
References: <201007032158.57700.jnareb@gmail.com> <AANLkTilD8N6rnj9e3KzRB7_q3J0I4cJGx5EduX_UJScC@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
	<avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 04 10:14:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OVKLL-0003I8-JA
	for gcvg-git-2@lo.gmane.org; Sun, 04 Jul 2010 10:14:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756778Ab0GDIOC convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 4 Jul 2010 04:14:02 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:60384 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754911Ab0GDIN5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Jul 2010 04:13:57 -0400
Received: by fxm14 with SMTP id 14so3082727fxm.19
        for <git@vger.kernel.org>; Sun, 04 Jul 2010 01:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=O7DVCt51xIFNEqg2j5tsqHsaCbAcIn4EHF7Ijgem7+U=;
        b=bNN5D+8XL4JwI/ePKikYvAaIA/qM86kUqnKar1SHxrCfDl4yrLQfsu2jGfIRCIJfgd
         xOhw+lbm9TRuibTVzEKYxDN4IVN2O6vj/Z6WnOgjnHdI8RZ66GG0U5KZxx/9XJNrbNkH
         FAGjnv3PeF68qgsSYUC3+2ENuR2uhNe28mKhY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=dbv1SL0XN91kDXvkwS/Sgg569Ph839wD37t1oBEExXgoUhyAiuB9sK/xuTYS2Qxeke
         Nt9HNiJIspNUvP+zpS5QnCdfRiOoTbpf2kUoGigO/GLTlLMXNftWTpZkfCq7LddAQABT
         6rL2srsE/v1k1Xlv2OL7hAF7ZKdimG9ziqQ60=
Received: by 10.223.118.6 with SMTP id t6mr922882faq.21.1278231235422;
        Sun, 04 Jul 2010 01:13:55 -0700 (PDT)
Received: from [192.168.1.15] (abvt37.neoplus.adsl.tpnet.pl [83.8.217.37])
        by mx.google.com with ESMTPS id b18sm6010069fab.11.2010.07.04.01.13.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 04 Jul 2010 01:13:54 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <AANLkTilD8N6rnj9e3KzRB7_q3J0I4cJGx5EduX_UJScC@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150218>

On Sun, 4 Jul 2010, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> 2010/7/3 Jakub Narebski <jnareb@gmail.com>:

[...]
> > =3D=3D Getting started with Git =3D=3D
> >
> > =3D=3D=3D 03. Have you found Git easy to learn? =3D=3D=3D
> > (single choice)
> >
> > * Very easy
> > * Easy
> > * Reasonably easy
> > * Hard
> > * Very hard
> >
> > =3D=3D=3D 04. Have you found Git easy to use? =3D=3D=3D
> > (single choice)
> >
> > * Very easy
> > * Easy
> > * Reasonably easy
> > * Hard
> > * Very hard
> >
> > NOTES:
> > ^^^^^^
> > Those two questions, considered alone, doesn't tell us much. =C2=A0=
If one use
> > git, then usually one does not think it is too hard to use (unless =
forced to
> > use git by external circumstances, like project he/she works on usi=
ng git).
> > On the other hand those two questions together give us some mesaure=
 of git
> > learning curve, telling us if people consider git easy to use but h=
ard to
> > learn, or vice versa ;-)
> >
> > I think it might be also good to have to calculate correlations, e.=
g. if
> > people who find git hard to use make use of its advanced features.
> >
> > The question is: should they stay, or should they go?
>=20
> They should probably stay. But they don't really ask the right
> question IMO. Which is not whether users think it's difficult to
> learn, but whether it's unreasonably difficult for the problem they'r=
e
> solving.
>=20
> I.e. jet aircraft are hard to operate, but they also do neat
> stuff. How hard is Git to learn for the problem it's solving?

The problem is how to formulate question about this issue.  We cannot
really ask about perceived accidental and essential (inherent)
complexity, can we?

Perhaps something like this:

=3D=3D=3D xx. Have you found distributed version control easy? =3D=3D=3D
(multiple choice)

 + Very easy
 + Easy
 + Reasonably easy
 + Hard
 + Very hard

Or something like that, with separate question if DVCS is difficult
or not.

Alternatively we could ask about _relative_ ease of learning / use.
But I don't think this would go well (and I don't think we could get
good answers from that).

[...]=20
> > =3D=3D=3D 14. How do you fetch/get changes from upstream repositori=
es? =3D=3D=3D
> > (multiple choice, with other)
> >
> > =C2=A0+ git protocol =C2=A0 =C2=A0 =C2=A0 =C2=A0(e.g. git://git.exa=
mple.com/repo.git)
> > =C2=A0+ ssh =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 (e.g. ssh+git://git.example.com/repo.git,
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 git.example.com:/srv/scm/repo.git)
> > =C2=A0+ http =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
(e.g. http://git.example.com/repo.git)
> > =C2=A0+ rsync (DEPRECATED) =C2=A0(e.g. rsync://git.example.com/repo=
=2Egit)
> > =C2=A0+ filesystem =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(e.g. /path/to=
/repo.git, file:///path/to/repo.git)
> > =C2=A0+ via git-bundle
> > =C2=A0+ foreign SCM (e.g. git-svn)
> >
> > =C2=A0+ Other, please specify
>=20
> Maybe git format-patch -> git am. Since it's already this complete.

Does anybody use git-format-patch + git-am for *fetching* (and cloning)=
?

[...]
> > =3D=3D=3D 17. Which of the following features would you like to see=
 implemented in git? =3D=3D=3D
> > (multiple choice)
> >
> > =C2=A0+ better support for big files (large media)
> > =C2=A0+ resumable clone/fetch (and other remote operations)
> > =C2=A0+ GitTorrent Protocol, or git-mirror
> > =C2=A0+ lazy clone / on-demand fetching of object
> > =C2=A0+ support for tracking empty directories
> > =C2=A0+ environmental variables in config,
> > =C2=A0 and expanding ~ and ~user in paths in config
> > =C2=A0+ better undo/abort/continue, and for more commands
> > =C2=A0+ '-n' like option for each command, which describes what wou=
ld happen
> > =C2=A0+ side-by-side diffs and/or color-words diff in gitweb
> > =C2=A0+ admin and/or write features in gitweb
> > =C2=A0+ graphical history view in gitweb
> > =C2=A0+ GUI for rebase in git-gui
> > =C2=A0+ GUI for creating repository in git-gui
> > =C2=A0+ filename encoding (in repository vs in filesystem)
> > =C2=A0+ git push --create
> > =C2=A0+ localization of command-line messages
> > =C2=A0+ wholesame directory rename detection
> > =C2=A0+ graphical merge tool integrated with git-gui
> > =C2=A0+ union checkouts (some files from one branch, some from othe=
r)
> > =C2=A0+ advisory locking / "this file is being edited"
> > =C2=A0+ "commands issued" (or "command equivalents") in git-gui / g=
itk
> > =C2=A0+ warn before/when rewriting published history
> > =C2=A0+ built-in gitjour/bananajour support
> > =C2=A0+ syntax highlighting in git-gui
> >
> > =C2=A0+ other (describe below)
> >
> > NOTES:
> > ^^^^^^
> > This is new question, a multiple choice companion to a essay free-f=
orm
> > question below. =C2=A0Included are a few example features (some fro=
m
> > partial analysis of "19. What features would you like implemented i=
n
> > Git?" question in 2009 survey.
> >
> > What features should be mentioned besides those above? =C2=A0What c=
riteria
> > should we have for including features in this list?
>=20
> I think "submodules that Just Work(TM)" or something similar should b=
e
> included. I.e. something the user doesn't have to worry about anymore
> than they do a normal tree entry. Git's complex submodule support is
> something I often hear complaints about.

I'll add 'better submodule support' to this list.

[...]=20
> > =3D=3D=3D 27. Which communication channel(s) do you use? =3D=3D=3D
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0Do you read the mailing list, or watch I=
RC channel?
> > (multiple choice)
> >
> > =C2=A0+ git@vger.kernel.org (main)
> > =C2=A0+ Git for Human Beings (Google Group)
> > =C2=A0+ msysGit
> > =C2=A0+ #git IRC channel
> > =C2=A0+ #git-devel IRC channel
> > =C2=A0+ #github or #gitorious IRC channel
> > =C2=A0+ #revctrl IRC channel
> >
> > NOTES:
> > ^^^^^^
> > Are there any communication channels that I have missed? =C2=A0For =
example
> > is there a separate channel that JGit/EGit developers use?
>=20
> FWIW: There were two non-bots on #git-devel when I joined it.

Well, Git User's Surveys always served more or less accidentally as
the source of information about git and git community ("we have wiki?"
from the first survey ;-))

> > =3D=3D About this survey. Open forum. =3D=3D
> >
> > =3D=3D=3D 28. How did you hear about this Git User's Survey? =3D=3D=
=3D
> > (single choice, with other)
> >
> > =C2=A0* git mailing list
> > =C2=A0* git-related mailing list (e.g. msysGit)
> > =C2=A0* mailing list or forum of some project
> > =C2=A0* #git IRC channel topic
> > =C2=A0* announcement on IRC channel
> > =C2=A0* git homepage
> > =C2=A0* git wiki
> > =C2=A0* git hosting site (or blog related to such site)
> > =C2=A0* software-related web site
> > =C2=A0* news or social news site (e.g. Digg, Reddit)
> > =C2=A0* blog (or blog planet)
> > =C2=A0* other kind of web site
> > =C2=A0* Twitter or other microblogging platform
> >
> > =C2=A0* other - please specify
> >
> > NOTES:
> > ^^^^^^
> > This list would of course be updated to reflect the list of (planne=
d)
> > announcement channels.
> >
> > There of course will be announcement on Git Mailing List, and perha=
ps
> > also on msysGit list / Google Group, and on Git For Human Beings
> > Google Group (if it exists). =C2=A0I'll announce it on #git, and as=
k op to
> > put short announcement in channel description, and I can announce i=
t
> > on other IRC channels. =C2=A0I would add announcement to main page =
of Git
> > Wiki, and as Git Homepage administrator to put announcement about G=
it
> > User's Survey.
> >
> > I usually tried to contact administrators of git hosting sites,
> > including git.kernel.org, repo.or.cz, GitHub, Gitorious, Assembla,
> > Codebase and Unfuddle, asking them to put announcement about
> > Git User's Survey either somewhere on the site, or in their blog
> > (if there is any). =C2=A0What git hosting sites it is worth to ask?
> >
> > Sidenote: I am thinking about contacting different git hosting site=
s
> > _before_ staring survey, asking them (them =3D administrators) abou=
t
> > what questions would they like to see. =C2=A0Do you think thet it i=
s good
> > idea?
>=20
> Yes, definitely.

Which ones?  I'll definitely contact GitHub, try to contact J.H. about
git.kernel.org and pasky about repo.or.cz, and contact admins/contact
of Assembla, Codebase, Unfuddle.  Who else to contact?

>=20
> > Should I try to post announcement on mailing list for projects that
> > use git? =C2=A0There are entirely too many such projects nowadays, =
and such
> > announcement can be considered spamming by some...
>=20
> Yeah. Definitely for the big ones like the "Projects using Git" liste=
d
> on git-scm.com. I don't think it'll be considered spam.

The questions is: which ones are big?  Those on Git Homepage?  Those
on "Git (software)" page on Git Wiki?  Which ones to try to contact
besides those on this list (and what list if there is '?' here)?

 * Linux kernel (LKML)
 * Android (?)

 * Debian (DWN list / wiki)
 * Fedora (?)
 * openSUSE (?)

 * GIMP (?)
 * GNOME (newren's blog?)
 * jQuery? (?)
 * OLPC? (olpc-devel?)
 * Perl (perlbuzz, some Perl blogger?)
 * Ruby on Rails (RubyForge, ?)
 * Samba? (mailin list IIRC?)
 * VLC? (vlc mailing list)
 * Wine? (?)
 * X.Org (freedesktop.org wiki?)

Sidenote: I can also try to post announcement on various wikis that
host some (more or less specific) information about how to do git
development for given project.

> > I would like to have announcement of Git User's Survey 2010 at
> > LWN.net, but this would need to be send at least two weeks in advan=
ce,
> > if I remember correctly. =C2=A0Is it worth it? =C2=A0What other new=
s site should
> > I (or you) send announcement to?
>=20
> reddit, digg, hackernews, slashdot, ...

Reddit, Digg and HackerNews are social news sites, and all require
having some official (or at least official-sounding) already existing
page with official announcement (GMane link, or GitWiki page?).  All
would also rquire upvoting...
=20
> > If you can Digg / Reddit announcment on some site, please do. =C2=A0=
I can
> > announce Git User's Survey 2-1- at Twitter, Identi.ca and Plurk, bu=
t I
> > don't have wide area of followers. =C2=A0So please RT.
> >
> > Should we contact some bloggers (besides asking Junio to put
> > announcement on his blog) to post an anouncement? =C2=A0Which blogg=
ers
> > would respond positively (perhaps Linus...)?

I can try to contact masukomi[1] (Kate Rhodes) and rtomayko[2]
(Ryan Tomayko), both of whom have written positively about Git
in the past, Junio C Hamano[3] of course, and perhaps also
Linus Torvalds[4]

[1] http://weblog.masukomi.org/
[2] http://tomayko.com/
[3] http://gitster.livejournal.com/
[4] http://torvalds-family.blogspot.com/

You all can help, of course...

--=20
Jakub Narebski
Poland
