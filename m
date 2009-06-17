From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFH] Questions for Git User's Survey 2009
Date: Wed, 17 Jun 2009 19:59:11 +0200
Message-ID: <200906171959.13051.jnareb@gmail.com>
References: <200905291855.03328.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Peter Baumann <waste.manager@gmx.de>,
	Clemens Buchacher <drizzd@aon.at>,
	David Aguilar <davvid@gmail.com>,
	Erik Faye-Lund <kusmabite@googlemail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 17 19:59:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MGzQJ-00009J-ND
	for gcvg-git-2@gmane.org; Wed, 17 Jun 2009 19:59:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753504AbZFQR7g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jun 2009 13:59:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751916AbZFQR7f
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Jun 2009 13:59:35 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:44409 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753298AbZFQR7d (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jun 2009 13:59:33 -0400
Received: by fg-out-1718.google.com with SMTP id d23so938217fga.17
        for <git@vger.kernel.org>; Wed, 17 Jun 2009 10:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=CjfpQ6NuOAnzAd4BkfKDu6jM5R4tzLb42kEKz/e3ukY=;
        b=buGDeNp3sn9B3qyZhXHZLx73VW4r11/KqtR1l+c3ZvgoqxtrZ6LdFtS0uYwqFIuqv2
         o5Ks0F7xTj1mrAE3N1lJw60b+YeNJ1uUBonxX/5+FoZm9+rkeF9OZU3izzYvyv3BdWXY
         ONXZfS/g+dNk79wk8fgPQsYAtUPjndydvM8oM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=mEJHpBD5sbaklruhU3XQPZPfaz7qcGSmo4fr3VMIAxI8xP5rxbhkwFWt/XavrAh0P5
         gynd7gD75/23qV8UEZiS3HGghbgb/97Oy0i8BN3D7WQz/VPVNwXgJyUUh6XxBmKYMcDm
         0qtHfPMmJjwLLSCmYBgH1X3A5I6q1JkaP8y7s=
Received: by 10.86.68.10 with SMTP id q10mr782199fga.78.1245261574731;
        Wed, 17 Jun 2009 10:59:34 -0700 (PDT)
Received: from ?192.168.1.13? (abvj189.neoplus.adsl.tpnet.pl [83.8.207.189])
        by mx.google.com with ESMTPS id e20sm747566fga.10.2009.06.17.10.59.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 17 Jun 2009 10:59:28 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <200905291855.03328.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121765>

This is current list (after a bit of feedback here on git mailing list)
of proposed questions and of proposed _answers_ (for single choice and
multiple choice questions) for "Git User's Survey 2009".

Comments very much appreciated.

Next version would be put additionally as test survey on Survs.com, 
to test how much time would it take to fill survey.  Note that this
future test run of survey would have data removed before true survey!


Git User's Survey 2009: proposed questions
==========================================

Questions marked with star (e.g. 11.*) are questions which I am not
sure if they should be in this survey.  If there is more than one
question with the same number, and they have different version suffix,
e.g. 10v1 and 10v2, it means that there are laternate versions of the
same question (and of course only one would be in 2009 survey).


About you:
^^^^^^^^^^
01. What country do you live in?
    (free-form question, or drop-down list of countries (select))

02. How old are you (in years)?
    (free-form / text entry, or age range: single choice)

    Possible values for age ranges, taken from previous survey 
    analysis (GitSurvey2008 page on Git Wiki):
      * < 18
      * 18-21
      * 22-25
      * 26-30
      * 31-40
      * 41-50
      * 51-75
      * > 75
 
What do you think about this set of ranges?  Should it be changed?
Or perhaps free-form age is a better solution (it is not as if
analysis of this field was hard).


Getting started with Git
^^^^^^^^^^^^^^^^^^^^^^^^
03. Did you find Git easy to learn?
    (single choice:) 
     * very hard
     * hard
     * reasonably easy / average
     * easy
     * very easy

04. Did you find Git easy to use?  [NEW!]
    (single choice, the same set as in previous question:)
     * very hard
     * hard
     * reasonably easy / average
     * easy
     * very easy

05. Which Git version(s) are you using?
    (multiple choice, as one can for example use different version on
    different machines:) 
     + pre 1.3, 
     + 1.3.x, 
     + 1.4.x, 
     + 1.5.x, 
     + 1.6.x, 
     + 'master',
     + 'next', 
     + minor release 1.x.y.z  [NEW!, ???]
     + other - please explain (free-form field)

06. Rate your own proficiency with Git:
    (single choice:)
     * novice
     * casual, needs advice
     * everyday use
     * can offer advice
     * know it very well (guru)

Actually this is meant to be something like 1-5 numerical
grade of one's proficiency in git.  Do you have other proposals
for naming possible answers?

[The whole section about "Other SCMs" was removed]

How do you use Git?
^^^^^^^^^^^^^^^^^^^
07. I use Git for (check all that apply):
    (multiple choice:) 
     + work projects, 
     + unpaid projects; 
 
     + proprietary code, 
     + OSS development, 
     + private (unpublished) code; 

     + code, 
     + personal data, 
     + documents, 
     + static website, 
     + web app;

     + sharing data or sync, 
     + backup, 
     + wiki/blog/other web app backend,
     + managing configuration files, 
     + frontend to other SCM;
    
     + other - please specify

Empty lines here are used to separate kinds of choices, although most
possibly they would be not present in the final version on Survs.com.
What things are lacking in above list?  Should we remove some less
often used things (but in 2008 survey it is only wiki/blog backend
that received decidely less answers... with 10% / 290 responses)?

08. How do you obtain Git?
    (multiple choice:)
     + binary package, 
     + source tarball, 
     + source package or script[*], 
     + pull from (main) repository
    [*] Explanation: so git is installed in a system of packages

09. What operating system do you use Git on?
    (multiple choice:) 
     + Linux, 
     + MacOS X, 
     + MS Windows/msysGit, 
     + MS Windows/Cygwin, 
     + *BSD (FreeBSD, OpenBSD, NetBSD, etc.), 
     + other Unix, 
     + other - please specify

In this question number of possible answrs was reduced a bit, based on
answers from previous survey.  We might want to put OpenSolaris as
separate from "other Unices" (which would then be "proprietary Unix")
-- what do you think?  Should we pot Solaris, OpenSolaris, AIX, SunOS,
IRIX, SCO SV as separate possibilities instead of groupng them under
'other Unix'?  I'd rather have smaller number of choices; I think this
makes for easier to take survey.

10v1.*What editor, IDE or RAD you use working with Git?
      (either free-form, or multiple choice:) 
      IDE/RAD:
        + Eclipse, 
        + NetBeans,
        + IntelliJ IDEA, 

        + MS Visual Studio, 
        + KDevelop, 
        + Anjuta, 
        + XCode,

      editor:
        + Emacs and XEmacs, 
        + Vim, 
        + Notepad++, 
        + gedit, 
        + Geany,
        + Kate, 
        + TextMate, 
        + 'E' Text Editor, 
        + SciTE, 

      free-form part:
        + other - please specify.

10v2.*What do you use to edit contents under version control with Git?
      What kind of editor, IDE or RAD you use working[*] with Git?
      (multiple choice:)
       + simple text editor[1], 
       + programmers editor[2],
       + IDE or RAD[3], 
       + WYSIWYG tool[4], 
       + other kind - please specify
    [*] this means using it often, and not once or twice
    [1] for example pico, nano, joe, Notepad
    [2] for example Vim, Emacs, TextMate (syntax highlighting,
        autoindentation, integration with other tools, etc.)
    [3] for example Eclipse, KDevelop, Anjuta, MS Visual Studio, Xcode,
        but also Quanta+, BlueFish or Screem for editing HTML, 
        and Kile or LyX for LaTeX.
    [4] word processors such as MS Office or OpenOffice.org,
        but also tools such as Adobe Acrobat (for PDF) or GIMP
        (for images), or WYSIWYG DTP tools such as QuarkXPress,
        PageMaker or Scribus, or WYSIWYG HTML editors such as
        FrontPage, Dreamweaver or KompoZer, etc.

This (optional) question comes in two flavours.  Which one to choose?

There is v1 with detailed list of possible editors and IDEs; the
problem with this version is coming up with comprehensive list of
editors and IDE (to not have too much of free-form 'other' answers,
which one has to analyze), balanced on the other hand with desire to
not have too long (unwieldy) list of answers / possible responses.

Then there is alternate shorter v2 which asks only about "kind" of
editor/RAD one use.  It has much less possible answers (although the
question if all possible reasonable responses are included remains,
only much reduced), which is good... but it also provides less
information.  What other kinds of tools used to edit version managed
content there might be?

11v1. What Git interfaces, frontends and tools do you use?
      (multiple choice:)
      Implementations:
       + git (core) commandline, 
       + JGit, 
       + via library / language binding (e.g. Grit)

      Porcelains:
       + Cogito (DEPRECATED), 
       + Easy Git
       + Pyrite (?)

      Patch and topic branch management interfaces:
       + pg / Patchy Git (DEPRECATED), 
       + StGIT, 
       + Guilt (formerly gq),
       + TopGit

      History viewers and commit tools:
       + gitk
       + git gui
       + QGit
       + GitView
       + Giggle
       + GitNub
       + GitX
       + git-cola (formerly ugit)
       + tig

      Filemanager / shell extensions:
       + TortoiseGit
       + Git Extensions
       + git-cheetah

      Other tools:
       + instaweb
       + git-sh

      Other kinds of tools:
       + editor/IDE VC integration
       + graphical diff tool
       + graphical merge tool
       + graphical blame or pickaxe tool

       + other - please specify:

This combines "Which porcelains / interfaces / implementations do you
use?" with "Which of the following git tools do you use?".  Alternate
version could be asking about only kinds of tools one use, not about
specific tools.  Which would be better, what do you think?

12. What tool (or kind of tool) would you like to have Git support in?
    (this includes language bindings and Git (re)implementations)
    (free-form - essay:)

13. Which git hosting site do you use for your projects?
    (multiple choice:)
     + GitHub, 
     + repo.or.cz, 
     + Gitorious, 
     + Unfudle,
     + Assembla, 
     + Alioth, 
     + Fedora Hosted, 
     + Savannah, 
     + SourceForge,
     + freedesktop.org, 
     + kernel.org, 
     + git hosting site for set of projects
     + self hosted, 
     + generic web site (no git support),
     + other - please specify

Are there other (popular) git hosting sites, or generic software
hosting sites with git support which I missed in above set?  Should
all hosting sites from http://git.or.cz/gitwiki/GitHosting be listed?

14. How do you fetch/get changes from upstream?  [NEW!]
    This means how do you get changes from projects you follow
    or participate in development, into your local repository.
    (multiple choice:) 
     + git protocol, 
     + ssh, 
     + http, 
     + rsync, 
     + same filesystem, 
     + bundle,
     + foreign SCM import/script like git-svn, 
     + other - please specify

15. How do you publish/propagate your changes?
    (multiple choice:) 
     + push, 
     + pull request (+ any form of announcement), 
     + format-patch + email,
     + format-patch + other (e.g. review board or forum), 
     + git bundle, 
     + git-svn, 
     + foreign SCM interface (other than git-svn),
     + other - please specify (free-form:)

16. Which of the following features do (or did) you use?
    (multiple choice:)
     + non-default hooks (from `contrib/hooks/` or custom),
     + working with dirty tree,
     + bisect (optionally "git busect run <script>"), 
     + submodules (subprojects), 
     + subtree merge (optionally git-subtree)
     + integration with IDE/editor,
     + multiple worktrees (git-new-worktree), 
     + gitattributes, 
     + stash (optionally "git stash --keep-index"),
     + separate worktree / core.worktree, 
     + patch management interface (e.g. StGIT or Guilt), 
     + alternates mechanism (sharing object database),
     + git bundle (off-line transport), 
     + git-filter-branch,
     + interactive rebase, 
     + commit message templates, 
     + shallow clone (the --depth=<n> option), 
     + eol conversion (core.autocrlf), 
     + interactive commit / per-hunk comitting / partial commit,
     + detaching HEAD, 
     + gitk or other history viewer, 
     + git-gui or other commit tool, 
     + shell completion, 
     + git-aware shell prompt
     + other - please specify (free-text, single line)

What other important Git features are missing in the above list?
Perhaps the oppiste is true: this list is too long, and some less
commonly used answers should be removed (but which)?

17. What features would you like implemented in Git?
    What features are you missing?
    (free-form: essay)


What do you think of Git?
^^^^^^^^^^^^^^^^^^^^^^^^^
18. Overall, how happy are you with Git?
    (single choice:) 
     * unhappy 
     * not so happy 
     * happy 
     * very happy
     * completely ecstatic

19.*How does Git compare to other SCM tools you have used?
    (single choice:) 
     * git is worse 
     * equal (similar)
     * better than other SCM.

As we removed section about other SCMs, perhaps question comparing git
to other SCMs should also be removed?


Changes in Git
^^^^^^^^^^^^^^
20.*Did you participate in previous Git User's Surveys?
    (multiple choice: 
     + in 2008, 
     + in 2007, 
     + in 2006

21.*How do you compare current version with version from year ago?
    (single choice:) 
     + cannot say[1] 
     + worse 
     + no changes
     + better 
    [1] perhaps this should include situation where one didn't use
        Git for a year?

This whole section is considered for deletion to fit in the 20
questions limit.  If only question about if git improved is removed,
then remaining question in this section about participation in
previous surveys would be moved at the end of survey.


Getting help, staying in touch
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
This group is concatenation of former "Documentation" and "Getting
help, staying in touch" groups.

If we want to push for "Git User's Survey 2009" to have no much more
than 20 questions, perhaps this section should be removed?

22. Which form of documentation do you use?
    (matrix form:)
    columns: never used / not useful / somewhat / useful,
    rows:
      # Git Wiki, 
      # on-line help, 
      # help distributed with Git,

All of former "Documentation" questions: "Do you use the Git wiki?",
"Do you find Git wiki useful?", "Do you find Git's on-line help
(homepages, documentation) useful?", "Do you find help distributed
with Git useful?" are compressed together to single question
encompassing most of issue touched in mentioned group (section).

The question "Do you contribute to Git wiki?" and open-ended
(free-form) question "What could be improved on the Git homepage(s)?"
were removed from the survey.

23.*Have you tried to get Git help from other people?
    (single choice:)
     * yes 
     * no

This question "Have you tried to get Git help from other people?" is a
bit redundant: if one answered "What channel did you use to request
help?" then one did try to get help, isn't it?  But only a bit; I
think it would help to have this question separately, and not only
implied.  On the other hand we want to reduce number of questions in
the survey.

24. What channel did you use to request help?
    (multiple choice:) 
     + git mailing list, 
     + 'Git for Human Beings' Google group (???)
     + IRC (#git), 
     + IRC (other),
     + request in blog post or on wiki, 
     + asking guru/colleague,
     + project mailing list, or IRC, or forum, 
     + Twitter or other microbloggin platform,
     + instant messenging (IM) like XMPP/Jabber, 
     + StackOverflow, 
     + other - please specify

Compared to last year survey, "IRC (#github)" was replaced by more
generic "IRC (other)"; some of responses in 'other' from 2008 survey
were added (more common / more generic).  I have also added
StackOverflow, collaborative programming Q & A site (started in 2009).

25.*If yes, did you get these problems resolved quickly
    and to your liking?
    (single choice:) 
     * yes 
     * somewhat 
     * no

This question doesn't bring much information to us, and it counts
agains number of questions in survey.  Should it be removed, or should
it stay (and why)?

26. Do you read the mailing list, or watch IRC channel?
    (multiple choice:)
     + git@vger.kernel.org (main mailing list), 
     + msysGit mailing list, 
     + Git for Human Beings (Google Group), 
     + #git IRC channel, 
     + #github IRC channel


Open forum
^^^^^^^^^^
27.*Should Git User's Survey be repeated next year?
    (single choice:)
      * yes 
      * no 
      * undecided

28. What other comments or suggestions do you have 
    that are not covered by the questions above?
    (free-form: essay)


-- 
Jakub Narebski
Poland
