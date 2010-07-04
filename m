From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [RFC] Git User's Survey 2010 (resend)
Date: Sun, 4 Jul 2010 00:21:16 +0000
Message-ID: <AANLkTilD8N6rnj9e3KzRB7_q3J0I4cJGx5EduX_UJScC@mail.gmail.com>
References: <201007032158.57700.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 04 02:21:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OVCxi-0001fS-06
	for gcvg-git-2@lo.gmane.org; Sun, 04 Jul 2010 02:21:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756281Ab0GDAVY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 3 Jul 2010 20:21:24 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:60032 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756228Ab0GDAVW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 3 Jul 2010 20:21:22 -0400
Received: by fxm14 with SMTP id 14so3023453fxm.19
        for <git@vger.kernel.org>; Sat, 03 Jul 2010 17:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=FGGR12f+suddr57uSfh0BhZegrZn0n1R3W0LycdtP8Q=;
        b=KRhfKUx8Gs61t8RCYGIUij6nj+yTaDcHWz4zo7/fnR5Xfiyhu3PbNe4auqlzAP8dpS
         diH9bfGGrbeL+es28BHuRGIDpjLVRZSO/DCAf0ixdTMzPOMJYNbkfa+0DjDZnS3Z1T9k
         wpKcMr8cInXMShlxWPcPL3aM5cW5NFcVHZK/s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=swhoo8UDMCsG/K/LMrJbm2HZHr5onlDllb8B/t3Wc7533wUczX9RlLuxD4xM3zjp7X
         2q1ISpSBf8C7vuIxiLZcfBZ7SYp1wMHwc2YoVhbm6lRUYZ7kFuneFbl0IXBUy2OoY+ye
         kZGv9jYX5Qh94TJcVTvqaMYMaB6d71MQjTFJQ=
Received: by 10.223.103.211 with SMTP id l19mr687972fao.62.1278202876230; Sat, 
	03 Jul 2010 17:21:16 -0700 (PDT)
Received: by 10.223.103.84 with HTTP; Sat, 3 Jul 2010 17:21:16 -0700 (PDT)
In-Reply-To: <201007032158.57700.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150213>

2010/7/3 Jakub Narebski <jnareb@gmail.com>:

This survey is good stuff. Some minor comments below.

> I guess it is time for annual (so far) Git User's Survey. =C2=A0Shoul=
d
> there be one? =C2=A0When should it start, and how long should it last=
?
>
> here is how it was for previous surveys:
> =C2=A0* 2009 was open from 15 July =C2=A0 to 15 September 2009 (for 2=
 months)
> =C2=A0* 2008 was open from 31 August to 14 October 2008 (for 1.5 mont=
hs)
> =C2=A0* 2007 was open from 20 August to 10 September 2007 (for 20 day=
s)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0(officially: results are up until 28 Septe=
mber 2007)
> =C2=A0* 2006 was open from 23 July =C2=A0 to 6-12 September 2006
> =C2=A0 (for a bit less than 2 months)
>
> With more that 3000 responses in 2008 and 2009 survey, analysing
> free-form data was hard. =C2=A0That is why in this proposal there is =
only
> single one free-form response (about missing features).
>
> What questions (and with what proposed answers) shound there be in
> this year survey? =C2=A0Below there is the content of the proposed su=
rvey:
>
>
> =3D Git User's Survey 2010 (proposal) =3D
>
> =3D=3D About you =3D=3D
>
> NOTES:
> ^^^^^^
> This section gives us a bit of demographical information about survey
> responders. =C2=A0Is it useful? =C2=A0Should we leave it in survey, o=
r remove it?
>
> Should we for example include 'gender' as one of questions? =C2=A0Per=
l Survey
> 2010 did.
>
>
> =3D=3D=3D 01. What country do you live in? =3D=3D=3D
> =C2=A0 =C2=A0 =C2=A0 =C2=A0(Country of residence)
> (free-form single line)
>
> NOTES:
> ^^^^^^
> Perhaps a better solution would be a menu (drop-down list) of countri=
es,
> using list of current countries. =C2=A0It would be more work to creat=
e it, but
> might reduce ambiguities and unparsable responses.
>
> What I'd like to have is to pre-fill / select default answer based on=
 GeoIP.
> Even better would be to be able to show current position on Google Ma=
p, like
> contributors and users map on Ohloh... but that I think is simply not
> possible with Survs.com, the site to be used for this survey (and I g=
uess
> neither with any other survey site). =C2=A0One can dream.
>
> Pel Survey 2010 also included (from what I remember, and from provide=
d data
> and analysis of survey) also country of origin / country of birth, to
> measure mobility. =C2=A0I wonder if it would make sense to have the s=
ame for Git
> User's Survey 2010... =C2=A0Note that it would be harder to come up w=
ith the list
> of countries for such question, because the country might no longer e=
xists.
> Therefore the list (if present) should be based on all countries that=
 exist
> or existed since 100 years ago (or so).
>
>
> =3D=3D=3D 02. How old are you (in years)? =3D=3D=3D
> (free-form single line)
>
> NOTES:
> ^^^^^^
> Instead of unconstrained free-form response it might be better to hav=
e
> single choice (or menu) of age ranges. =C2=A0What do you think? =C2=A0=
Of course with
> ranges there is question what ranges to use (how to quantize age); go=
o
> solution would be to chose ranges corresponding somewhat to the level=
s of
> education.
>
>
> =3D=3D Getting started with Git =3D=3D
>
> =3D=3D=3D 03. Have you found Git easy to learn? =3D=3D=3D
> (single choice)
>
> * Very easy
> * Easy
> * Reasonably easy
> * Hard
> * Very hard
>
> =3D=3D=3D 04. Have you found Git easy to use? =3D=3D=3D
> (single choice)
>
> * Very easy
> * Easy
> * Reasonably easy
> * Hard
> * Very hard
>
> NOTES:
> ^^^^^^
> Those two questions, considered alone, doesn't tell us much. =C2=A0If=
 one use
> git, then usually one does not think it is too hard to use (unless fo=
rced to
> use git by external circumstances, like project he/she works on using=
 git).
> On the other hand those two questions together give us some mesaure o=
f git
> learning curve, telling us if people consider git easy to use but har=
d to
> learn, or vice versa ;-)
>
> I think it might be also good to have to calculate correlations, e.g.=
 if
> people who find git hard to use make use of its advanced features.
>
> The question is: should they stay, or should they go?

They should probably stay. But they don't really ask the right
question IMO. Which is not whether users think it's difficult to
learn, but whether it's unreasonably difficult for the problem they're
solving.

I.e. jet aircraft are hard to operate, but they also do neat
stuff. How hard is Git to learn for the problem it's solving?

> =3D=3D=3D 05. Which Git version(s) are you using? =3D=3D=3D
> (multiple choice, with other)
>
> =C2=A0+ pre 1.3
> =C2=A0+ 1.3.x
> =C2=A0+ 1.4.x
> =C2=A0+ 1.5.x
> =C2=A0+ 1.6.x
> =C2=A0+ 1.7.x
>
> =C2=A0+ minor (maintenance) release 1.x.y.z
> =C2=A0+ 'master' branch of official git repository
> =C2=A0+ 'next' branch of official git repository
> =C2=A0+ 'pu' branch of official git repository
> =C2=A0+ version from msysGit / Git for Windows fork repository
> =C2=A0+ git-bigfiles fork
> =C2=A0+ JGit implementation (e.g. via Eclipse plugin, EGit)
>
> =C2=A0+ other, please specify
>
> NOTES:
> ^^^^^^
> A few of possible answers are new in this version of survey, namely '=
pu',
> msysGit, git-bigfiles, JGit, and of course 1.7.x.
>
> This question is here to stay.
>
>
> =3D=3D=3D 06. Rate your own proficiency with Git: =3D=3D=3D
> (single choice)
>
> =C2=A0* 1. novice
> =C2=A0* 2. casual, needs advice
> =C2=A0* 3. everyday use
> =C2=A0* 4. can offer advice
> =C2=A0* 5. know it very well
>
> NOTES:
> ^^^^^^
> This question tell us penetration of announcements of Git User's Surv=
ey 2010;
> did we get to all, or only to git gurus? =C2=A0It is also useful for =
correlating
> with other responses, for example to know which features are used by
> novices, and which by gurus.
>
>
> =3D=3D How you use Git =3D=3D
>
> =3D=3D=3D 07. I use Git for (check all that apply): =3D=3D=3D
> (multiple choice, with other)
>
> Note that above choices are neither orthogonal nor exclusive. =C2=A0O=
ne
> might want to check multiple answers even for a single repository.
>
> NOTES:
> ^^^^^^
> Answers to this question probe different direction.
> This list is interspersed with comments about specific
> (sub)sections.
>
> =C2=A0+ work projects
> =C2=A0+ unpaid projects
>
> Notes:
> ^^^^^^
> Those two are about using git at work vs using git on your own free t=
ime.
> There are of course shades of gray, like using git for work project
> unofficially (e.g.using git-svn as "fat" client for company's Subvers=
ion
> repository), or employer allowing to work on non-work OSS project dur=
ing
> working hours. =C2=A0But I'm not sure if they are worth adding.
>
> =C2=A0+ proprietary projects
> =C2=A0+ OSS development (also public domain, and published & unlicens=
ed)
> =C2=A0+ private (unpublished)
>
> Notes:
> ^^^^^^
> Those three are about licensing: proprietary / free (open) / unlicens=
ed.
> By 'OSS development' I mean here also free licenses for documentation=
 and
> documents, like GFDL or Creative Commons licenses.
>
> =C2=A0+ code (programming)
> =C2=A0+ personal data
> =C2=A0+ documents (data)
> =C2=A0+ static website
> =C2=A0+ web app
> =C2=A0+ large (> 1MB) binary files
> =C2=A0+ often changing binary files
>
> Notes:
> ^^^^^^
> This is about what kind of data do you store in git. =C2=A0I am a bit=
 unsure
> whether it is worth separating 'web app'; it is 'code'.
>
> New in this edition of survey is 'large binary data' and 'often chang=
ing
> binary files'... but should 'large' cutoff be 1MB, or 10MB, or 50MB, =
or
> 100MB?
>
> I'm not sure about having 'personal data'...
>
> =C2=A0+ sharing data or sync
> =C2=A0+ managing configuration files
> =C2=A0+ backup
> =C2=A0+ backend for wiki, blog, or other web app
> =C2=A0+ frontend to other SCM (e.g. git-svn)
>
> Notes:
> ^^^^^^
> This is about (ab)using git for other things than straighforward sour=
ce
> control management. =C2=A0List of possible answers specified here sho=
uld cover
> most commonly encountered usages: shdoul we add anything else here?
>
> =C2=A0+ other (please specify)
>
>
> =3D=3D=3D 08. How do/did you obtain Git (install and/or upgrade)? =3D=
=3D=3D
> (multiple choice, with other)
>
> Note that this question is multiple choices question because one can
> install Git in different ways on different machines or on different
> operating systems.
>
> =C2=A0+ binary package
> =C2=A0+ source package or script
> =C2=A0+ source tarball
> =C2=A0+ pull from (main) repository
> =C2=A0+ preinstalled / sysadmin job
>
> =C2=A0+ other - please specify
>
> Description:
> ~~~~~~~~~~~~
> Explanation: "binary package" covers pre-compiled binary (e.g. =C2=A0=
from
> rpm or deb binary packages); "source package" covers things like
> deb-src and SRPMS / *.src.rpm; "source script" is meant to cover
> installation in source-based distributions, like 'emerge' in Gentoo.
>
> Automatic update (apt, yum, etc.) in most cases means binary package
> install; unless one uses source-based distribution like Gentoo, CRUX,
> or SourceMage, where automatic update means using source package (or
> source script).
>
> The option named "preinstalled / sysadmin job" means that either you
> didn't need to install git because it was preinstalled (and you didn'=
t
> upgrade); or that you have to ask system administrator to have git
> installed or upgraded.
>
> Note that this question is multiple choices question because one can
> install Git in different ways on different machines or on different
> operating systems.
>
> NOTES:
> ^^^^^^
> What I didn't take into account in above explanation is operating
> systems with packaging systems different that the one used by various
> Linux distributions.
>
> In short: if to have git installed you compile it, you use source
> package or source tarball. =C2=A0If the installation onvolves anythin=
g more
> than 'make install' (or manual copying), then it is most probably
> source package or script.
>
> This for example means that "msysGit" installer is source package, an=
d
> "Git for Windows" is binary package, if I understand it correctly.
>
>
> =3D=3D=3D 09. On which operating system(s) do you use Git? =3D=3D=3D
> (multiple choice, with other)
>
> =C2=A0+ Linux (includes MeeGo and Moblin)
> =C2=A0+ MacOS X (Darwin)
> =C2=A0+ MS Windows/msysGit (MINGW)
> =C2=A0+ MS Windows/Cygwin
> =C2=A0+ FreeBSD, OpenBSD, NetBSD, etc.
> =C2=A0+ other Unix
>
> =C2=A0+ iPhone OS
> =C2=A0+ Android
> =C2=A0+ WebOS
>
> =C2=A0+ Other, please specify
>
> NOTES:
> ^^^^^^
> The iPhone OS, Androind and WebOS answers are new this year.
> OpenSolaris died, so I removed it. =C2=A0I wonder if it is worth it t=
o
> differentiate between MS Windows/msysGit and MS Windows/Cygwin, or if
> we should just have one, single 'MS Windows' choice.

It's definitely worth differentiating those two.

> =3D=3D=3D 10. What do you use to edit contents under version control =
with Git? =3D=3D=3D
> =C2=A0 =C2=A0 =C2=A0 =C2=A0What kind of editor, IDE or RAD you use wo=
rking with Git?
> (multiple choice, with other)
>
> =C2=A0+ simple text editor
> =C2=A0+ programmers editor
> =C2=A0+ IDE or RAD
> =C2=A0+ WYSIWYG tool
>
> =C2=A0+ other kind
>
> Description:
> ~~~~~~~~~~~~
> * "simple text editor" option includes editors such as pico, nano,
> =C2=A0joe, Notepad,
>
> * "programmets editor" option includes editors such as Emacs/XEmacs,
> =C2=A0Vim, TextMate, SciTE (syntax highlighting, autoindentation,
> =C2=A0integration with other programmers tools, etc.)
>
> * "IDE (Integrated Development Environment) and RAD (Rapid Applicatio=
n
> =C2=A0Development)" option includes tools such as Eclipse, NetBeans I=
DE,
> =C2=A0IntelliJ IDE, MS Visual Studio, KDevelop, Anjuta, Xcode,
> =C2=A0Code::Blocks but also tools such as Quanta+, BlueFish or Screem=
 (for
> =C2=A0editing HTML, CSS, PHP etc.), and Kile or LEd for LaTeX.
>
> * "WYSIWYG tools" option includes word processors such as MS Office o=
r
> =C2=A0OpenOffice.org, but also tools such as Adobe Acrobat (for PDF) =
or
> =C2=A0GIMP (for images), or WYSIWYG DTP tools such as QuarkXPress,
> =C2=A0PageMaker or Scribus, or WYSIWYG HTML editors such as FrontPage=
,
> =C2=A0Dreamweaver or KompoZer.
>
> NOTES:
> ^^^^^^
> Is this question useful, or should it be removed from survey?
>
>
> =3D=3D=3D 11. What Git interfaces and frontends do you use? =3D=3D=3D
> (multiple choice, with other)
>
> =C2=A0+ Cogito (DEPRECATED)
> =C2=A0+ Easy Git
> =C2=A0+ Pyrite
> =C2=A0+ I don't know, I only use (graphical) tools
>
> =C2=A0+ pg aka Patchy Git (DEPRECATED)
> =C2=A0+ StGIT
> =C2=A0+ Guilt
> =C2=A0+ TopGit
>
> =C2=A0+ other (please specify)
>
> NOTES:
> ^^^^^^
> This version is going back to split from 2008 survey, rather than
> having everything put together like in 2009 one. =C2=A0There are, of
> course, problems with both choices.
>
> The problem with split part is that people can have troubls with
> distinguising between interfaces, implementations, frontends and tool=
s
> (although "I don't know ..." =C2=A0answer should, I think, help here)=
=2E =C2=A0The
> problem with having it everything together is that the list of
> possible answers gets long and a bit unwieldy.
>
> BTW are there any implementations and frontends that should be added
> to the list above?
>
>
> =3D=3D=3D 12. What kind of Git tools do you use? =3D=3D=3D
> (multiple choice, with other)
>
> If a tool is both history viewer, and commit tool, please choose the
> option that corresponds to how do you use this tool.
>
> =C2=A0+ editor/IDE VC integration (e.g. EGit, TextMate bundle, magit)
> =C2=A0+ filemanager / shell extension (e.g. git-cheetah, TortoiseGit)
> =C2=A0+ graphical history viewer/browser (e.g. gitk)
> =C2=A0+ graphical commit tool (e.g. git-gui)
> =C2=A0+ graphical diff and/or merge tool (e.g. Kompare, Meld)
> =C2=A0+ graphical blame or pickaxe tool
> =C2=A0+ git-instaweb, or self-hosted web interface
> =C2=A0+ tool to manage git repositories (e.g. Gitosis, Gitolite)
>
> =C2=A0+ my own scripts (for daily use)
> =C2=A0+ my own scripts (for special tasks)
>
> NOTES:
> ^^^^^^
> As the number of tools increases (see InterfacesFrontendsAndTools pag=
e
> on git wiki), having them listed all there gets a bit unwieldy. =C2=A0=
On
> the other hand it was a good way to find new tools that were not yet
> included on IFaT page. =C2=A0What do you think: should it be about to=
ols,
> or only about kind of tools used with git?
>
> What do you think about this list? =C2=A0IS there something that shou=
ld not
> be here? =C2=A0Or perhaps there is something that should be added to =
this
> list?
>
>
> =3D=3D=3D 13. Which git hosting site(s) do you use for your project(s=
)? =3D=3D=3D
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Please check only hosting sites where you =
publish/push to (with git)
> (multiple choice, with other)
>
> =C2=A0+ [http://repo.or.cz repo.or.cz]
> =C2=A0+ [http://github.com GitHub]
> =C2=A0+ [http://gitorious.org Gitorious]
> =C2=A0+ [http://www.indefero.net InDefero]
>
> Notes:
> ^^^^^^
> Those are generic git hosting sites, each of them showcasing their ow=
n
> tool, all except GitHub open source (it is Girocco for repo.or.cz; fo=
r
> the rest the tool is named the same as the git hosting site).
>
> =C2=A0+ [http://savannah.gnu.org Savannah]
> =C2=A0+ [http://sourceforge.net SourceForge]
>
> Notes:
> ^^^^^^
> Generic software hosting sites, with git support. =C2=A0Did I miss
> something, should I include yet another site?

Maybe this should include "I host my own, e.g. with Gitweb".

> =C2=A0+ [http://www.assembla.com Assembla]
> =C2=A0+ [http://codebasehq.com Codebase]
> =C2=A0+ [http://unfuddle.com Unfuddle]
> =C2=A0- [http://codesion.com Codesion]
> =C2=A0- [http://gitfarm.appspot.com GitFarm]
> =C2=A0- [http://www.projectlocker.com ProjectLocker]
> =C2=A0- [http://thechaw.com The Chaw]
> =C2=A0- [http://unfuddle.com Unfuddle]
>
> Notes:
> ^^^^^^
> Those are commercial and/or less known git hosting sites. =C2=A0I am =
not
> sure which ones of those marked with '-' to include, and whether to
> include other sites from GitHosting page on git wiki. =C2=A0What do y=
ou
> think?
>
> =C2=A0+ [http://git.kernel.org kernel.org]
> =C2=A0+ [http://www.freedesktop.org/wiki/ freedesktop.org]
>
> Notes:
> ^^^^^^
> Those are 'git hosting site for related projects', but are special in
> some sense. =C2=A0Should I leave them there, or remove from this list=
?
>
> =C2=A0+ [http://alioth.debian.org Alioth] (Debian)
> =C2=A0+ [http://hosted.fedoraproject.org Fedora Hosted]
>
> Notes:
> ^^^^^^
> Those are distribution-specific. =C2=A0Are there any sites that I mis=
sed?
> Launchpad from Ubuntu does not count, as it is Bazaar hosting site,
> not Git hosting site.
>
> =C2=A0+ =C2=A0git hosting site for related projects
> =C2=A0+ =C2=A0generic site without git support
> =C2=A0+ =C2=A0self hosted
>
> Notes:
> ^^^^^^
> Are ther other kinds / typse of sites one can host project using git
> on? =C2=A0What are they?
>
> =C2=A0+ =C2=A0Other (please specify)
>
> NOTES:
> ^^^^^^
> I think this question is here to stay.
>
>
> =3D=3D=3D 14. How do you fetch/get changes from upstream repositories=
? =3D=3D=3D
> (multiple choice, with other)
>
> =C2=A0+ git protocol =C2=A0 =C2=A0 =C2=A0 =C2=A0(e.g. git://git.examp=
le.com/repo.git)
> =C2=A0+ ssh =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (=
e.g. ssh+git://git.example.com/repo.git,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 git.example.com:/srv/scm/repo.git)
> =C2=A0+ http =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(=
e.g. http://git.example.com/repo.git)
> =C2=A0+ rsync (DEPRECATED) =C2=A0(e.g. rsync://git.example.com/repo.g=
it)
> =C2=A0+ filesystem =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(e.g. /path/to/r=
epo.git, file:///path/to/repo.git)
> =C2=A0+ via git-bundle
> =C2=A0+ foreign SCM (e.g. git-svn)
>
> =C2=A0+ Other, please specify

Maybe git format-patch -> git am. Since it's already this complete.

> Description:
> ~~~~~~~~~~~~
> This question asks about how do you get changes (updates) from
> projects you follow into your local repository. It is not about how d=
o
> you get latest version of Git.
>
> Fetching (or rather cloning) via bundle could mean that project
> publishes ready for download bundles to reduce traffic and load on
> server (HTTP download [of bundle] can be resumed, git-clone currently
> cannot; one can also distribute bundle using P2P).
>
> NOTES:
> ^^^^^^
> What is new are examples of URLs / URIs for each protocol.
>
> Did I miss anything? =C2=A0Is this question interesting, and should i=
t
> stay, or should it be removed?
>
>
> =3D=3D=3D 15. How do you publish/propagate your changes? =3D=3D=3D
> (multiple choice, with other)
>
> =C2=A0+ push
> =C2=A0+ pull request (+ any form of announcement / notification)
> =C2=A0+ format-patch + email
> =C2=A0+ format-patch + other (e.g. reviewboard, issue tracker or foru=
m)
> =C2=A0+ git bundle
>
> =C2=A0+ git-svn (to Subversion repository)
> =C2=A0+ git-p4 (to Perforce repository)
> =C2=A0+ foreign SCM interface (other than mentioned above)
>
> =C2=A0+ other - please specify
>
> Description:
> ~~~~~~~~~~~~
> Publishing via bundle could mean sending bundle via email, or posting
> it on review board (or forum).
>
> Instead of git-format-patch there can be utilized other way of
> generating patch (e.g. git-show, git-diff, 'patch' view from gitweb,
> etc.)
>
> NOTES:
> ^^^^^^
> Should it stay, or should it be removed? =C2=A0I guess it can be
> interesting for git hosting sites... =C2=A0Should we have separate an=
swrs
> for different kinds of push (ssh, "dumb" HTTP(S) with WebDAV, "smart"
> HTTP - if it is possible, git:// protocol with push enabled)?
>
>
> =3D=3D=3D 16. Which of the following features do you use? =3D=3D=3D
> (multiple choice, with other)
>
> =C2=A0+ "smart" HTTP protocol
> =C2=A0+ git bundle (off-line transport)
> =C2=A0+ eol conversion (crlf)
> =C2=A0+ gitattributes
> =C2=A0+ custom diff/merge driver
> =C2=A0+ submodules (subprojects)
> =C2=A0+ subtree merge (optionally git-subtree)
> =C2=A0+ partial (sparse) checkout, or assume-unchanged bit
> =C2=A0+ separate worktree / core.worktree
> =C2=A0+ multiple worktrees (git-new-worktree)
> =C2=A0+ alternates mechanism (sharing object database)
> =C2=A0+ stash (optionally "git stash --keep-index")
> =C2=A0+ shallow clone (e.g. "git clone --depth=3D<n>")
> =C2=A0+ detaching HEAD (e.g. "git checkout HEAD^0")
> =C2=A0+ interactive rebase (small scale history editing)
> =C2=A0+ interactive commit / per-hunk comitting / partial commit
> =C2=A0+ commit message templates
> =C2=A0+ git-filter-branch or equivalent (large history rewriting)
> =C2=A0+ bisect (optionally "git bisect run <script>")
> =C2=A0+ committing with dirty tree (keeping some changes uncommitted)
> =C2=A0+ non-default hooks (from contrib/hooks/ or other)
> =C2=A0+ shell completion of commands
> =C2=A0+ git-aware shell prompt
> =C2=A0+ git aliases, shell aliases for git, or own git scripts
> =C2=A0+ one-way interaction with other SCMs (from SCM to git)
> =C2=A0+ two-way interaction with other SCMs (from SCM to git, from gi=
t to SCM)
> =C2=A0+ git-cvsserver
> =C2=A0+ git notes
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
>
>
> =3D=3D=3D 17. Which of the following features would you like to see i=
mplemented in git? =3D=3D=3D
> (multiple choice)
>
> =C2=A0+ better support for big files (large media)
> =C2=A0+ resumable clone/fetch (and other remote operations)
> =C2=A0+ GitTorrent Protocol, or git-mirror
> =C2=A0+ lazy clone / on-demand fetching of object
> =C2=A0+ support for tracking empty directories
> =C2=A0+ environmental variables in config,
> =C2=A0 and expanding ~ and ~user in paths in config
> =C2=A0+ better undo/abort/continue, and for more commands
> =C2=A0+ '-n' like option for each command, which describes what would=
 happen
> =C2=A0+ side-by-side diffs and/or color-words diff in gitweb
> =C2=A0+ admin and/or write features in gitweb
> =C2=A0+ graphical history view in gitweb
> =C2=A0+ GUI for rebase in git-gui
> =C2=A0+ GUI for creating repository in git-gui
> =C2=A0+ filename encoding (in repository vs in filesystem)
> =C2=A0+ git push --create
> =C2=A0+ localization of command-line messages
> =C2=A0+ wholesame directory rename detection
> =C2=A0+ graphical merge tool integrated with git-gui
> =C2=A0+ union checkouts (some files from one branch, some from other)
> =C2=A0+ advisory locking / "this file is being edited"
> =C2=A0+ "commands issued" (or "command equivalents") in git-gui / git=
k
> =C2=A0+ warn before/when rewriting published history
> =C2=A0+ built-in gitjour/bananajour support
> =C2=A0+ syntax highlighting in git-gui
>
> =C2=A0+ other (describe below)
>
> NOTES:
> ^^^^^^
> This is new question, a multiple choice companion to a essay free-for=
m
> question below. =C2=A0Included are a few example features (some from
> partial analysis of "19. What features would you like implemented in
> Git?" question in 2009 survey.
>
> What features should be mentioned besides those above? =C2=A0What cri=
teria
> should we have for including features in this list?

I think "submodules that Just Work(TM)" or something similar should be
included. I.e. something the user doesn't have to worry about anymore
than they do a normal tree entry. Git's complex submodule support is
something I often hear complaints about.

> =3D=3D=3D 18. Describe what features would you like to have in Git, i=
f it is
> =C2=A0 =C2=A0 =C2=A0 =C2=A0not on the list above? =3D=3D=3D
> (free form, essay length)
>
>
> =3D=3D What you think of Git =3D=3D
>
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
>
>
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
>
>
> =3D=3D Changes in Git (since year ago, or since you started using it)=
 =3D=3D
>
> =3D=3D=3D 21. Did you participate in previous Git User's Surveys? =3D=
=3D=3D
> (multiple choice)
>
> =C2=A0+ in 2006
> =C2=A0+ in 2007
> =C2=A0+ in 2008
> =C2=A0+ in 2009
> =C2=A0+ none of the above
>
> NOTES:
> ^^^^^^
> This might be quite useful comparing with previous surveys. =C2=A0The
> answer 'none of the above' is new in this survey (as is 'in 2009',
> of course).
>
>
> =3D=3D=3D 22. How do you compare the current version with the version=
 from one year ago? =3D=3D=3D
> (single choice)
>
> =C2=A0* better
> =C2=A0* no changes
> =C2=A0* worse
>
> =C2=A0* cannot say
>
> NOTES:
> ^^^^^^
> This question was mainly excuse for providing list of main changes
> from the year ago. =C2=A0I think that this question should be removed=
, as
> it doesn't bring any important information.
>
>
> =3D=3D Documentation. Getting help. =3D=3D
>
> =3D=3D=3D 23. How useful have you found the following forms of Git do=
cumentation? =3D=3D=3D
> (matrix)
>
> =C2=A0Columns: never used / not useful / somewhat / useful
> =C2=A0+ Git Wiki
> =C2=A0+ on-line help
> =C2=A0+ help distributed with git
>
>
> Description:
> ~~~~~~~~~~~~
> * Git Wiki was to be found at http://git.wiki.kernel.org
> * on-line help includes, among others, Git Homepage (http://git-scm.c=
om),
> =C2=A0"Git Community Book" (http://book.git-scm.com), "Pro Git" book
> =C2=A0(http://progit.org) and Git Reference site (http://gitref.org)
> * help distributed with git include manpages, manual, tutorials, HOWT=
O,
> =C2=A0release notes, technical documentation, contrib/examples/
>
> NOTES:
> ^^^^^^
> Should we split those answers further, e.g. separating on-line
> tutorials and guides, from on-line tips etc.?
>
>
> =3D=3D=3D 24. Have you tried to get help regarding Git from other peo=
ple? =3D=3D=3D
> (single choice)
>
> =C2=A0* Yes
> =C2=A0* No
>
> =3D=3D=3D 25. If yes, did you get these problems resolved quickly and=
 to your liking? =3D=3D=3D
> (single choice)
>
> =C2=A0* Yes
> =C2=A0* No
> =C2=A0* Somewhat
>
> NOTES:
> ^^^^^^
> Those two questions are not very useful. =C2=A0I think that they shou=
ld be
> removed from 2010 survey.
>
>
> =3D=3D=3D 26. What channel(s) do you use to request help about git? =3D=
=3D=3D
> (multiple choice, with other)
>
> =C2=A0+ git mailing list (git@vger.kernel.org)
> =C2=A0+ "Git for Human Beings" Google Group
> =C2=A0+ msysGit mailing list / Google Group
> =C2=A0+ IRC (#git)
> =C2=A0+ IRC (other git/SCM related, e.g. #github)
> =C2=A0+ request in blog post or on wiki
> =C2=A0+ asking git guru/colleague
> =C2=A0+ project mailing list, or IRC, or forum
> =C2=A0+ Twitter or other microblogging platform
> =C2=A0+ instant messaging (IM) like XMPP/Jabber
> =C2=A0+ StackOverflow or other StackExchange site
>
> =C2=A0+ other (please specify)
>
> NOTES:
> ^^^^^^
> Are there any main channels of requesting help that I have missed in
> the above list of answers? =C2=A0What are they, and why do you think =
they
> are important enought to warrant inclusion in above list?
>
>
> =3D=3D=3D 27. Which communication channel(s) do you use? =3D=3D=3D
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Do you read the mailing list, or watch IRC=
 channel?
> (multiple choice)
>
> =C2=A0+ git@vger.kernel.org (main)
> =C2=A0+ Git for Human Beings (Google Group)
> =C2=A0+ msysGit
> =C2=A0+ #git IRC channel
> =C2=A0+ #git-devel IRC channel
> =C2=A0+ #github or #gitorious IRC channel
> =C2=A0+ #revctrl IRC channel
>
> NOTES:
> ^^^^^^
> Are there any communication channels that I have missed? =C2=A0For ex=
ample
> is there a separate channel that JGit/EGit developers use?

=46WIW: There were two non-bots on #git-devel when I joined it.

> =3D=3D About this survey. Open forum. =3D=3D
>
> =3D=3D=3D 28. How did you hear about this Git User's Survey? =3D=3D=3D
> (single choice, with other)
>
> =C2=A0* git mailing list
> =C2=A0* git-related mailing list (e.g. msysGit)
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
>
> Sidenote: I am thinking about contacting different git hosting sites
> _before_ staring survey, asking them (them =3D administrators) about
> what questions would they like to see. =C2=A0Do you think thet it is =
good
> idea?

Yes, definitely.

> Should I try to post announcement on mailing list for projects that
> use git? =C2=A0There are entirely too many such projects nowadays, an=
d such
> announcement can be considered spamming by some...

Yeah. Definitely for the big ones like the "Projects using Git" listed
on git-scm.com. I don't think it'll be considered spam.

> I would like to have announcement of Git User's Survey 2010 at
> LWN.net, but this would need to be send at least two weeks in advance=
,
> if I remember correctly. =C2=A0Is it worth it? =C2=A0What other news =
site should
> I (or you) send announcement to?

reddit, digg, hackernews, slashdot, ...

> If you can Digg / Reddit announcment on some site, please do. =C2=A0I=
 can
> announce Git User's Survey 2-1- at Twitter, Identi.ca and Plurk, but =
I
> don't have wide area of followers. =C2=A0So please RT.
>
> Should we contact some bloggers (besides asking Junio to put
> announcement on his blog) to post an anouncement? =C2=A0Which blogger=
s
> would respond positively (perhaps Linus...)?
