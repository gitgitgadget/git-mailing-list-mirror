From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC (take 3)] Git User's Survey 2007
Date: Sat, 4 Aug 2007 02:50:54 +0200
Message-ID: <200708040250.55180.jnareb@gmail.com>
References: <200707250358.58637.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 04 02:51:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IH7rC-0001Dr-Bq
	for gcvg-git@gmane.org; Sat, 04 Aug 2007 02:51:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758861AbXHDAu7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Aug 2007 20:50:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756792AbXHDAu6
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Aug 2007 20:50:58 -0400
Received: from fk-out-0910.google.com ([209.85.128.188]:21649 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753833AbXHDAu5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Aug 2007 20:50:57 -0400
Received: by fk-out-0910.google.com with SMTP id z23so817398fkz
        for <git@vger.kernel.org>; Fri, 03 Aug 2007 17:50:55 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=QeZDl3bIsN2LycQj93ehASs6JAIqSaZT0S0/CzVKr3OYAPy7GszsdUwSRNIy4gKbjEKgIP9wd/VYNqtVS7lJHUk98ORjrYcjx3pdafcPvpSvYJqPyyZ9U4XEm8onohvcTaJd3u6czGKLYnK6asexXsXM+l7qJ8jo0/8hWBzlBPY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Ww3DJJR1IySRghTjSkCfl6uJIqRwYKx0uu++vPjM92iGWb5LfSdcOvbXN/yRGpbIm/c+DvIUFPsaw2BBE4ejMlimeps6wspGlDqNzvxHiFLXFrKRerI+hNE7B0Ca7+59q887EFlvSVSppTJDM1JPpnef8kH9bYcyEvYGDr/vbH8=
Received: by 10.86.99.9 with SMTP id w9mr2656896fgb.1186188655213;
        Fri, 03 Aug 2007 17:50:55 -0700 (PDT)
Received: from host-89-229-8-65.torun.mm.pl ( [89.229.8.65])
        by mx.google.com with ESMTPS id f31sm7422052fkf.2007.08.03.17.50.52
        (version=SSLv3 cipher=OTHER);
        Fri, 03 Aug 2007 17:50:53 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <200707250358.58637.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54782>

It's been more than a year since last Git User's Survey. It would be
interesting to find what changed since then. Therefore the idea to
have another survey.

First there is a question about the form of survey. Should we use web
based survey, as the survey before (http://www.survey.net.nz), sending
emails with link to this survey, or perhaps do email based survey,
with email Reply-To: address put for this survey alone?

Second, what questions should be put in the survey, and in the case of
single choice and multiple choice questions what possible answers
should be? Below are slightly extended questions from the last
survey. Please comment on it.

Third, where to send survey to? I was thinking about git mailing list,
LKML, and mailing list for git projects found on GitProjects page on
GIT wiki. Do you want to add some address? Or should info about GIT
User's Survey 2007 be sent also to one of on-line magazines like
LinuxToday, or asked to put on some blog?

Those lists include:
  wine-users, xmms2-devel, xcb (freedesktop), cairo, u-boot-users,
  git mailing list, lklm (thanks to Paolo Ciarrocchi)
  LWN, NewsForge, Slashdot, OSNews,

Those lists might include:
  CRUX Linux, Source Mage Linux, DirectFB, GNU LilyPond, OLPC,
  Thousands Parsec, X.Org, Mesa3D, Beryl -> Compiz Fusion,

Other possibilities:
  OpenOffice.org, Mozilla (MozillaZine), SeaMonkey,
  KDE (dot.kde.net), GNOME, Blue GNU

References:
  http://marc.info/?l=git&m=115116592330648&w=2
  http://marc.info/?l=git&m=115364303813936&w=2
  http://git.or.cz/gitwiki/GitSurvey

----
Hi all,

We would like to ask you a few questions about your use of the GIT
version control system. This survey is mainly to understand who is
using GIT, how and why.

The results will be published to the GIT wiki and discussed on the git
mailing list.

We'll close the survey in three weeks starting from today, <date>.

Please devote a few minutes of your time to fill this simple
questionnaire, it will help a lot the git community to understand your
needs, what you like of git, and of course what you don't like  of it.

The survey can be found here:
  http://www.survey.net.nz/survey.php? <number>

----
About you

    1. What country are you in?
    2. What is your preferred non-programming language?
    3. How old are you?
    4. Which programming languages you are proficient with?
       (The choices include programming languages used by git)
       (zero or more: multiple choice)
    -  C, shell, Perl, Python, Tcl/Tk

Getting started with GIT

    1. How did you hear about GIT?
    2. Did you find GIT easy to learn?
    -  very easy/easy/reasonably/hard/very hard
    3. What helped you most in learning to use it?
    4. What did you find hardest?
    5. When did you start using git? From which version?
    *  (date, or version, or both)

Other SCMs

    1. What other SCM did you use?
    2. What other SCM do you use currently?
    3. What other SCM do you use as a main SCM for your project
       instead of git, if any? 
    4. Why did you choose this SCM?
    *  example: better MS Windows support
    5. What would you require from git to enable you to change,
       if you use other SCM for your project?
    6. Did you import your repository from foreign SCM?
    7. What tool did you use for import?
    8. Do your git repository interact with other SCM?
    9. What tool did/do you use?

How you use GIT

    1. Do you use GIT for work, unpaid projects, or both?
       work/unpaid projects/both/none(*)
       (*)I use git to interact with some project I'm interested in
    2. How do you obtain GIT?  Source tarball, binary package, or
       pull the main repository?
    -  binary package/source tarball/pull from main repository
    3. What hardware platforms do you use GIT on?
    *  examples: i386, x86_64, ARM, PowerPC, Alpha, g5, ...
    4. What OS (please include the version) do you use GIT on?
    *  examples: Linux, MS Windows (Cygwin/MinGW/gitbox), 
       IRIX, HP-UX, Solaris, FreeBSD, ...
       (please give kernel version and distribution for Linux)
    5. How many people do you collaborate with using GIT?
    6. How big are the repositories that you work on? (e.g. how many
       files, how much disk space, how deep is the history?)
    *  number of files in repository: "git ls-tree -r HEAD | wc -l"
    *  largest file under version control
    *  pack size of freshly cloned fully packed repository
    *  number of commits in straight line, number of commits in branch
       ("git rev-list --first-parent HEAD | wc -l", 
        "git rev-list HEAD | wc -l")
    7. How many different projects do you manage using GIT?
    8. Which porcelains do you use?
       (zero or more: multiple choice)
    -  core-git, cogito, StGIT, pg, guilt, other
    9. Which git GUI do you use
       (zero or more: multiple choice)
    -  gitk, git-gui, qgit, gitview, giggle, tig, instaweb,
       (h)gct, qct, KGit, other
   10. Which (main) git web interface do you use for your projects?
    -  gitweb/cgit/wit (Ruby)/git-php/other
   11. How do you publish/propagate your changes?
       (zero or more: multiple choice)
    -  push, pull request, format-patch + email, bundle, other
   12. Does git.git repository include code produced by you?
    -  yes/no

Internationalization

    1. Is translating GIT required for wider adoption?
    -  yes/no/somewhat
    2. What do you need translated?
    *  examples: git-gui, qgit, messages, manpages, user's manual
    3. For what language do you need translation for?

What you think of GIT

    1. Overall, how happy are you with GIT?
    -  unhappy/not so happy/happy/very happy/completely ecstatic
    2. How does GIT compare to other SCM tools you have used?
    -  worse/equal (or comparable)/better
    3. What do you like about using GIT?
    4. What would you most like to see improved about GIT?
       (features, bugs, plug-ins, documentation, ...)
    5. If you want to see GIT more widely used, what do you
       think we could do to make this happen?

Changes in GIT (since year ago, or since you started using it)

    1. Did you participate in previous Git User's Survey?
    -  yes/no
    2. What improvements you wanted got implemented?
    3. What improvements you wanted didn't get implemented?
    4. How do you compare current version iwth version from year ago?
    -  current version is: better/worse/no changes
    5. Which of the new features do you use?
       (zero or more: multiple choice)
    -  git-gui, bundle, eol conversion, gitattributes,
       submodules, worktree, release notes, user's manual,
       reflog, stash, shallow clone, detached HEAD, fast-import,
       mergetool, interactive rebase, commit template, blame improvements,
       other (not mentioned here)
    6. If you selected "other", what are those features?

Documentation

    1. Do you use the GIT wiki?
    -  yes/no
    2. Do you find GIT wiki useful?
    -  yes/no/somewhat
    3. Do you contribute to GIT wiki?
    -  yes/no/only corrections or spam removal
    4. Do you find GIT's on-line help (homepage, documentation) useful?
    -  yes/no/somewhat
    5. Do you find help distributed with GIT useful
       (manpages, manual, tutorial, HOWTO, release notes)?
    -  yes/no/somewhat
    6. Do you contribute to GIT documentation?
    -  yes/no
    7. What could be improved on the GIT homepage?
    8. What topics would you like to have on GIT wiki?
    9. What could be improved in GIT documentation?

Getting help, staying in touch

    1. Have you tried to get GIT help from other people?
    -  yes/no
    2. If yes, did you get these problems resolved quickly
       and to your liking?
    -  yes/no
    3. Do you subscribe to the mailing list?
    -  yes/no
    4. Do you read the mailing list? What method do you use?
    -  subscribed/news interface/RSS interface/archives/
       /post + reply-to request/digests/I don't read it
    5. If yes, do you find it useful?
    -  yes/no (optional)
    6. Do you find traffic levels on GIT mailing list OK.
    -  yes/no? (optional)
    7. Do you use the IRC channel (#git on irc.freenode.net)?
    -  yes/no
    8. If yes, do you find IRC channel useful?
    -  yes/no (optional)

Open forum

    1. What other comments or suggestions do you have that are not
       covered by the questions above?
