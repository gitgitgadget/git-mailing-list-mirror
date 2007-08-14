From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC (final)] Git User's Survey 2007
Date: Tue, 14 Aug 2007 03:51:01 +0200
Message-ID: <200708140351.01643.jnareb@gmail.com>
References: <200707250358.58637.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Tue Aug 14 03:51:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IKlZC-0000hG-Ln
	for gcvg-git@gmane.org; Tue, 14 Aug 2007 03:51:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759812AbXHNBvL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 13 Aug 2007 21:51:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758437AbXHNBvJ
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Aug 2007 21:51:09 -0400
Received: from mu-out-0910.google.com ([209.85.134.191]:59113 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757197AbXHNBvG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Aug 2007 21:51:06 -0400
Received: by mu-out-0910.google.com with SMTP id i10so2430411mue
        for <git@vger.kernel.org>; Mon, 13 Aug 2007 18:51:04 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=b818D35/SIL0GzniX5Rjl+yujkBi1IIUmqV6c5SDUx/S51NF0QKLpHQrshL0rKUZ4ZQDbI98k0W3Jav2yJF+Mot0N5MVwPO/Hbp77S7eoqg3Zdy5/90iume8jG8KkBUsrs+BIWS83FNFckKwZPCuUs8z82lygqHXOmTjPNQw4ic=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=M/X1hvLwEQ21Q3H7NwackgD1c3FW18mOuz/mCh6+vAcDaYDfanBZT3eQIxFsSNAAEPlnLA9XtV8A6q6R7sTAFgXuYbOSYkrWgFSRkc0Lg/y8nVrXHeS/X22PtwbYIK5QYONT5mLVYwNyNr6OeVWKrVd+9TNQNtHqpdUlFGg3lAQ=
Received: by 10.86.86.12 with SMTP id j12mr5173329fgb.1187056264626;
        Mon, 13 Aug 2007 18:51:04 -0700 (PDT)
Received: from host-89-229-8-65.torun.mm.pl ( [89.229.8.65])
        by mx.google.com with ESMTPS id p38sm1612621fke.2007.08.13.18.51.00
        (version=SSLv3 cipher=OTHER);
        Mon, 13 Aug 2007 18:51:01 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <200707250358.58637.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55799>

It's been more than a year since last Git User's Survey. It would be
interesting to find what changed since then. Therefore the idea to
have another survey.

I have put the survey on Survey.Net, but *please* don't fill it yet.
Please check out the questions and answers, and note if there are
any mistakes, missed possible answers, or bad type for a question
(for example shorttext vs textarea).

I am planning to send the info below to git projects' mailing lists
(see below), git mailing list, LWN, NewsForge and Slashdot. If you
think of place to send information about git survey to, please do
comment.

Pasky, could you please put info about git survey (when it would
start of course) on git homepage, perhaps on git wiki front page,
and in #git channel description?

References to be:
  http://git.or.cz/gitwiki/GitSurvey2007
  http://thread.gmane.org/gmane.comp.version-control.git/53665
----
Linux-MIPS, Linux-NFS, OpenVZ, Agave, collectd, CRUX Linux, dash
DirectFB, Eddt, Elinks, LilyPond, Herrie, netconf, KDbg, Palava,
Paraslash, OLPC, Sidestep, SourceMage Linux, Tangram 2,
Thousand Parsec, U-Boot, X.Org, XCB, D-Bus, HAL, Cairo, Mesa3D,
WINE, XMMS2, XStrikeForce (XSF).

Some of the projects I cannot send email to, because their lists
are subscribe only (e.g. itools, Openbox)
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
  http://www.survey.net.nz/survey.php?94e135ff41e871a1ea5bcda3ee1856d9
----
About you

   01. What country are you in?
   02. What is your preferred non-programming language?
   03. How old are you?
   04. Which programming languages you are proficient with?
       (The choices include programming languages used by git)
       (zero or more: multiple choice)
    -  C, shell, Perl, Python, Tcl/Tk

Getting started with GIT

   05. How did you hear about GIT?
   06. Did you find GIT easy to learn?
    -  very easy/easy/reasonably/hard/very hard
   07. What helped you most in learning to use it?
   08. What did you find hardest?
   09. When did you start using git? From which version?
    *  (date, or version, or both)

Other SCMs

   10. What other SCM do you use?
   11. Why did you choose GIT?
   12. Why did you choose other SCMs?
   13. What would you require from GIT to enable you to change,
       if you use other SCM for your project?
   14. Did you import your repository from foreign SCM? Which SCM?
   15. What tool did you use for import?
   16. Do your GIT repository interact with other SCM? Which SCM?
   17. What tool did/do you use to interact?

How you use GIT

   18. Do you use GIT for work, unpaid projects, or both?
       work/unpaid projects/both/none(*)
       (*)I use git to interact with some project I'm interested in
   19. How do you obtain GIT?  Source tarball, binary package, or
       pull the main repository?
    -  binary package/source tarball/pull from main repository
   20. What hardware platforms do you use GIT on?
    *  examples: i386, x86_64, ARM, PowerPC, Alpha, g5, ...
   21. What OS (please include the version) do you use GIT on?
    *  examples: Linux, MS Windows (Cygwin/MinGW/gitbox), 
       IRIX, HP-UX, Solaris, FreeBSD, ...
       (please give kernel version and distribution for Linux)
   22. What projects do you track (or download) using GIT
       (or git web interface)?   
   23. How many people do you collaborate with using GIT?
   24. How big are the repositories that you work on? (e.g. how many
       files, how much disk space, how deep is the history?)
    *  number of files in repository: "git ls-tree -r HEAD | wc -l"
    *  largest file under version control
    *  pack size of freshly cloned fully packed repository
    *  number of commits in straight line, number of commits in branch
       ("git rev-list --first-parent HEAD | wc -l", 
        "git rev-list HEAD | wc -l")
   25. How many different projects do you manage using GIT?
   26. Which porcelains do you use?
       (zero or more: multiple choice)
    -  core-git, cogito (deprecated), StGIT, guilt, pg (deprecated),
       my own scripts, other
   27. Which git GUI do you use
       (zero or more: multiple choice)
    -  CLI, gitk, git-gui, qgit, gitview, giggle, tig, instaweb,
       (h)gct, qct, KGit, git.el, other
   28. Which (main) git web interface do you use for your projects?
    -  gitweb/cgit/wit (Ruby)/git-php/other
   29. How do you publish/propagate your changes?
       (zero or more: multiple choice)
    -  push, pull request, format-patch + email, bundle, other
   30. Does git.git repository include code produced by you?
    -  yes/no

Internationalization

   31. Is translating GIT required for wider adoption?
    -  yes/no/somewhat
   32. What do you need translated?
    *  examples: git-gui, qgit, git messages, manpages,
       user's manual
   33. For what language do you need translation for?

What you think of GIT

   34. Overall, how happy are you with GIT?
    -  unhappy/not so happy/happy/very happy/completely ecstatic
   35. How does GIT compare to other SCM tools you have used?
    -  worse/equal (or comparable)/better
   36. What do you like about using GIT?
   37. What would you most like to see improved about GIT?
       (features, bugs, plug-ins, documentation, ...)
   38. If you want to see GIT more widely used, what do you
       think we could do to make this happen?

Changes in GIT (since year ago, or since you started using it)

   39. Did you participate in previous Git User's Survey?
    -  yes/no
   40. What improvements you wanted got implemented?
   41. What improvements you wanted didn't get implemented?
   42. How do you compare current version with version from year ago?
    -  current version is: better/worse/no changes
   43. Which of the new features do you use?
       (zero or more: multiple choice)
    -  git-gui, bundle, eol conversion, gitattributes,
       submodules, worktree, #release notes, #user's manual,
       reflog, stash, shallow clone, detached HEAD, #fast-import,
       mergetool, interactive rebase, commit template, blame improvements,
       #other (not mentioned here)

Documentation

   44. Do you use the GIT wiki?
    -  yes/no
   45. Do you find GIT wiki useful?
    -  yes/no/somewhat
   46. Do you contribute to GIT wiki?
    -  yes/no/only corrections or spam removal
   47. Do you find GIT's on-line help (homepage, documentation) useful?
    -  yes/no/somewhat
   48. Do you find help distributed with GIT useful
       (manpages, manual, tutorial, HOWTO, release notes)?
    -  yes/no/somewhat
   49. Do you contribute to GIT documentation?
    -  yes/no
   50. What could be improved on the GIT homepage?
   51. What topics would you like to have on GIT wiki?
   52. What could be improved in GIT documentation?

Getting help, staying in touch

   53. Have you tried to get GIT help from other people?
    -  yes/no
   54. If yes, did you get these problems resolved quickly
       and to your liking?
    -  yes/no
   55. Would commerical (paid) support from a support vendor
       be of interest to you/your organization?
   56. Do you read the mailing list?
   57. If yes, do you find it useful?
    -  yes/no (optional)
   58. Do you find traffic levels on GIT mailing list OK.
    -  yes/no? (optional)
   59. Do you use the IRC channel (#git on irc.freenode.net)?
    -  yes/no
   60. If yes, do you find IRC channel useful?
    -  yes/no (optional)
   61. Did you have problems getting GIT help on mailing list or
       on IRC channel? What were it? What could be improved?

Open forum

   62. What other comments or suggestions do you have that are not
       covered by the questions above?
