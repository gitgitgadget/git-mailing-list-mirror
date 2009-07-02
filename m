From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC] Git User's Survey 2009 - second trial run, and question about announcing it
Date: Fri, 3 Jul 2009 01:30:22 +0200
Message-ID: <200907030130.24417.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: Johan Herland <johan@herland.net>,
	Peter Baumann <waste.manager@gmx.de>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Graham Perks <graham@kace.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 03 01:30:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MMVjl-0001fo-Ak
	for gcvg-git-2@gmane.org; Fri, 03 Jul 2009 01:30:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753941AbZGBXab (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jul 2009 19:30:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752991AbZGBXaa
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Jul 2009 19:30:30 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:41121 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752814AbZGBXa2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jul 2009 19:30:28 -0400
Received: by fxm18 with SMTP id 18so1830606fxm.37
        for <git@vger.kernel.org>; Thu, 02 Jul 2009 16:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=piCjvk9EVRqjGFkLvG/2a3SgSlHfEu9slwck2beFgnA=;
        b=D+l5lcDVDC7ROUkxPrwBeyjbZ1lJUYykdQaBB7tQ1QSUpT/X7zW/Hm4Fxth+OAYtMc
         Ipr5ModK/49xA2E5odDGV/8rjglaQgKiiuHGiFD7ymmjuOROULnbnH6cLphQaJte3JMR
         z6cc4/fpva7aI3KRF570sH8OJI6gEUP71xQS8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        b=P+eQ3CcDsOq8MG7ogrYlQ+GVpTkeFuDwFNR/vUqzfT3C7CGRom6SI9wvwv5YkF+xJX
         7l193HrlfDRl9MJUwbD9q2zDnqv+/2IeV3ZLetV5/+HzeV/+InKSzZjRz6emEccVAMuL
         0LGWxmB3jhA+PcQWZWXAaquKskTWByD2VMDJg=
Received: by 10.103.217.10 with SMTP id u10mr73016muq.85.1246577430277;
        Thu, 02 Jul 2009 16:30:30 -0700 (PDT)
Received: from ?192.168.1.13? (abvs71.neoplus.adsl.tpnet.pl [83.8.216.71])
        by mx.google.com with ESMTPS id y37sm14130886mug.19.2009.07.02.16.30.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 02 Jul 2009 16:30:29 -0700 (PDT)
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122675>

This is proposed second version of questions for upcoming 
"Git User's Survey 2009".  It contains compared to previous
created version, a few fixes to phrasing of questions, moving
some answers from one question to another and removing (some of)
duplicate answers, and a few extra comments and explanations.

Thanks to Johan Herland, Peter Baumann, Felipe Contreras, 
Graham Perks and others in previous GitSurvey2009 thread
for their feedback and comments.

The main visible difference from precious version is replacing
question 21. "How does Git compare to other SCM tools you have used?"
was replaced by "In you opinion, which areas in Git needs improvement?"
suggested by Felipe, and question 29. "Should Git User's Survey be
repeated next year?" was replaced by "How did you heard about
this Git User's Survey?"


The last replacements reminds me of the problem of announcing this
survey.  Where to submit note announcing "Git User's Survey 2009"
(tentative date of survey is 15 July 2009 -- 15 September 2009)?
How such note should look like?


The *test* version of this year survey can be now found at
the following URL (as in previous year, we use Survs.com)

  http://www.survs.com/survey?id=2PIMZGU0&channel=TFN2Y52K7Y

ATTENTION: All data in test survey would be deleted when survey
would start for real!


Below there is rendered form of survey
................................................................
Git User's Survey 2009

This survey is anonymous, but all information that the users provide
(raw data) will be publicly available on the Git Wiki, at
http://git.or.cz/gitwiki/GitSurvey2009, to allow for independent
analysis.

Note that you may skip questions as you like.

You can also return to this survey after submission, and correct it,
or fill more questions later. This feature makes this survey to
require to have COOKIES ENABLED, at least for this site, to be able to
submit.


About you 
~~~~~~~~~
1. What country do you live in?
2. How old are you (in years)?

Getting started with Git
~~~~~~~~~~~~~~~~~~~~~~~~
3. Have you found Git easy to learn?
    * Very easy
    * Easy
    * Reasonably easy (average)
    * Hard
    * Very hard

4. Have you found Git easy to use?
    * Very easy
    * Easy
    * Reasonably easy (average)
    * Hard
    * Very hard

5. Which Git version(s) are you using?
    * pre 1.3
    * 1.3.x
    * 1.4.x
    * 1.5.x
    * 1.6.x
    * minor (maintenance) release 1.x.y.z
    * 'master' branch of official git repository
    * 'next' branch of official git repository
    * other, please specify

You can find git version by using "git --version" or "git version".

"Minor release" is additional specification, so if you for example use
git version 1.6.3.3, please check both "1.6.x" and "minor release".

6. Rate your own proficiency with Git:
    * 1. novice
    * 2. casual, needs advice
    * 3. everyday use
    * 4. can offer advice
    * 5. know it very well

You can think of it as 1-5 numerical grade of your proficiency in Git.
How you use Git

7. I use Git for (check all that apply):
    * work projects
    * unpaid projects
    * proprietary project
    * OSS development
    * private (unpublished) code
    * code (programming)
    * personal data
    * documents
    * static website
    * web app
    * sharing data or sync
    * backup
    * backend for wiki, blog, or other web app
    * managing configuration files
    * frontend to other SCM (e.g. git-svn)
    * other (please specify)

Note that above choices are neither orthogonal nor exclusive.
You might want to check multiple answers even for a single repository.

8. How do/did you obtain Git (install and/or upgrade)?
    * binary package (includes automatic updates in usual situation)
    * source package or script
    * source tarball
    * pull from (main) repository

Explanation: binary package covers pre-compiled binary (e.g. from rpm
or deb binary packages); source package covers things like deb-src and
SRPMS/src.rpm; source script is meant to cover installation in
source-based distributions, like 'emerge' in Gentoo, and it includes
automatic update in source-based Linux distributions.

Note that this question is multiple choices question because one can
install Git in different ways on different machines or on different
operating systems.

9. What operating system do you use Git on?
    * Linux
    * *BSD (FreeBSD, OpenBSD, NetBSD, etc.)
    * MacOS X (Darwin)
    * MS Windows/Cygwin
    * MS Windows/msysGit (MINGW)
    * OpenSolaris
    * other Unix
    * Other, please specify

On Unix-based operating system you can get the name of operation
system by running 'uname'.

10. What do you use to edit contents under version control with Git?
    What kind of editor, IDE or RAD you use working with Git?

    * simple text editor
    * programmers editor
    * IDE or RAD
    * WYSIWYG tool
    * other kind - please specify

* "simple text editor" option includes editors such as pico, nano,
  joe, Notepad,

* "programmets editor" option includes editors such as Emacs/XEmacs,
  Vim, TextMate, SciTE (syntax highlighting, autoindentation,
  integration with other programmers tools, etc.)

* "IDE (Integrated Development Environment) and RAD (Rapid Application
  Development)" option includes tools such as Eclipse, NetBeans IDE,
  IntelliJ IDE, MS Visual Studio, KDevelop, Anjuta, XCode,
  Code::Blocks but also tools such as Quanta+, BlueFish or Screem (for
  editing HTML, CSS, PHP etc.), and Kile or LEd for LaTeX.

* "WYSIWYG tools" option includes word processors such as MS Office or
  OpenOffice.org, but also tools such as Adobe Acrobat (for PDF) or
  GIMP (for images), or WYSIWYG DTP tools such as QuarkXPress,
  PageMaker or Scribus, or WYSIWYG HTML editors such as FrontPage,
  Dreamweaver or KompoZer.

11. What Git interfaces, implementations, frontends and tools do you use?
    * git (core) commandline
    * JGit (Java implementation)
    * library / language binding (e.g. Grit or Dulwich)
    * Cogito (DEPRECATED)
    * Easy Git
    * Pyrite
    * StGIT
    * Guilt
    * TopGit
    * pg aka Patchy Git (DEPRECATED)
    * gitk
    * git gui
    * QGit
    * GitView
    * Giggle
    * GitNub
    * GitX
    * git-cola
    * tig
    * TortoiseGit
    * Git Extensions
    * git-cheetah
    * git-instaweb
    * git-sh
    * Gitosis (as admin)
    * repo (to manage multiple repositories)
    * editor/IDE VC integration
    * filemanager integration / shell extension (any)
    * graphical history viewer/browser (any)
    * graphical commit tool (any)
    * graphical diff tool
    * graphical merge tool
    * graphical blame or pickaxe tool
    * my own scripts
    * Other (please specify)

Here graphics diff tool means tools such as Kompare, and graphical
merge tool means tools such as Meld and KDiff3. Those answers include
graphical merge and diff tools used by programmers editors and IDEs.

"graphical history browser (any)" covers tools such as gitk, QGit,
Giggle, tig etc., but also built-in git commands such as "git log
--graph" and "git show-branch". If you use one of mentioned tools _as_
history browser, mark both a tool and "graphical history browser
(any)"; if you use some graphical history viewer not listed here,
please both mark this answer and specify it in the "other tool"
answer.

Similarly for other answers marked "(any)".

12. What tool (or kind of tool) would you like to have Git support in?
    (e.g. IDE, RAD, editors, continuous integration, software hosting,
     bugtracker, merge tool...)
    (this includes language bindings and Git (re)implementations)

    free-form essay

13. Which git hosting site do you use for your projects?
    (Please check only hosting sites where you publish/push to)
    * repo.or.cz
    * GitHub
    * Gitorious
    * Savannah
    * SourceForge
    * Assembla
    * Unfuddle
    * kernel.org
    * freedesktop.org
    * Alioth
    * Fedora Hosted
    * git hosting site for set of related projects (e.g. OLPC)
    * generic site without git support
    * self hosted
    * Other (please specify)

14. How do you fetch/get changes from upstream repositories?
    * git protocol (e.g. git://example.com/repo.git)
    * ssh (e.g. ssh://example.com/repo.git or user@example.com:/repo.git)
    * http (e.g. http://example.com/repo.git)
    * rsync (DEPRECATED) (e.g. rsync://example.com/repo.git)
    * same filesystem (e.g. /path/to/repo.git or file:///path/to/repo.git)
    * via git-bundle
    * foreign SCM import / script like git-svn
    * Other, please specify

This question asks about how do you get changes (updates) from
projects you follow into your local repository. It is not about how do
you get latest version of Git.

Fetching (or rather cloning) via bundle could mean that project
publishes ready for download bundles to reduce traffic and load on
server (download of bundle can be resumed, git-clone currently cannot;
one can also distribute bundle using P2P).

15. How do you publish/propagate your changes?
    * push
    * pull request (+ any form of announcement / notification)
    * format-patch + email
    * format-patch + other (e.g. reviewboard, issue tracker or forum)
    * git bundle
    * git-svn (to Subversion repository)
    * git-p4 (to Perforce repository)
    * foreign SCM interface (other than mentioned above)
    * other - please specify

Publishing via bundle could mean sending bundle via email, or posting
it on review board (or forum).

16. How often do you use the following forms of git commands
    or extra git tools?

    	          never | rarely | sometimes | often
      git add -i / -p 				
      git add -u / -A 				
      git am 				
      git am -i 				
      git apply 				
      git apply --whitespace=fix 				
      git archive 				
      git bisect 				
      git bisect run <cmd> 				
      git annotate 				
      git gui blame 				
      git blame 				
      git blame -L <start>,<end> etc. 				
      git bundle 				
      git cherry 				
      git cherry-pick 				
      git cherry-pick -n / --no-commit 				
      git citool 				
      git clean 				
      git add + git commit 				
      git commit -a 				
      git commit <file>... 				
      git commit -i <file>... 				
      git commit --amend 				
      git cvsexportcommit 				
      git cvsserver 				
      git daemon 				
      git daemon (pushing enabled) 				
      git difftool 				
      git ... --dirstat 				
      git fetch [<options>] 				
      git filter-branch 				
      git format-patch 				
      git grep 				
      git imap-send 				
      git instaweb 				
      git log --grep/--author/... 				
      git log -S<string> (pickaxe search) 				
      git log --graph 				
      git merge 				
      git merge with strategy 				
      git merge --squash 				
      git mergetool 				
      git pull (no remote) 				
      git pull --rebase [<options>] 				
      git pull <remote> 				
      git pull <URL> <ref> 				
      git push 				


This question (and its continuation below) is entirely optional.

17. How often do you use the following forms of git commands
    or extra git tools? (continued)

    	          never | rarely | sometimes | often
      git relink 				
      git rebase 				
      git rebase -i 				
      git reflog or git log -g 				
      git remote 				
      git remote update 				
      git request-pull 				
      git revert 				
      git send-email 				
      git show-branch 				
      git shortlog 				
      git shortlog -s 				
      git stash 				
      git stash --keep-index 				
      git submodule 				
      git subtree 				
      git svn 				
      git whatchanged 				
      git gui 				
      gitk 				

Explanation: "Rarely" means that you use mentioned form of command
either rarely, or you have used it only a few times.

Questions 16 and 17 (its continuation) are purely optional (as are the
rest of questions in survey). If you don't feel like filling this
questions, please skip them.

Note: git-subtree is managed out of tree, as a separate project (not
in git.git repository, not even in contrib/ area).

18. Which of the following features have you used?
    * git bundle (off-line transport)
    * eol conversion (crlf)
    * gitattributes
    * mergetool and/or difftool, or custom diff/merge driver
    * submodules (subprojects)
    * subtree merge (optionally git-subtree)
    * separate worktree / core.worktree
    * multiple worktrees (git-new-worktree)
    * alternates mechanism (sharing object database)
    * stash (optionally "git stash --keep-index")
    * shallow clone (e.g. "git clone --depth=<n>")
    * detaching HEAD (e.g. "git checkout HEAD^0")
    * interactive rebase (small scale history editing)
    * interactive commit / per-hunk comitting / partial commit
    * commit message templates
    * git-filter-branch or equivalent (large history rewriting)
    * bisect (optionally "git bisect run <script>")
    * committing with dirty tree (keeping some changes uncommitted)
    * non-default hooks (from contrib/hooks/ or other)
    * shell completion of commands
    * git-aware shell prompt
    * git aliases, shell aliases for git, or own git scripts
    * Other, please specify

19. What features would you like implemented in Git?
    What features are you missing?

    free-form essay

EXAMPLES: partial / subtree checkout, commit annotations aka
git-notes, refs/replace mechanism, "smart" HTTP protocol (git via
HTTP), resomable clone/fetch, lazy clone (on demand downloading of
objects), wholesame directory rename detection, syntax highlighting
and/or side-by-side diffs in gitweb, graphical merge tool integrated
with git-gui, etc.  


What you think of Git 
~~~~~~~~~~~~~~~~~~~~~
20. Overall, how happy are you with Git?
    * unhappy
    * not so happy
    * happy
    * very happy
    * completely ecstatic

21. In you opinion, which areas in Git needs improvement?
    Please state your preference.
	         don't need | a little | some | much
      user-interface 				
      documentation 				
      performance 				
      more features 				
      tools (e.g. GUI) 				
      localization (translation) 				


Changes in Git (since year ago, or since you started using it)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
22. Did you participate in previous Git User's Surveys?
    * in 2006
    * in 2007
    * in 2008

23. How do you compare current version with version from year ago?
    * better
    * no changes
    * worse
    * cannot say


Documentation. Getting help, staying in touch.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
24. How useful have you found the following forms of Git documentation?

	            never used | not useful | somewhat useful | useful
      Git Wiki 				
      on-line help 				
      help distributed with git 				

* Git Wiki can be found at http://git.or.cz/gitwiki
* on-line help includes, among others, Git Homepage
  (http://git-scm.com) and "Git Community Book"
  (http://book.git-scm.com)
* help distributed with git include manpages, manual, tutorials,
  HOWTO, release notes, technical documentation, contrib/examples/

25. Have you tried to get Git help from other people?
    * Yes
    * No

26. What channel did you use to request help?
    * git mailing list (git@vger.kernel.org)
    * "Git for Human Beings" Google Group
    * IRC (#git)
    * IRC (other git/SCM related, e.g. #github)
    * request in blog post or on wiki
    * asking git guru/colleague
    * project mailing list, or IRC, or forum
    * Twitter or other microblogging platform
    * instant messenging (IM) like XMPP/Jabber
    * StackOverflow
    * other (please specify)

27. If yes, did you get these problems resolved quickly and to your liking?
    * Yes
    * No
    * Somewhat

28. Which communication channels do you use?
    Do you read the mailing list, or watch IRC channel?
    * git@vger.kernel.org (main)
    * Git for Human Beings (Google Group)
    * msysGit
    * #git IRC channel
    * #github or #gitorious IRC channel
    * #revctrl IRC channel

About this survey. Open forum
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
29. How did you heard about this Git User's Survey?
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

30. What other comments or suggestions do you have that are not
    covered by the questions above?

    free-form essay

If you have cookies enabled, you can always submit partially filled
survey, and return to your answers at later time, completing it later.

......................................................................
-- 
Jakub Narebski
Poland
