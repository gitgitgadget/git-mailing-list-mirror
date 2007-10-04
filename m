From: "Jakub Narebski" <jnareb@gmail.com>
Subject: Git User's Survey 2007 unfinished summary (long)
Date: Thu, 4 Oct 2007 11:12:55 +0200
Message-ID: <8fe92b430710040212u332bb4e5yfa6c10b8236c6301@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 04 11:13:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdMlr-0000Cy-3G
	for gcvg-git-2@gmane.org; Thu, 04 Oct 2007 11:13:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754601AbXJDJNG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Oct 2007 05:13:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754281AbXJDJNE
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Oct 2007 05:13:04 -0400
Received: from wa-out-1112.google.com ([209.85.146.176]:56717 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753360AbXJDJM4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2007 05:12:56 -0400
Received: by wa-out-1112.google.com with SMTP id v27so130504wah
        for <git@vger.kernel.org>; Thu, 04 Oct 2007 02:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=yc0nquyVV/aaJUtfrFmadBD8Ej2CbKL2Vgq98BehFyE=;
        b=JZpDHCVnPJK4j4GdZ9CO9bB1C9tO4FEj6LPCYjYML8dZq8iKl2cNI1YXPQ0p60I7sB+yuLFI7jehwgVVEzy4MGFA7aEZmKPrM5e54d6r5Hf5wkCKG85iFJg1xS3aNekJ/eQysGRCt75ThMsrNFTaqYL7ksWNYt7UG2kzvEuwYSw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=gVJwbT/ZtYgMvKM/F4JurzZ/Pd65QmEJvWQwmKc9gKtHcDdRr73G6K/qtQxQAOau6d+o0HrtyRRdLqjHqpyzb10yo9VzXL9pgLTtKjZDiGYnyb20n8h5vmrfTEmMx5yqzXqhVwtJUZKaB9nOLG4AHsvhhM1GBCkY9vwXtgK0bN8=
Received: by 10.114.37.1 with SMTP id k1mr5396659wak.1191489175083;
        Thu, 04 Oct 2007 02:12:55 -0700 (PDT)
Received: by 10.114.202.19 with HTTP; Thu, 4 Oct 2007 02:12:55 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59935>

This is partial summary of Git User's Survey 2007,
ending at state from 28 September 2007.

The survey can be found here:
  http://www.survey.net.nz/survey.php?94e135ff41e871a1ea5bcda3ee1856d9
  http://tinyurl.com/26774s

----
There were 683 individual responses

About you
~~~~~~~~~

01. What country are you in?

  Answer                         | Count
  ------------------------------------------
  Algeria                        | 1
  Argentina                      | 3
  Australia                      | 25
  Austria                        | 9
  Belgium                        | 5
  Brazil                         | 20
  Bulgaria                       | 1
  Canada                         | 44
  Chile                          | 2
  China                          | 4
  Colombia                       | 2
  Czech Republic                 | 10
  Denmark                        | 7
  Ecuador                        | 1
  Estonia                        | 1
  European Union                 | 1
  Finland                        | 23
  France                         | 36
  Germany                        | 64
  Greece                         | 3
  Hungary                        | 2
  India                          | 13
  Ireland                        | 2
  Israel                         | 6
  Italy                          | 14
  Japan                          | 4
  Jersey                         | 1
  Latvia                         | 1
  Malaysia                       | 1
  Mexico                         | 1
  Netherlands                    | 15
  New Zealand                    | 5
  Norway                         | 14
  Philippines                    | 3
  Poland                         | 6
  Portugal                       | 2
  Puerto Rico                    | 1
  Romania                        | 1
  Russian Federation             | 6
  Samoa                          | 1
  Serbia                         | 1
  Singapore                      | 2
  Slovak Republic                | 1
  Slovenia                       | 2
  South Africa                   | 4
  Spain                          | 11
  Sri Lanka                      | 1
  Sweden                         | 14
  Switzerland                    | 15
  UK / US                        | 1
  United Kingdom                 | 40
  United States of America       | 218
  Venezuela                      | 1
  Vietnam                        | 1
  ------------------------------------------
  Base                           | 673 / 683
  Total (sum)                    | 673

England and Scotland counts as United Kingdom here.
Table is sorted in alphabetical order.

As one can easily see, slightly less than third of GIT users
are in the USA (those who answered this survey).


02. What is your preferred non-programming language?

This is multiple answers question, although most people
gave only one preferred language.

  Answer                         | Count
  ------------------------------------------
  Afrikaans                      | 1
  Bulgarian                      | 1
  Castellano                     | 2
  Catalan                        | 1
  Chinese                        | 2
  Czech                          | 10
  Danish                         | 6
  Dutch                          | 12
  English                        | 416
  Finnish                        | 16
  French                         | 33
  Galician                       | 1
  German                         | 58
  Greek                          | 2
  Hebrew                         | 1
  HibernoEnglish                 | 1
  Hungarian                      | 3
  Italian                        | 9
  Japanese                       | 1
  LSF (French sign language)     | 1
  Norwegian                      | 4
  Polish                         | 5
  Portuguese                     | 11
  Romanian                       | 1
  Russian                        | 13
  Serbian                        | 1
  Slovenian                      | 2
  Spanish                        | 13
  Swedish                        | 13
  Swiss                          | 1
  Ukrainian                      | 1
  Vietnamese                     | 1
  ------------------------------------------
  invalid (computer language)    | 37
  not understood                 | 4
  ------------------------------------------
  Base                           | 662 / 683
  Total (sum)                    | 684

The question itself is not well formulated, as one can see from the
number of answers with computer language, and "not understood"
answers.  I am not native English speaker, but there were suggestions
to use "natural language" instead of "non-programming language".

Around two third of git users prefer English language, at least for
dealing with computers.


03. How old are you?

  Answer                         | Count
  ------------------------------------------
   < 18                          | 11
  18-21                          | 75
  22-25                          | 174
  26-30                          | 203
  31-40                          | 146
  41-50                          | 45
  51-75                          | 13
  76+                            | 0
  ------------------------------------------
  Base                           | 667 / 683
  Total (sum)                    | 667

Youngest git user who answered this survey is 14 years old,
oldest is 74 years old. This is quite a span, I'd say,  The age of 25
got most count (51 answers).


04. Which programming languages you are proficient with?

  Answer                         | Count
  ------------------------------------------
  C                              | 582
  shell                          | 449
  Perl                           | 244
  Python                         | 316
  Tcl/Tk                         | 26
  ------------------------------------------
  Base                           | 648 / 683
  Total (sum)                    | 1617

The choices include programming languages used by git.  This is
multiple choice question (you can be proficient in more than one
programming language).

It look like there is only around 3/4 people proficient in Perl as
compared to Python; it looks like Python is more popular. C is most
popular; shell is more popular than Perl or Python.  The fewest people
are proficient in Tcl/Tk. I'm sorry, git-gui and gitk guys; it looks
like not many developers... around 4% of git users.


Getting started with GIT
~~~~~~~~~~~~~~~~~~~~~~~~

05. How did you hear about GIT?

  Answer                         | Count
  ------------------------------------------
  LKML                           | 109
  LWN (Linux Weekly News)        | 39
  KernelTrap                     | 15
  KernelTraffic                  | 1
  kernel.org                     | 9
  freedesktop.org                | 5
  Linus presentation at Google   | 48
  Slashdot                       | 28
  blog                           | 19
  community site[*1*]            | 12
  news site                      | 34

  searching Internet[*2*]        | 6
  other SCM / SCM research[*3*]  | 20
  Internet                       | 32
  IRC                            | 6

  Linux kernel uses it           | 73
  some project uses git          | 47

  developer by name[*4*]         | 21
  friend                         | 39
  word of mouth                  | 15
  work / coworker                | 22

  initial GIT announcement       | 12
  BitKeeper news                 | 24
  ------------------------------------------
  don't remember                 | 13
  other / uncategorized          | 44
  ------------------------------------------
  Base                           | 658 / 683
  Total (sum)                    | 693

[*1*] Community site are sites like Digg, Reddit and "planet" sites.
[*2*] This includes answer of "Google"
[*3*] This includes some other SCM mailing list, VCS comparison,
      and searching for an SCM.
[*4*] Linus Torvalds, Carl Worth, Keith Packard, Randal Schwartz,...

This was free-form question, and tabularizing answers was quite a work.
It is taken as multiple choice question (for example link to Linus
presentation at Google found at Slashdot).

Other / uncategorized includes for example GoogleTalk IM, 3 answers
IIRC.

Note that Linus Torvalds presentation at Google / YouTube got it's
own category, and generated quite a bit of git users.


06. Did you find GIT easy to learn?

  Answer                         | Count
  ------------------------------------------
  very easy                      | 38
  easy                           | 136
  reasonably                     | 318
  hard                           | 131
  very hard                      | 33
  ------------------------------------------
  Base                           | 656 / 683
  Total (sum)                    | 656

Nice gaussian curve. Most users find it reasonably easy to use.
On the other hand git is not considered easy...


07. What helped you most in learning to use it?

  TO DO
  646 / 683 non-empty responses


08. What did you find hardest?

  TO DO
  596 / 683 non-empty responses


09. When did you start using git? From which version?

  Answer                         | Count
  ------------------------------------------
  (no version string)            | 165
  0.99x                          | 26
  0.x                            | 12
  1.0x                           | 31
  1.1x                           | 9
  1.2x                           | 12
  1.3x                           | 22
  1.4x                           | 147
  1.5x                           | 198
  ------------------------------------------
  Base                           | 626 / 683
  Total (sum)                    | 626

NOTE! This table shows _only_ answers in which there was given git
version explicitely. Some people gave date, some people wrote how long
they have used git. Those answers needs also processing; they are
skipped here.

It looks like the git users community is divided into part of users
who started using it from beginning, or almost from beginning, and
users which started using git post v1.3.0 (post e.g. making separate
remotes the default layout of branches).


Other SCMs
~~~~~~~~~~

10. What other SCMs did/do you use?

This question is not well thought, as it gathers together (in the
free-form which is not easy to tabularize with large number of
responses we got) SCMs which one used and no longer uses, SCMs which
are used in parallel with git, and SCMs which are used instead of git
(which are chosen as main SCM for a project). Nevertheless it shows
with which VCS, and its conceps, are users familiar with.

  Answer                         | Count
  ------------------------------------------
  AccuRev                        | 3
  Aegis                          | 1
  Bazaar                         | 19
  Bazaar-NG                      | 50
  BitKeeper                      | 27
  CCC                            | 1
  CMS (Digital)                  | 1
  CMS (VAX)                      | 1
  CMS (VMS)                      | 1
  CVCS                           | 1
  CVS                            | 454
  ClearCase                      | 43
  CodeMgr                        | 1
  Continuus                      | 1
  Darcs                          | 78
  DesignSync                     | 1
  GNU Arch                       | 57
  Mercurial                      | 92
  Monotone                       | 31
  Omniworks                      | 1
  OpenCM                         | 1
  PRCS                           | 1
  PVCS                           | 12
  Perforce                       | 50
  Quilt                          | 2
  RCS                            | 61
  SCCS                           | 18
  SCM                            | 1
  SCSS                           | 1
  SVK                            | 19
  Serena Version Manager         | 1
  SourceForge                    | 1
  Sourcerer's Apprentice         | 1
  StarTeam                       | 4
  Subversion                     | 524
  Sun NSE                        | 2
  Sun TeamWare                   | 4
  VCS                            | 1
  VMS                            | 1
  VSS                            | 26
  'cp -a'                        | 1
  akpm patch scripts             | 1
  custom in-house tools          | 1
  diff patch                     | 2
  none                           | 9
  notes-on-paper-made-by-hand    | 1
  really horrible stuff          | 1
  scripts for 'shadow trees'     | 1
  tarballs                       | 1
  tlib                           | 1
  undisclosed                    | 1
  ------------------------------------------
  Base                           | 654 / 683
  Total (sum)                    | 1615

The above table is in alphabetical order. It was generated from
free-form answers, tabularized as multiple choice answer.

Note that this question does not distinguish between SCMs/VCSs which
were used prior to Git and used no longer, SCMs which are used beside
(in parallel) to Git perhaps interacting with Git, and SCMs which are
used instead of Git. Also note that this is _Git User's_ survey, so it
those number for example do not represent number of e.g. users of
Mercurial as compared to e.g. users of Subversion.

Below there is table of SCM used, sorted by the number of responses.
Note that annotations (like "a little CVS") were not weighted here.
Only SCMs which has count more that 10 are shown. One person can (and
usually did) chose more than one SCM.

  Answer                         | Count
  ------------------------------------------
  Subversion                     | 524
  CVS                            | 454
  Mercurial                      | 92
  Darcs                          | 78
  RCS                            | 61
  GNU Arch                       | 57
  Bazaar-NG                      | 50
  Perforce                       | 50
  ClearCase                      | 43
  Monotone                       | 31
  BitKeeper                      | 27
  VSS (MS Visual SourceSafe)     | 26
  Bazaar                         | 19
  SVK                            | 19
  SCCS                           | 18
  PVCS                           | 12

  tla+baz+bzr                    | 129
  ------------------------------------------
  Base                           | 654 / 683

As you can see two most popular SCMs are Subversion ('svn') and CVS,
with Subversion being a bit more popular. Among distributed SCMs
with most count are Mercurial ('hg') and Arch and its descendants
('tla', 'baz', 'bzr'). From proprietary (non-OSS) revision control
systems Perforce ('p4'), ClearCase (and ClearCase UCM), BitKeeper ('bk')
and Visual SourceSafe (aka. that awful M$ one ;-) got most count.

Note that the count for given version control system does not reflect
_preferences_ of git users. One can be forced to use specified SCM.

See also question 35: "How does GIT compare to other SCM?".


11. Why did you choose GIT?

  TO DO
  643 / 683 non-empty responses


12. Why did you choose other SCMs?

  TO DO
  606 / 683 non-empty responses


13. What would you require from GIT to enable you to change,
    if you use other SCM for your project?

  TO DO
  474 / 683 non-empty responses


14. Did you import your repository from foreign SCM? What SCM?

  Answer                         | Count
  ------------------------------------------
  N/A                            | 15
  No                             | 169
  Yes                            | 372
  ------------------------------------------
  Base                           | 556 / 683
  Total (sum)                    | 556

This is anly partial analysis, as it deals only with first part of
question (which, because of second part, has free-form structure and
needed processing).

One can see that around half of git users have imported (at least one
project) from foreign SCM.


15. What tool did you use for import?

  Answer                         | Count
  ------------------------------------------
  by hand                        | 7
  custom script                  | 21
  fast-import script             | 3

  Tailor                         | 28
  -------------------------------------------
  git-cvsimport                  | 81
  parsecvs                       | 12
  fromcvs                        | 2
  cvs2git                        | 1
  cvstogit                       | 1

  git-svn                        | 150
  git-svnimport                  | 66

  git-archimport                 | 15
  bk2git (customized)            | 1
  darcs2git                      | 4
  git-p4                         | 4
  git-p4import                   | 1
  git-ucmimport                  | 1
  hg-to-git                      | 2
  hg2git                         | 2
  hgpullsvn                      | 1
  hgsvn                          | 1
  moin2git                       | 1
  ------------------------------------------
  unspecified                    | 18
  N/A                            | 114
  ------------------------------------------
  Base                           | 467 / 683
  Total (sum)                    | 538


16. Do your GIT repository interact with other SCM? Which SCM?

  Answer                         | Count
  ------------------------------------------
  N/A                            | 35
  No                             | 228
  Yes                            | 228
  ------------------------------------------
  Base                           | 491 / 683
  Total (sum)                    | 491

This is anly partial analysis, as it deals only with first part of
question (which, because of second part, has free-form structure and
needed processing).

One can see that around third of git users interacts (for at least one
project) with foreign SCM, as compared to half of git users which have
imported other SCM.


17. What tool did/do you use to interact?

  Answer                         | Count
  ------------------------------------------
  by hand                        | 10
  custom script                  | 16

  Tailor                         | 4
  convert-repo                   | 1

  fromcvs                        | 1
  git-cvsexportcommit            | 8
  git-cvsimport                  | 19
  git-cvsserver                  | 2

  git-svn                        | 164
  git-svnimport                  | 2

  git-p4                         | 4
  git-p4import                   | 1
  -----------------------------------------
  unspecified                    | 2
  N/A                            | 153
  ------------------------------------------
  Base                           | 385 / 683
  Total (sum)                    | 388

The only tool which really allows to interact (two-way) with other SCM
is git-svn (164 / 232).


How you use GIT
~~~~~~~~~~~~~~~

18. Do you use GIT for work, unpaid projects, or both?

  Answer                         | Count
  ------------------------------------------
  work                           | 56
  unpaid projects                | 212
  both                           | 377

  work + both                    | 433
  ------------------------------------------
  Base                           | 645 / 683
  Total (sum)                    | 645

Around two third of people use git at work, or for work.

See also question 55: "Would commerical (paid) support from a support
vendor be of interest to you/your organization?"


19. How do you obtain GIT?

  Answer                         | Count
  ------------------------------------------
  binary package                 | 283
  source tarball                 | 210
  pull from main repository      | 153
  ------------------------------------------
  Base                           | 646 / 683
  Total (sum)                    | 646

Around half more people use binary packages than source tarball (or
source package, I think). More than half of people compile its own git
(pull is also followed by compilation).

In earlier partial survey summary, from 27-08-2004 (a month earlier)
there were twice as many people installing git from binary packages.


20. What hardware platforms do you use GIT on?
    (on Unices: result of "uname -i")

Note: 'uname -i' does not work on all Unices. I'm sorry for this
mistake.

  Answer                         | Count
  ------------------------------------------
  Intel                          | 73
  Athlon                         | 2
  i386                           | 171
  i586                           | 9
  i686                           | 60
  IA-32                          | 6
  IA-64                          | 8
  AMD                            | 35
  amd64                          | 48
  x86                            | 156
  x86-64                         | 112

  Apple                          | 8
  iMac                           | 1
  MacBook                        | 7
  PowerBook                      | 10
  PPC                            | 52
  ppc64                          | 7

  ARM                            | 6
  Alpha                          | 2
  PA-RISC                        | 1
  parisc64                       | 1
  MIPS                           | 1
  mips64                         | 1
  mipsel                         | 2
  SPARC                          | 8
  sparc64                        | 6
  SUNW                           | 6
  Sun-Fire                       | 4
  sun4u                          | 3
  sun4v                          | 1
  k8                             | 1
  ------------------------------------------
  unknown                        | 67
  ------------------------------------------
  Base                           | 637 / 683
  Total (sum)                    | 875

The above table is in some arbitrary order. It was generated from
free-form answers, tabularized as multiple choice answer, as one
person can use git on more than one architecture.

Those results probably needs further processing to reduce number of
choices, by gathering architectures.

"Unknown" usually means that something else instead of architecture
was given (like operating system), or architecture was too generic,
like "PC".


21. What OS (please include the version) do you use GIT on?

  Answer                         | Count
  ------------------------------------------
  AIX                            | 1
  FreeBSD                        | 16
  OpenBSD                        | 3
  HP-UX                          | 1
  Linux                          | 582
  MS Windows (Cygwin)            | 22
  MS Windows (msys)              | 1
  MS Windows (unsp.)             | 35
  MacOS X / Darwin               | 94
  Solaris                        | 11
  SunOS                          | 5
  UNIX (unsp.)                   | 1
  too many to list               | 1
  ------------------------------------------
  MS Windows (together)          | 58
  FreeBSD / OpenBSD              | 19
  Unices (together)              | 19
  ------------------------------------------
  Base                           | 645 / 683
  Total (sum)                    | 775

The above was generated from free-form answers, tabularized as
multiple choice answer, as one person can use git on more than one
operating system.

This is only rough analysis, because it does not include operating
system version, or for Linux distribution(s) used.


22. What projects do you track (or download) using GIT (or git web interface)?

  TO TABULARIZE
  560 / 683 non-empty responses


23. How many people do you collaborate with using GIT?

  TO TABULARIZE
  575 / 683 non-empty responses

What ranges should be used here: 1, 2-9, 10-99, 100-999, 1000+ or
perhaps 1, 2-5, 6-15, 16-25, 26-50, 50-100, 100-1000, 1000+, or yet
another?


24. How big are the repositories that you work on?

  TO DO
  525 / 683 non-empty responses

Some git repositories have more than 50k files, more than 150k
commits, more than 100mb largest file (although not single directory
has all those).


25. How many different projects do you manage using GIT?

  TO TABULARIZE
  577 / 683 non-empty responses


26. Which porcelains do you use?

Multiple answers (one can use more than one porcelain).

  Answer (multiple choice)       | Count
  ------------------------------------------
  core-git                       | 558
  cogito (deprecated)            | 56

  Patch management interface:    : 57
  ...........................................
  StGIT                          | 41
  Guilt (formerly gq)            | 13
  pg (deprecated)                | 3

  own scripts                    | 95
  other                          | 14
  ------------------------------------------
  Base                           | 593 / 683
  Total (sum)                    | 780

Those 14 "other" answers make me wish to have provided "if other,
what it was?" (sub)question; actually not only for this question.


It is understandable that Cogito still has some users, even though it is
deprecated, and [I think] all of its functionality can be found in
git-core porcelain. It was meant as SCM / porcelain layer when git-core
didn't have it and consisted almost only of plumbing commands.

Quite a bit of people use patch management interface: StGIT, Guilt,
even deprecated and abandoned pg (Patchy Git). StGIT has more users
than Guilt (formerly gq), although that might be caused by the fact
that StGIT was here longer... Some say that it is because of Guilt
having non-standalone documentation; it needs reading hgbook, as Guilt
concepts are based on mq (Mercurial [patch] queues) extension.

Large number of users use their own scripts, more than any
non-standard porcelain. One wonders if this is a result of good
git scriptability.

14 users choose other... and there is no "what other" question,
unfortunately...

If you are reading this: what were those other porcelains?


27. Which git GUI do you use?

Multiple answers (one can use more than one GUI). Note that for the
first week and a bit of survey "CLI" answer had no explanation that it
means command line interface, so results might be bit skewed.

  Answer (multiple choice)       | Count
  ------------------------------------------
  CLI (command line)             | 398
  gitk                           | 347
  git-gui                        | 123
  qgit                           | 82
  gitview                        | 15
  giggle                         | 48
  tig                            | 41
  instaweb                       | 16
  (h)gct                         | 3
  qct                            | 3
  KGit                           | 6
  git.el                         | 31
  other                          | 15

  giggle + gitview               | 63
  ------------------------------------------
  Base                           | 572 / 683
  Total (sum)                    | 1128

As one can see almost as many people use gitk as CLI. Most used GUI
are gitk and git-gui, most probably because they are distributed with
git, and because they are portable. QGit is also quite popular,
although GTK+ viewers, namely giggle and gitview are also quite
popular (note that there might be instances of users using both giggle
and gitview). I am a bit suprised about popularity of Giggle, I'd say.

Tig (text-mode interface for git) and git.el (GIT mode for Emacs) are
also quite popular.

I wonder what are those 15 other GUI. Why oh why there were no "What
is this 'other GUI'?" question.


28. Which (main) git web interface do you use for your projects?

  Answer                         | Count
  ------------------------------------------
  gitweb                         | 382
  cgit                           | 7
  wit (Ruby)                     | 5
  git-php                        | 1
  other                          | 27
  ------------------------------------------
  Base                           | 422 / 683
  Total (sum)                    | 422

Around two third (closer to 4/7) of git users use some kind of web
interface for their projects.

Most use gitweb (which is distributed with git), 7 use cgit, 5 wit
(Ruby), most probably projects sharing site with XMMS2, 1 git-php
(I wonder who...), and there are 27 "other" answers, which I am most
curious about. What are they?

Some answered "other" as "N/A" (meaning they do not use web interface)
instead, what it is not obvious, not answering this question. The
explanation that this is possible was added later during duration of
survey.


29. How do you publish/propagate your changes?

Multiple choices, as one can use different methods for different
projects, for example pushing to public repo for a project maintained,
and sending patches via email to participate in third person project
development.

  Answer                         | Count
  ------------------------------------------
  push                           | 456
  pull                           | 220
  format-patch + email           | 172
  pull request                   | 65
  bundle                         | 13

  other                          | 70
  ------------------------------------------
  Base                           | 589 / 683
  Total (sum)                    | 996

Here "other" means just not listed workflow, although it would be also
interesting to know details.

Most popular is push, I guess to public "publishing" repository
(and/or probably to mirror repositories). It is twice as popular
as next method, gathering more than 3/4 of users.

Pull was supposed to mean logging to public server and pulling
changes from private repo, not pulling someone other changes.
It is second most popular method.

Sending patches via email is two to three times as popular
as sending pull request.


30. Does git.git repository include code produced by you?

  Answer                         | Count
  ------------------------------------------
  Yes                            | 99
  No                             | 512
  ------------------------------------------
  Base                           | 611 / 683
  Total (sum)                    | 611

As it can be seen, only (or perhaps it is that many?) around
a 6th to 7th of git users participate in its development by
providing code.


Internationalization
~~~~~~~~~~~~~~~~~~~~

31. Is translating GIT required for wider adoption?

  Answer                         | Count
  ------------------------------------------
  Yes                            | 49
  No                             | 383
  Somewhat                       | 158
  ------------------------------------------
  Base                           | 590 / 683
  Total (sum)                    | 590

More than half of responders doesn't think that translating GIT
is required for wider adoption.


32. What do you need translated?

  TO TABULARIZE
  172 / 683 non-empty responses


33. For what language do you need translation for?

In alphabetic order, free-form question, treated as multiple choice.

  Answer                         | Count
  ------------------------------------------
  Afrikaans                      | 1
  Belorussian                    | 1
  Chinese                        | 5
  Dutch                          | 2
  English[*1*]                   | 3
  Filipino                       | 1
  Finnish                        | 3
  French                         | 21
  German                         | 17
  Greek                          | 1
  Hebrew                         | 1
  Hindi                          | 1
  Hungarian                      | 1
  Italian                        | 4
  Japanese                       | 5
  Mandarin                       | 1
  Norwegian                      | 2
  Polish                         | 2
  Portuguese                     | 6
  Russian                        | 6
  Serbian                        | 2
  Slovenian                      | 1
  Spanish                        | 9
  Swedish                        | 2
  Tagalog                        | 1
  Ukrainian                      | 1
  ------------------------------------------
  Base                           | 143 / 683
  Total (sum) [*2*]              | 100

[*1*] Git messages and documentation _is_ in English
[*2*] Some answers were: "do not translate".

German and French are most popular. Spanish, Portuguese, Russian,
Chinese + Mandarin and Japanese have count 5 or more.


What you think of GIT
~~~~~~~~~~~~~~~~~~~~~

34. Overall, how happy are you with GIT?

  Answer                         | Count
  ------------------------------------------
  unhappy                        | 13
  not so happy                   | 36
  happy                          | 179
  very happy                     | 302
  completely ecstatic            | 112
  ------------------------------------------
  Base                           | 642 / 683
  Total (sum)                    | 642

Nice, git users are mostly very happy with git.
13 grumpy users, hmmm...


35. How does GIT compare to other SCM tools you have used?

  Answer                         | Count
  ------------------------------------------
  Better                         | 505
  Equal (comparable)             | 96
  Worse                          | 30

  N/A                            | 52
  ------------------------------------------
  Base                           | 631 / 683
  Total (sum)                    | 631

Clearly Git is superior SCM! (In the minds of Git users at least) ;-)
Seriously, one should take into consideration that those results are
biased, because it is _Git User's_ Survey, and people usually choose
SCM because they think it is best choice.

No answer (null answer) might mean that responder does not use and did
not use other SCMs to compare, or at least think that he/she does not
have sufficient basis for a comparison.

NOTE: I have to check if number of non-empty responses is calculated
properly. I think it is, but I will make sure.


36. What do you like about using GIT?

  TO DO
  578 / 683 non-empty responses

No full analysis yet, and no count of answers, but it seems that the
following are encountered most often (or at least those I remember
best):
 * clean design
 * performance (speed)
 * size of repository
 * reliability, robustness, data integrity
 * flexibility, scriptable
 * command set, features (git-bisect)
 * history rewriting (amend, rebase, interactive rebase, reset)
 * history viewers, searching and browsing history
 * distributed nature, offline work, full history locally,
   "local commits"
 * easy and in-place branching
 * easy merging, includes renames detection
 * push/pull via ssh, pull via plain http -- no server needed
 * easy to install: few dependencies, portable, lightweight


37. What would you most like to see improved about GIT?
    (features, bugs, plug-ins, documentation, ...)

  TO DO
  512 / 683 non-empty responses

So many suggestions...

First, some of suggestions are actually implemented already, for
example git development Changelog (present in the form of RelNotes),
shallow clone support, submodules support. This means that new
features are not very well announced (which was one of comments here,
too).

Some of features and improvements mentioned:
 * generic behavior:
   - less chatter, clean distinction between success or fail
     (it it was about git-pull, it is addressed already)
   - better, more verbose error messages, with link to documentation
   - diagnostic output in case of problems;
     something like git-explain / git-state
   - more universal undo / continue
   - command line consistency, option consistency: getopt / gitopt
 * documentation:
   - unified, organized, searchable documentation
   - The Git Book (c.f. cvs/svn/hgbook);
     tutorial leading to advanced concepts like rebase, filter-branch,
     grafts, submodules, gitattributes
   - Git Cookbook / Git Recipies;
     best practices document, usage scenarios, workflows used, HOWTO
   - Git for Dummies (for people who haven't used SCM at all)
   - more hooks and hook examples
   - mid-level (script / plugin writer leve) docs
   - git1line docs a la sed1line.txt
   - "git <cmd> --help" returning one page of short command summary,
     not manpage; "git help --all --summary" for all command with
     oneline description
 * other SCMs:
   - cogito migration guide / tutorial (!)
   - other SCM to git (concept, commands) cheat sheet
   - git-bzr (and other SCMs) two-way integration
   - git-svnserve: git functioning as Subversion server
 * git-svn:
   - automatic handling svn:externals using submodules and vice versa
   - svnmerge and svk merge markers tracking/marking of merges
 * more --interactive:
   - git add --interactive in git-gui: allow to divide hunks
   - git rebase -interactive: graphical interactive rebase in git-gui
   - ncurses-based remote editing
 * tools:
   - better Emacs support; Vim plugin; IDE plugins (Eclipse, KDevelop,
     IntelliJ IDEA,...)
   - MS Windows explorer shell integration; filemanagers integration
     (Nautilus, Konqueror)
   - side by side diffs in gitweb, a la KDiff3/Meld/ediff etc.
 * code:
   - port scripts to C (builtinification)
   - git library (libification)
   - gitbox: single static, pre-packaged binary
 * other:
   - bisect dunno / skip / next
   - partial checkout
   - light working copies; multiple working copies per repo
   - git-notes, to annotate commit messages
   - push over sftp
   - option to track empty directories
   - option to track permissions and metainfo: ACL, EA, forks
   - rebase and blame merge strategies
   - merge / rebase into dirty tree
   - resumable git-clone; faster and less CPU hungry git-clone
   - checkout/merge/diff/hunk header handlers in distribution for
     ChangeLog, XML, odf, jar and xul, po files

This is only [large] excerpt, not a list of all requested features.
As one can see tabularizing (dividing into categories) this data will
be not an easy task.


38. If you want to see GIT more widely used, what do you think
    we could do to make this happen?

  TO DO
  459 / 683 non-empty responses

So many suggestions...
One of the more striking (and funny):

 * Big fat posters world-wide with Catherine Zeta-Jones stating how
   happy she is since she switched to git ;-)

   She can actually write C-code.

 * Offer Git stickers to put on laptops and such


Changes in GIT (since year ago, or since you started using it)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

39. Did you participate in previous Git User's Survey?

  Answer                         | Count
  ------------------------------------------
  Yes                            | 51
  No                             | 583
  ------------------------------------------
  Base                           | 634 / 683
  Total (sum)                    | 634

51 people did out of 634 who answered this question, out of 115 (?)
who did participate in the previous survey. Around half. Bit curious.


40. What improvements you wanted got implemented?

  TO TABULARIZE
  129 / 683 non-empty responses


41. What improvements you wanted didn't get implemented?

  TO TABULARIZE
  104 / 683 non-empty responses


42. How do you compare current version with version from year ago?

Should be: from year ago, or since you started using this.
No responses (303 / 683) migh be caused by the fact that one
do not use git for a year, so he/she doesn't know what git
looked like year ago.

  Answer                         | Count
  ------------------------------------------
  Better                         | 319
  No changes                     | 60
  Worse                          | 1
  ------------------------------------------
  Base                           | 380 / 683
  Total (sum)                    | 380

Most think that git has improved. One user thinks that it is worse
than year ago; I wonder why...


43. Which of the new features do you use?

Multiple choice; the list does not include all new features.
Some new features are not visible at first glance, and one
uses them without conscious choice.

  Answer                         | Count
  ------------------------------------------
  git-gui                        | 103
  blame improvements             | 74
  detached HEAD                  | 71
  stash                          | 68
  mergetool                      | 67
  interactive rebase             | 66
  reflog                         | 54
  submodules                     | 52
  shallow clone                  | 31
  commit template                | 24
  eol conversion                 | 22
  gitattributes                  | 21
  bundle                         | 17
  worktree                       | 17
  ------------------------------------------
  Base                           | 259 / 683
  Total (sum)                    | 687

This table is sorted by count.

Detached HEAD support and stash command were long requested;
no wonder they are popular.


Documentation
~~~~~~~~~~~~~

  Usefulness of      | Yes / Some / No  | Base
  ----------------------------------------------
  GIT wiki           | 191 /  69  / 198 | 458
  on-line help       | 377 / 172  /  28 | 577
  distributed help   | 425 / 154  /  22 | 601
  ----------------------------------------------
                   individual responses : 683


44. Do you use the GIT wiki?

  Answer                         | Count
  ------------------------------------------
  Yes                            | 316
  No                             | 300
  ------------------------------------------
  Base                           | 616 / 683
  Total (sum)                    | 616


45. Do you find GIT wiki useful?

  Answer                         | Count
  ------------------------------------------
  Yes                            | 191
  No                             |  69
  Somewhat                       | 198
  ------------------------------------------
  Base                           | 458 / 683
  Total (sum)                    | 458


46. Do you contribute to GIT wiki?

  Answer                         | Count
  ------------------------------------------
  Yes                            |  17
  No                             | 460
  Corrections and removing spam  |  45

  Some contribution              |  62
  ------------------------------------------
  Base                           | 522 / 683
  Total (sum)                    | 522


47. Do you find GIT's on-line help (homepage, documentation) useful?

  Answer                         | Count
  ------------------------------------------
  Yes                            | 377
  No                             |  28
  Somewhat                       | 172
  ------------------------------------------
  Base                           | 577 / 683
  Total (sum)                    | 577


48. Do you find help distributed with GIT useful
    (manpages, manual, tutorial, HOWTO, release notes)?

  Answer                         | Count
  ------------------------------------------
  Yes                            | 425
  No                             | 22
  Somewhat                       | 154
  ------------------------------------------
  Base                           | 601 / 683
  Total (sum)                    | 601


49. Did/Do you contribute to GIT documentation?

  Answer                         | Count
  ------------------------------------------
  Yes                            | 43
  No                             | 551
  ------------------------------------------
  Base                           | 594 / 683
  Total (sum)                    | 594


50. What could be improved on the GIT homepage?

  TO DO
  171 / 683 non-empty responses


51. What topics would you like to have on GIT wiki?

  TO DO
  134 / 683 non-empty responses


52. What could be improved in GIT documentation?

  TO DO
  190 / 683 non-empty responses


Getting help, staying in touch
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  Do you use                | Yes / No  | Base
  ----------------------------------------------
  GIT wiki                  | 316 / 300 | 616
  mailing list              | 204 / 406 | 610
  IRC channel               | 182 / 376 | 558
  ----------------------------------------------

  Usefulness of      | Yes / Some / No  | Base
  ----------------------------------------------
  GIT wiki           | 191 /  69  / 198 | 458
  mailing list       | 146 /  79  /  34 | 259
  IRC channel        | 127 /  59  /  26 | 212
  ----------------------------------------------
                   individual responses : 683

As one can see mailing list is the primary medium for git,
and IRC secondary one.


53. Have you tried to get GIT help from other people?

  Answer                         | Count
  ------------------------------------------
  Yes                            | 357
  No                             | 261
  ------------------------------------------
  Base                           | 618 / 683
  Total (sum)                    | 618

It might be that Git is not documented enough; it might be that
version control is not an easy task.


54. If yes, did you get these problems resolved quickly
    and to your liking?

  Answer                         | Count
  ------------------------------------------
  Yes                            | 326
  No                             | 53
  ------------------------------------------
  Base                           | 379 / 683
  Total (sum)                    | 379

That is I think very good (around 86%) percentage.


55. Would commerical (paid) support from a support vendor
    be of interest to you/your organization?

  Answer                         | Count
  ------------------------------------------
  Not Applicable                 | 203
  Yes                            | 69
  No                             | 322

  Yes + No                       | 391
  ------------------------------------------
  Base                           | 594 / 683
  Total (sum)                    | 594

Only 69 (12%) answers yes, 322 no, 203 not applicable (which meant
to encompass people who do not use git at and for work).

433 = 56 + 377 people participating in this survey use git for work,
or for both work and unpaid projects (as compared to 391 who answered
this question not with N/A).

Note that Git is GPLv2, and it will probably stay that forever, so you
are _free_ to start a commercial support scheme for Git, but others
are free not to choose it. This question is to get to know if there is
sufficient demand for commercial Git support for it to be viable.


56. Do you read the mailing list?

  Answer                         | Count
  ------------------------------------------
  Yes                            | 204
  No                             | 406
  ------------------------------------------
  Base                           | 610 / 683
  Total (sum)                    | 610

The fact that only one third of git users are reading mailing list
(which is nevertheless quite large percentage) means that features
_have_ to be documented somewhere besides mailing list archive and
logs (commit messages).


57. If yes, do you find the mailing list useful?

  Answer                         | Count
  ------------------------------------------
  Yes                            | 146
  No                             | 34
  Somewhat                       | 79
  ------------------------------------------
  Base                           | 259 / 683
  Total (sum)                    | 259


58. Do you find traffic levels on GIT mailing list OK?

  Answer                         | Count
  ------------------------------------------
  Yes                            | 193
  No                             | 50
  ------------------------------------------
  Base                           | 243 / 683
  Total (sum)                    | 243


59. Do you use the IRC channel (#git on irc.freenode.net)?

  Answer                         | Count
  ------------------------------------------
  Yes                            | 182
  No                             | 376
  ------------------------------------------
  Base                           | 558 / 683
  Total (sum)                    | 558


60. If yes, do you find IRC channel useful?

  Answer                         | Count
  ------------------------------------------
  Yes                            | 127
  No                             | 26
  Somewhat                       | 59
  ------------------------------------------
  Base                           | 212 / 683
  Total (sum)                    | 212


61. Did you have problems getting GIT help on mailing list
    or on IRC channel? What were it? What could be improved?

  TO TABULARIZE
  99 / 683 non-empty responses


Open forum
~~~~~~~~~~

62. What other comments or suggestions do you have, that are not
    covered by the questions above?

  TO DO
  141 / 683 non-empty responses

-- 
Jakub Narebski
