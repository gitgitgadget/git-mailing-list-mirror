From: Jakub Narebski <jnareb@gmail.com>
Subject: Git User's Survey 2009 partial summary, part 2 - from first 10
Date: Mon, 17 Aug 2009 12:24:43 +0200
Message-ID: <200908171224.44686.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 17 12:18:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MczHz-000137-Bo
	for gcvg-git-2@lo.gmane.org; Mon, 17 Aug 2009 12:18:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757480AbZHQKR6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2009 06:17:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757461AbZHQKR5
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 06:17:57 -0400
Received: from mail-bw0-f222.google.com ([209.85.218.222]:56322 "EHLO
	mail-bw0-f222.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757339AbZHQKR4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Aug 2009 06:17:56 -0400
Received: by bwz22 with SMTP id 22so2209489bwz.18
        for <git@vger.kernel.org>; Mon, 17 Aug 2009 03:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=fsPznXpRJpInhACsNdnTiLsdDx6DYgAqmLIDeihpwtY=;
        b=rPXj+Fnqn3N/WCJxp7xns8r8dwXAawWkdw4ApvyJPY+gfQMgPrBD93zyEU6oHpvXQX
         QIc/aQfh0nC5UPk3tbTJrOC0fbmiya1cZX8V7VzC5V3lQQrzHDgYnrCUzqPZltEziMRi
         Wjsy6uEfkqp08PCHlZCV95RBDvM6aoNn7IXIs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        b=WsUm5kQxJGyioWV7YMhswmNM0ve5nITSjhSK1cV2vfND7DMNYyVJZLBKs7dJ5VgWF6
         sooGgv9ovebKU6Fz2KGBOMSGWpGmOmKvzzfldu8cqyFH53BA1PGONs0bYzLx4+eDB2P8
         KFuR/WE50tFm8EJbsoELGgg/133Ll85SdwpYc=
Received: by 10.103.50.28 with SMTP id c28mr1239218muk.17.1250504275714;
        Mon, 17 Aug 2009 03:17:55 -0700 (PDT)
Received: from ?192.168.1.13? (abwa39.neoplus.adsl.tpnet.pl [83.8.224.39])
        by mx.google.com with ESMTPS id j2sm18494096mue.20.2009.08.17.03.17.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 17 Aug 2009 03:17:51 -0700 (PDT)
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126153>

Git User's Survey 2009 partial summary, part 2 - git difficulty,
proficiency, uses, install, OS, editors.


It more than a month since Git User's Suvey 2009 was started (it was
started on 15 July 2009), which is a half of planned duration time of
the survey.

So I think this is time for second part partial summary of Git User's
Survey 2009.  The previous part can be found at
  http://thread.gmane.org/gmane.comp.version-control.git/124599
  Subject: Git User's Survey 2009 partial summary, part 1 -
           - announcing survey, participation
  Message-Id: <200907312246.12134.jnareb@gmail.com>


You can see summary of Git User's Survey 2009 responses (and make your
own analysis) at the following URL:

  http://www.survs.com/shareResults?survey=2PIMZGU0&rndm=678J66QRA2
  http://tinyurl.com/GitSurvey2009Analyze

After the survey ends (or earlier, if it is requested) the raw data
would be published on GitSurvey2009 page on Git Wiki in CSV and XLS
formats (like for GitSurvey2008).


We have currently (at the time I have checked this) around 3089
responses, as compared to 3236 individual responses (including 21
responses in 'test' channel) for survey in 2008, 683 individual
responses in 2007, and around 117 responses in 2006.


Below there is analysis of few questions from this survey; note that
results might do not add to 100% because of replies during using live
analysis tool, and the rounding.


3) Have you found Git easy to learn?
4) Have you found Git easy to use?
   (Choice - Single answer)

================================================
Answer            | to learn [%] |   to use [%]
------------------------------------------------
Very easy         |          4%  |          9%
Easy              |         20%  |         36%
Reasonably easy   |         55%  |         45%
Hard              |         19%  |          8%
Very hard         |          2%  |          1%
------------------------------------------------
Total respondents |        2942  |        2959
================================================

As you can see the myth that Git is hard to learn was busted ;-) Not.

When analyzing this data you should take into account that somebody
considering or finding Git to hard to learn wouldn't be probably Git
user, and thus wouldn't fill this survey.  So because it is 
*Git User's* Survey we should consider that results can be skewed
towards lower value (easier).

What's interesting is comparing (percentage) results for questions
3. and 4.; how hard is git to learn versus how hard is to use.  It
seems like Git is reasonably easy to learn, and reasonably easy to
easy to use.  So it looks like Git just have somewhat steep learning
curve, and the difficulty to learn pays in being more powerful to
use.


6) Rate your own proficiency with Git:
   (Choice - Single answer)

You can think of it as 1-5 numerical grade of your proficiency in Git.

================================================
Proficiency               | resp [%] | resp [n]
------------------------------------------------
1. novice                 |       4% |      114
2. casual, needs advice   |      17% |      520
3. everyday use           |      38% |     1138
4. can offer advice       |      34% |     1020
5. know it very well      |       6% |      192
--------------------------+---------------------
Total respondents         |                2984
Skipped this question     |                 105
================================================

As you can see most responders know Git enough for everyday use, or
can even offer some Git advice.  If we treat possible answers as a
proficiency grade, the average proficiency is around 3.2.

Either Git users don't stay novices long, or survey announcement(s)
didn't reach novice users.

This data could be useful later to be able to check how it differs
git usage for novices and for gurus (what commands they run, what
features they use at different levels of proficiency).


7) I use Git for (check all that apply):
   (Choice - Multiple answers)

Note that above choices are neither orthogonal nor exclusive.  One
might want to check multiple answers even for a single repository.

============================================
Answer                | resp [%] | resp [n]
--------------------------------------------
work projects         |      79% |     2366
unpaid projects       |      80% |     2391
............................................
work and unpaid       |      66% |     1960
only work             |      14% |      407
only unpaid           |      15% |      432
not answered          |       6% |      190
--------------------------------------------
proprietary projects  |      37% |     1108
OSS development       |      69% |     2054
private code          |      77% |     2315
--------------------------------------------
code (programming)    |      87% |     2591
web app               |      43% |     1274
configuration files   |      34% |     1010
personal data         |      33% |      972
documents             |      32% |      956
static website        |      29% |      881
--------------------------------------------
frontend to other SCM |      32% |      971
sharing data or sync  |      22% |      645
backup                |      24% |      722
backend for web app   |       9% |      263
............................................
--------------------------------------------
other                 |       3% |       84
============================================
Total respondents     |                2989
Skipped this question |                 104
============================================

The answers in the table above are in slightly different order than in
original, i.e. in the survey.  Analysis of correlations was done here
only for work / unpaid part of answer (see table above).

This question joins together (to reduce number of questions in the
survey) few separate issues:

 * Whether one use Git for work, or for unpaid projects: this survey
   results shows that the amount of paid and unpaid projects are about
   the same, and that most of people (most of responders) us Git for
   both work (paid) and free (unpaid) projects.

 * The question of openess / license: whether one uses Git for
   proprietary projects or for FLOSS (Free/Libre/Open Source
   Software), or perhaps for private code (not covered by license).
   Here OSS development and private code/data dominates over using Git
   for proprietary code, with around twice as much answers.  This may
   be caused by the fact that Git is / feels more suited to opensource
   (like) development (proprietary code can use proprietary SCM), but
   it might be that announcement didn't make it to people using Git
   for proprietary works.

 * Whether one uses Git for code (for something it was created for),
   or for other things like documents etc.  Here code dominates,
   having around twice as many replies as the next in turn, 'web app'
   (which is also code, but a special case, and not only code).

 * next is UGFWIINI part: using Git for what it was not intended.
   Well, except perhaps using Git as frontend or fat-client for other
   SCM (e.g. git-svn for Subversion).  Using Git for other SCM
   dominates with 32%, next are using Git for sharing, and for backup
   (both with around 23% of responses).

 * The "other (please specify)" is not yet analyzed (nor even began
   analysis so far).


8) How do/did you obtain Git (install and/or upgrade)? 
  (Choice - Multiple answers)

Explanation: binary package covers pre-compiled binary (e.g. from rpm
or deb binary packages); source package covers things like deb-src and
SRPMS/*.src.rpm; source script is meant to cover installation in
source-based distributions, like 'emerge' in Gentoo.

Automatic update (apt, yum, etc.) in most cases means binary package
install; unless one uses source-based distribution like Gentoo, CRUX,
or SourceMage, where automatic update means using source package (or
source script).

The option named "preinstalled / sysadmin job" means that either you
didn't need to install git because it was preinstalled (and you didn't
upgrade); or that you have to ask system administrator to have git
installed or upgraded.


Note that this question is multiple choices question because one can
install Git in different ways on different machines or on different
operating systems.

==================================================
Answer                      | resp [%] | resp [n]
--------------------------------------------------
binary package              |      71% |     2118
source package or script    |      24% |      704
source tarball              |      20% |      588
pull from repository        |      18% |      527
preinstalled / sysadmin job |       6% |      185
other - please specify      |       4% |      123
----------------------------+---------------------
Total respondents           |                2975
Skipped this question       |                 118
==================================================

Most people (71%) use ready binary packages, which was kind of
expected; that is the easiest way.


9) On which operating system(s) do you use Git?
   (Choice - Multiple answers)

On Unix-based operating system you can get the name of operation
system by running 'uname'.

============================================================
Operating system                      | resp [%] | resp [n]
------------------------------------------------------------
Linux                                 |      88% |     2623
MacOS X (Darwin)                      |      44% |     1304
MS Windows/Cygwin                     |       9% |      279
MS Windows/msysGit (MINGW)            |      21% |      625
*BSD (FreeBSD, OpenBSD, NetBSD, etc.) |       7% |      213
OpenSolaris                           |       3% |      101
other Unix                            |       2% |       60
Other, please specify                 |       2% |       46
......................................|..........|..........
MS Windows (any)                      |      27% |      820
--------------------------------------+---------------------
Total respondents                     |                2991
Respondents who skipped this question |                 102
============================================================

Most common used operating system is Linux, next is MacOS X, and then
MS Windows (on MS Window dominates msysGit version).  This is quite
understandable, as Git was created on Linux and for Linux, and it
works best there.

The "other" answer include Solaris, AIX, HP-UX (other Unix), GNU/Linux
(Linux), Debian, NixOS (Linux distributions), none (?); iPod, OpenVMS,
QNX, Hurd and "my toaster" (?).  And some commentaries and
clarifications.


10) What do you use to edit contents under version control with Git?
    What kind of editor, IDE or RAD you use working with Git?
    (Choice - Multiple answers)

* "simple text editor" option includes editors such as pico, nano,
  joe, Notepad,

* "programmers editor" option includes editors such as Emacs/XEmacs,
  Vim, TextMate, SciTE (syntax highlighting, autoindentation,
  integration with other programmers tools, etc.)

* "IDE (Integrated Development Environment) and RAD (Rapid Application
  Development)" option includes tools such as Eclipse, NetBeans IDE,
  IntelliJ IDE, MS Visual Studio, KDevelop, Anjuta, Xcode,
  Code::Blocks but also tools such as Quanta+, BlueFish or Screem (for
  editing HTML, CSS, PHP etc.), and Kile or LEd for LaTeX.

* "WYSIWYG tools" option includes word processors such as MS Office or
  OpenOffice.org, but also tools such as Adobe Acrobat (for PDF) or
  GIMP (for images), or WYSIWYG DTP tools such as QuarkXPress,
  PageMaker or Scribus, or WYSIWYG HTML editors such as FrontPage,
  Dreamweaver or KompoZer.

============================================================
Answer                                | resp [%] | resp [n]
------------------------------------------------------------
simple text editor                    |      25% |      752
programmers editor                    |      88% |     2641
IDE or RAD                            |      32% |      960
WYSIWYG tool                          |       5% |      159
other kind - please specify           |       3% |       95
--------------------------------------+---------------------
Total respondents                     |                2985
Respondents who skipped this question |                 108
============================================================

Most popular kind of tool is programmer's editor with very strong 88%
lead.  Next in turn are IDE or RAD with 32%, followed by simple text
editor, with 25%.  The WYSIWYG tools are last, with very small 5% of
replies; also people who use WYSIWYG tools also use other kind of
tools to edit (presumably to edit commit message at least).

>From browsing through "other tool" responses it seem like there should
be included 'web interface' among possible tools (written as: wiki
frontend, GitHub editor, <textarea>).  Other responses include Xournal
(note taking application for graphic tablet, using stylus), Tinderbox
(also note taking application), Git GUI tool: GitX (?), custom
git-aware CMS (probably also 'web interface'), scripts and oneliners,
command line and 'On occasion, Unix text manipulation tools'.  Also
there is "audio editors" answer (which probably should fall under
"WYSIWYG tool)...

Many answers in 'other tool' falls in one of ready categories; perhaps
they are clarification?

-- 
Jakub Narebski
Git User's Survey 2009: http://tinyurl.com/GitSurvey2009
