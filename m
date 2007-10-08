From: "Jakub Narebski" <jnareb@gmail.com>
Subject: Re: Git User's Survey 2007 unfinished summary continued
Date: Mon, 8 Oct 2007 22:55:49 +0200
Message-ID: <8fe92b430710081355i7d3dbaa2q9a8939b55d7ca7dc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 08 22:56:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ieze0-0008AA-B6
	for gcvg-git-2@gmane.org; Mon, 08 Oct 2007 22:56:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752102AbXJHUzw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Oct 2007 16:55:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752217AbXJHUzw
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Oct 2007 16:55:52 -0400
Received: from wa-out-1112.google.com ([209.85.146.183]:59848 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751656AbXJHUzv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Oct 2007 16:55:51 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1793285wah
        for <git@vger.kernel.org>; Mon, 08 Oct 2007 13:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=kzXQ/OzSrnaKlxc6H3nUN0emh51OH9fKu9peTrt0Puk=;
        b=F0kqiBWZs9gN29CjkaJXjW72XXCDv2DVvUb39P/yYSOMuFaF2a3V8AeNLUWONMGLjxzty1K2JGfQTGg6jutPtvLUc4JiD74/QC2TOam8DolnowKeJ+KK00YycS+9QVWSFkTgj0h5sK3/hmsww9yS4Q7eJUbiafVf/2oyLCgLiCo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=M0/R4CqXClv89E+1Y6EB2C/lkC4DCFjFnfpp/XQw1+vluHXq9t3pERTQFNqaeqP/CCYIk31fY7JdiN6nkgskuhHnpI95v0U516xlH250oNmxvT0vXMtbpRIiNxqJM6DG1hOGSz/GFB7/oiEVsHsc7o9GQuxMq1pnVTxIRTa1NXo=
Received: by 10.114.254.1 with SMTP id b1mr492675wai.1191876950007;
        Mon, 08 Oct 2007 13:55:50 -0700 (PDT)
Received: by 10.114.202.19 with HTTP; Mon, 8 Oct 2007 13:55:49 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60339>

This is continuation of partial summary of Git User's Survey 2007,
ending at state from 28 September 2007.

The survey can be found here:
  http://www.survey.net.nz/survey.php?94e135ff41e871a1ea5bcda3ee1856d9
  http://tinyurl.com/26774s

The data this summary is based on can be found here:
  http://git.or.cz/gitwiki/GitSurvey2007?action=AttachFile&do=get&target=surveydata.csv
  http://tinyurl.com/yusomo

----
There were 683 individual responses

About you
~~~~~~~~~

00. Date of response

  Date                           | Count
  ------------------------------------------
  Before                         | 7
  During                         | 584
  After                          | 92
  ------------------------------------------

The ranges 'before', 'during' and 'after' refers to official duration
of Git User's Survey 2007, from 20 August 2007 to 10 September 2007.
Actually they are corrected to take into account the fact that local
date on survey's server (or UTC date) might be different from local
date on user computer, so duration of survey is taken as from
2007-08-19 to 2007-09-11.

Most responses are from the start of survey, 20 and 21 August (133 and
103 responses respectively).  If anyone is interested I can provide
full date by date histogram.


Getting started with GIT
~~~~~~~~~~~~~~~~~~~~~~~~

07. What helped you most in learning to use it?

  TO DO
  646 / 683 non-empty responses

Some of the responses:
 * documentation (generic)
 * man pages
 * examples / usage cases in man pages
 * everyday GIT, tutorials and user's manual
 * wiki examples
 * reading mailing list / comp.version-control.git
 * people on IRC (not only #git)
 * advice from other users / friends / colleagues
 * (unofficial) documentation on the web: guides, articles, blogs etc.
   [here probably should be a sublist of them, with count]
 * a development community and/or its documentation, mailing list
   e.g. WINE wiki, Source Mage GNU/Linux development community
 * Google (Google searches)
 * helpful error messages
 * source code, reading the parts of git in shell script
 * cogito
 * using git in a live project / experimenting / trial and error
  (That I was able to just delete the entire repository and start
   over.  That all my mistakes stayed local and didn't affect upstream
   repos.)
 * working on an established project that had documented processes for
   using git
 * writing code for both plumbing and Porcelain
   writing documentation / tutorial for project / article
 * understanding the internal representation of the repository;
   good / simple design, basic principles; understanding concepts
 * experience of working in software industry;
   prior experience with version control systems (GNU Arch, SVN, BK, hg)
 * version 1.5
 * gitk, qgit; git-gui

One of more interesting:
 * We hired a consultant to give us a tutorial


08. What did you find hardest?

  TO DO
  596 / 683 non-empty responses

Some of the responses:
 * the level of complexity
 * user interface:
   too much / inconsistent commands, too many / cryptic options
   distinction between plumbing and porcelain
   many ways to do a task
   insufficient error messages
   'git <cmd> --help' prints manpage, not concise help summary
 * obtuse command messages
 * weak porcelain
   e.g. git-update-index very central
 * git-merge was plumbing
 * remote / tracking branches
   fetching, pushing and pulling, synchronizing repositories
   the fact that push is not an opposite of pull
   understanding the difference between committing and publishing
 * handling multiple remote repositories
 * merge vs rebase, deciding on proper workflow
   working with topic branches
   modifying a patch series
 * merge defaults (which branch gets merged)
 * git vs StGIT: slightly different merge conflict handling
 * making it work in non-POSIX environments
   working with git on case-insensitive and other strange filesystems
   compiling on exotic OS, for example AIX
   generating man pages
 * lack of / bad / outdated / insufficient / badly structured docs
   hard to find something in the documentation
   git lingo in documentation, documentation for users who know git
   using Cogito in some of documentation
 * understanding of concepts, thinking in git way
   understanding basic concepts and terminology
 * distributed SCM concepts, paradigm shift
   idea of non-linear history
 * index (staging area): understanding, having it visible
 * git-diff not showing added files
 * commands named differently from equivalents in other SCM
   differences from other SCM: git-commit needs '-a' to commit all
   changes, strange semantics of git-add, multiple branches in repo
   understanding terminology
 * importing history from other SCM (bzr, svn)
 * reverting changes, amending commit, undoing a commit
 * keeping track of where am I, of which version I'm working with
   finding which branch the change was made on
 * lerning to use it as maintainer
   maintaining "perfect patch series", keeping history clean
   rewritig history before 'git rebase -i'
 * dealing with merge conflicts
   figuring how to undo failed merge and restart it
 * learning conventions git expects but didn't document clearly
   like commit message formatting
 * setting up shared repo / shared server
   setting up remote repository
 * dealing with modified files (dirty tree) when switching branches,
   merging (pulling) and rebasing
 * checking out past revisions (or tagged revisions) with the
   intention to return to newer revision
 * creating independent branch, i.e. branch without ancestry
 * exploring the history and previous versions of particular files
   which are renamed and/or moved around, especially before --follow
   was added
 * some hot-shot peple in the community (on the mailing list)
 * setting up gitweb
 * having to use CLI interface
 * no <some language> documentation

More interesting:
 * All idiosyncrasies that make (made) sense for Linus' workflow but
   aren't really orthogonal or predictable.
 * Listening to whiners complain about how hard it was to learn
 * Thinking outside the narrow box defined by previous SCMs.
 * Not having used an SCM before!
 * Following the explosive growth of features.
 * Having a day job taking most of my time away from git.
 * Convincing my boss to use it.

Conclusions:
 - some of the things got corrected, like separate remote layout being
   default for non-bare repositories, using git-add (porcelain)
   instead of git-update-index (plumbing) in documentation and command
   messages, promoting git-merge to porcelain, creating git-remote for
   managing multiple repositories and remote branches, better
   documentation including creating git user's manual.
 - some things are hard because of historical reasons, such like
   naming of commands, or consistency of options, and would be
   difficult to change.
 - doing things "git way", such as making index visible (and requiring
   'git commit -a' to commit changes in all files), or rename
   detection instead of rename tracking, or storing filenames and file
   contents 'as-is' (without translation) are I think here to stay
 - some of things are intrinsically hard, and would stay that way,
   for example the distributed SCM concept, or nonlinear history.


How you use GIT
~~~~~~~~~~~~~~~

22. What projects do you track (or download) using GIT
    (or git web interface)?

  TO TABULARIZE
  560 / 683 non-empty responses

A note: this question was meant to list projects which one _tracks_,
not the ones he/she maintains, meaning the projects in the remotes
(section).

Tracked projects can be divided into the following categories:
 * undisclosed: proprietary code / work projects, own projects, etc.
 * Linux kernel an kernel related projects (like udev or kvm)
 * git related: git, gitk, git-gui, git-gui-i18n, stgit, tig,...
 * freedesktop (and related) projects: XCB, Compiz, Mesa3D, Cairo,...
 * Linux distributions: Source Mage, Slind,... (a few)
 * tracked via git-svn, e.g. nsd, KDE, GIMP, FreeCiv
 * others with official git repositories (like XMMS2 or ELinks)
 * others with unofficial git repositories (like OpenOffice.org)

There are more that 100 different projects tracked mentioned in survey
(not all of them _choose_ git as their SCM).


Internationalization
~~~~~~~~~~~~~~~~~~~~

32. What do you need translated?

  TO TABULARIZE
  172 / 683 non-empty responses

Summary of responses, without count (which I guess is most important):
 * user interface: command messages and error messages
 * GUI: git-gui, gitk
 * man pages and commands usage
   ('git <cmd> --help' , git <cmd> --usage')
 * user's manual, tutorials, intro, howtos
 * website / homepage

-- 
Jakub Narebski
Poland
(temporarily away from Internet)
