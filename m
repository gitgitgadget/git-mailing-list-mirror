From: "Jakub Narebski" <jnareb@gmail.com>
Subject: Git User's Survey 2007 summary - comparison with previous survey
Date: Sat, 13 Oct 2007 00:07:08 +0200
Message-ID: <8fe92b430710121507h6b9b684bw9f39dbf3c3b14432@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 13 00:11:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IgSfF-0004KM-EW
	for gcvg-git-2@gmane.org; Sat, 13 Oct 2007 00:07:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759042AbXJLWHO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Oct 2007 18:07:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759437AbXJLWHO
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Oct 2007 18:07:14 -0400
Received: from wa-out-1112.google.com ([209.85.146.176]:55138 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759018AbXJLWHJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Oct 2007 18:07:09 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1124582wah
        for <git@vger.kernel.org>; Fri, 12 Oct 2007 15:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=zMMuICjISOfT9l7/9SX0GqvLHeTntfnhbVaVguBEd20=;
        b=ignTBoAIvb4lxi3PFbSrXp8TuqVUBS8rupMAsnQtyIaU+paSLppfX0F0yhlK9tKRUQYJSLvRrmjZz1SIi7WyRAnUjUouOvFSWSelxtv0OOYvVE7LAhTOOkM86uZTzC3D1jzcNGNCzD3WwYJVplI38mnPKAqLRXDqxtOEQSilhZo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=cQVs1CyDRdT2N+PytusFlY3y09eUzrUcsqjKDeG2LzVJwGqfqPiEgrbj1jIrsNKIOqxnIySN0wUDYf+Lo4+8rWlI4Db2fDqbRdy2UwSoqKzuvPF/UCIrJP7ZwDI0Rg7I0TLM9+xEXf19wv8zRgx0Z4TfJC5Q1nSEHM6L91HxfE4=
Received: by 10.114.120.1 with SMTP id s1mr4013384wac.1192226828056;
        Fri, 12 Oct 2007 15:07:08 -0700 (PDT)
Received: by 10.114.202.19 with HTTP; Fri, 12 Oct 2007 15:07:08 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60706>

It's been more than a year since last Git User's Survey. It would be
interesting to find what changed since then. Therefore the idea to
have another survey.

This is partial comparison of Git User's Survey 2007,
(ending at state from 28 September 2007) with previous
survey.

The current survey can be found here:
  http://www.survey.net.nz/survey.php?94e135ff41e871a1ea5bcda3ee1856d9
  http://tinyurl.com/26774s

The data for current, 2007 survey can be found here:

The data for previous, 2006 survey was taken from following wiki page
  http://git.or.cz/gitwiki/GitSurvey2006

---
There were 683 individual responses in 2007 survey.
There were around 117 responses in 2006 survey.

There are 62 questions in 2007 survey, and 31 questions (half of
the number) in 2006 survey.


About you
~~~~~~~~~

01. What country are you in?

  Answer                         | Old | Count
  ------------------------------------------------
  Algeria                        |     | 1
  Argentina                      |     | 3
  Australia                      | 3   | 25
  Austria                        | 2   | 9
  Belarus                        | 1   |
  Belgium                        |     | 5
  Brazil                         | 2   | 20
  Bulgaria                       |     | 1
  Canada                         | 3   | 44
  Chile                          | 1   | 2
  China                          | 2   | 4
  Colombia                       |     | 2
  Czech Republic                 | 2   | 10
  Denmark                        | 4   | 7
  Ecuador                        |     | 1
  Estonia                        | 1   | 1
  Europe                         | 1   | 1
  Finland                        | 5   | 23
  France                         | 6   | 36
  Germany                        | 14  | 64
  Greece                         |     | 3
  Hungary                        |     | 2
  India                          | 1   | 13
  Ireland                        |     | 2
  Israel                         |     | 6
  Italy                          | 3   | 14
  Japan                          |     | 4
  Jersey                         |     | 1
  Latvia                         |     | 1
  Lithuania                      | 1   |
  Malaysia                       |     | 1
  Mexico                         |     | 1
  Netherlands                    | 3   | 15
  New Zealand                    |     | 5
  Norway                         | 1   | 14
  Philippines                    | 1   | 3
  Poland                         | 3   | 6
  Portugal                       |     | 2
  Puerto Rico                    |     | 1
  Romania                        |     | 1
  Russian Federation             | 2   | 6
  Samoa                          |     | 1
  Serbia                         |     | 1
  Singapore                      |     | 2
  Slovak Republic                |     | 1
  Slovenia                       |     | 2
  South Africa                   | 1   | 4
  Spain                          | 2   | 11
  Sri Lanka                      |     | 1
  Sweden                         | 6   | 14
  Switzerland                    | 1   | 15
  UAE                            | 1   |
  UK / US                        |     | 1
  United Kingdom                 | 8   | 40
  United States of America       | 35  | 218
  Venezuela                      |     | 1
  Vietnam                        | 1   | 1
  ------------------------------------------------
  Base                           |     | 673 / 683
  Total (sum)                    | 117 | 673

England, Scotland and British Isles counts as United Kingdom here.
Table is sorted in alphabetical order.

As before most Git users are in the USA.

There are quite a bit of new countries, only two vanished.  Note that
current survey has much more responses, so it is expected.


02. What is your preferred non-programming language?

This is multiple answers question, although most people
gave only one preferred language.

  Answer                         | Old | Count
  ------------------------------------------------
  Afrikaans                      |     | 1
  Belarusian                     | 1   |
  Bulgarian                      |     | 1
  Castellano                     |     | 2
  Catalan                        |     | 1
  Chinese                        | 1   | 2
  Czech                          | 2   | 10
  Danish                         | 5   | 6
  Dutch                          | 4   | 12
  English                        | 71  | 416
  Estonian                       | 1   |
  Finnish                        | 4   | 16
  French                         | 5   | 33
  Galician                       |     | 1
  German                         | 12  | 58
  Greek                          |     | 2
  Hebrew                         |     | 1
  HibernoEnglish                 |     | 1
  Hungarian                      |     | 3
  Italian                        | 3   | 9
  Japanese                       | 1   | 1
  LSF (French sign language)     |     | 1
  Norwegian                      |     | 4
  Polish                         | 3   | 5
  Portuguese                     |     | 10
  Romanian                       |     | 1
  Russian                        | 4   | 13
  Serbian                        |     | 1
  Slovenian                      |     | 2
  Spanish                        | 4   | 13
  Swedish                        | 5   | 13
  Swiss                          |     | 1
  Ukrainian                      |     | 1
  Vietnamese                     | 1   | 1

  invalid (computer language)    | ?   | 37
  not understood                 | ?   | 4
  ------------------------------------------------
  Base                           |     | 662 / 683
  Total (sum)                    | 127 | 683

Most of git users prefer English language, at least for dealing with
computers, the same as before.

In previous survey summary the invalid responses were not enumerated.

The question itself is not well formulated, as one can see from the
number of answers with computer language, and "not understood"
answers.  I am not native English speaker, but there were suggestions
to use "natural language" instead of "non-programming language".  The
question is formulated the same as in previous survey.


03. How old are you?
04. Which programming languages you are proficient with?

Those are new questions, which were not present in previous survey.


Getting started with GIT
~~~~~~~~~~~~~~~~~~~~~~~~

05. How did you hear about GIT?

This question is present in both current (2007) and previous (2006)
survey.  But because it uses free-form answer, and tabularization
(dividing data in categories and generating histogram / counting
occurences) is quite different it is not easy to compare results.

In Git User's Survey 2006 (prevuius survey) the dominant source was
LKML (Linux Kernel Mailing List) with 74 / 115 responses, with LWN
leading the rest with 11 / 115 count.

Although LKML still dominates the table for current survey, it is not
by such a wide margin (109/658 = 17% as compared to 74/115 = 64% in
previous one).  Many people heard about git because Linux kernel uses
it; Linus Torvalds presentation (talk) at Google (Google Video and
YouTube) got also high count, bit higher than LWN.

But there was no "I wrote it" response in current survey, though...


06. Did you find GIT easy to learn?

  Answer                         | Old | Count
  ------------------------------------------------
  very easy                      | 6   | 38
  easy                           | 21  | 136
  reasonably                     | 64  | 318
  hard                           | 23  | 131
  very hard                      | 3   | 33
  ------------------------------------------------
  Base                           |     | 656 / 683
  Total (sum)                    | 117 | 656

Nice gaussian curve both for current survey, and previous year survey
data.  Most users find GIT reasonably easy to use.


07. What helped you most in learning to use it?

TO DO. This again is a free-form question, present in both surveys.
For current (2007) survey data is not even tabularized yet, although
(some) of responses got listed (without a count).  I don't think
comparison with previous result is any interesting, but previous year
data can provide at least some hint on how to divide answers into
categories.


08. What did you find hardest?

TO DO. Yet another free-form question, present in both surveys.
Tabularized for 2006 survey, listed without count for 2007 survey, as
for previous question.


09. When did you start using git? From which version?

TO DO. Again free-form question.  Note that in previous survey this
question consisted only of the first part, and read "When did you
start using git?", so it is date that got tabularized, not git version
(mostly).  Analysis of current survey data is unfinished, and only
answers in which there was given git version explicitely got
tabularized.  For comparison we would need analysis of answers giving
date; and even then I don't think it would be especially useful,
unless very coarse-grained (which year for example).


Other SCMs
~~~~~~~~~~

10. What other SCMs did/do you use?
11. Why did you choose GIT?
12. Why did you choose other SCMs?
13. What would you require from GIT to enable you to change,
    if you use other SCM for your project?
14. Did you import your repository from foreign SCM? What SCM?
15. What tool did you use for import?
16. Do your GIT repository interact with other SCM? Which SCM?
17. What tool did/do you use to interact?

This whole section is new, and was not present in previous survey.


How you use GIT
~~~~~~~~~~~~~~~

18. Do you use GIT for work, unpaid projects, or both?

This question had slightly different wording in 2006 survey:
"How you use GIT? Do you use GIT for ...".

  Answer / Purpose               | Old | Count
  ------------------------------------------------
  work                           | 14  | 56
  unpaid projects                | 50  | 212
  both                           | 53  | 377
  ------------------------------------------------
  Base                           |     | 645 / 683
  Total (sum)                    | 117 | 645

In the previous survey unpaid projects (only unpaid) were slightly
less than half of answers (43 %), while current survey shows that
[only] around a third of git users use it only for unpaid projects.
So we see more git used for work.


19. How do you obtain GIT?

  Answer                         | Old | Count
  ------------------------------------------------
  binary package                 | 31  | 283
  source tarball                 | 33  | 210
  pull from main repository      | 53  | 153
  ------------------------------------------------
  Base                           |     | 646 / 683
  Total (sum)                    | 117 | 646

As one can see a year ago pull from main repository dominated, while
now binary package dominates, and pull is least used.  At least among
people who answered Git User's Survey; the difference might be caused
by the fact that previous survey was distributed mainly among readers
of git mailing list, who run latest 'master' or even 'next' version,
and often contribute to git (see also question 30, "Does git.git
repository include code produced by you?").

On the other hand the difference might be caused by the fact that more
distributions have got git, or that git is more mature and there is no
need to run development version and/or the fact that x.y.z is now
development version following 'master' and not 'maint', and includes
new features.


20. What hardware platforms do you use GIT on?

This is free-form question, tabularized for both current and previous
survey, but tabularized (slightly) differently.  It is not suprising,
as extracting architecture and dividing into categories was doneby two
different people:  Paolo Ciarrocchi (if I remember correctly) for 2006
survey, and Jakub Narebski (me) for 2007.

Moreover I guess that the _comparison_ is not very interesting; the
current data is.

Hardware platfrom tables should relly be generated by someone better
versed in computer architecture.


21. What OS (please include the version) do you use GIT on?

This question is also free-form.  For 2006 survey there is generic
count, and two tables: for Linux (distribution or kernel), and for
other operating systems.  The table for 2007 survey is slightly less
generic than the 2006 count, but there are no OS version tables.
There is much more data, and more data without version number.

Perhaps we should have provided examples of answers to this
question...

  Answer                         | Old  | Count
  ---------------------------------------------
  AIX                            | 1    | 1
  FreeBSD                        | 4    | 16
  OpenBSD                        | -    | 3
  NetBSD                         | 1    | -
  HP-UX                          | 1    | 1
  IRIX                           | 1    | -
  Linux                          | 167? | 582
  MS Windows (Cygwin)            | 14   | 22
  MS Windows (other)             |      | 36
  MacOS X / Darwin               | 11   | 94
  Solaris                        | 3    | 11
  SunOS                          | -    | 5
  ---------------------------------------------

Note that one person can use git on more than one operating system.
The number for Linux from 2006 survey is taken as total for Linux
table. "MS Windows (other)" means msys (native) version, or
unspecified whether Cygwin or MinGW/MSys.  If I remember correctly
there were no native Windows version (which is currently under
development) during previous survey.

Most is Linux, as before.  MacOS X is quite a percentage in current
survey, and dominates among non-Linux OS, coming before MS Windows.


22. What projects do you track (or download) using GIT
    (or git web interface)?

This question was not present in previous survey.


23. How many people do you collaborate with using GIT?

TO DO. This is free-form question; analysis for current survey is not
done yet.  The answer is not always simple number, but even those
answers which are limited to simple number (or contain simple number)
are not done yet.

I have posted question if first post in the thread about what ranges
(what categories) should be used here.  I haven't received any answer
yet.

Previous survey have table in two parts: first histogram of simple
number of people, second with names of communities (Cairo, Linux
kernel, U-Boot,...).

24. How big are the repositories that you work on?

TO DO. To be done *both* for 2007 (current) survey, and for 2006 one.


25. How many different projects do you manage using GIT?

This question was not present in previous survey.

Previous survey has empty question in this place, between those
questions.


26. Which porcelains do you use?
27. Which git GUI do you use?
28. Which (main) git web interface do you use for your projects?

The list of porcelains is different for previous and current
survey.  Git GUIs were moved to the next question in the 2007 survey,
and web interfaces to second next.

Note that there is some ambiguity concerning git-gui: it was put in
current survey in the GUI question only, while some people consider it
[also] porcelain (and put is as 'other' in porcelain).

Multiple answers (one can use more than one porcelain).

  Answer (multiple choice)       | Old | Count
  ----------------------------------------------
  core-git                       | 62  | 558
  cogito                         | 22  | 56

  Patch management interface:    : 13  : 57
  ..............................................
  StGIT                          | 11  | 41
  Guilt (formerly gq)            | n/a | 13
  pg (deprecated)                | 2   | 3
  ----------------------------------------------

One has to take into account the fact that neither Cogito nor pg
(Patchy GIT) were deprecated during previous survey.  Cogito got
deprecated because all of its functionality got moved in some way to
core git, while Petr 'Pasky' Baudis, main Cogito developer, didn't
have time for catching up to new git features.

Guilt is so new that it just simply was not yet created during
previous survey.


29. How do you publish/propagate your changes?

This question was not present in previous survey.


30. Does git.git repository include code produced by you?

(Previous survey had bad English here: "Is the git.git repository
including codes produced by you?")

  Answer                         | Old | Count
  ------------------------------------------------
  Yes                            | 73  | 99
  No                             | 34  | 512
  ------------------------------------------------
  Base                           |     | 611 / 683
  Total (sum)                    | 107 | 611

Complete reversion: from most survey participants having their
code in git.git (around 70%) a year ago to around a small amount
(around 16%) currently (!).

This might be cause by the fact that (I think) previous survey was
known mostly to people reading git mailing list, who often send their
own patches to this list.  Therefore there it would be nice to have
"How did you heard about this survey?" question.  (It would also help
finding where it is worth to send notice if/when we would want to make
another survey.)

Note also the following little fact:

  $ git shortlog -s --all --before="01-08-2006" | wc -l
  119 (and around 117 individual responses in 2006 survey)
  $ git shortlog -s --all --before="01-10-2007" | wc -l
  215 (and 683 individual responses in 2007 survey)

So it is simply not possible to have the same percentage of git
developers among git users (or rather git survey participants): 70%
out of 683 users is more than 465, which is more than git.git has
developers.


Internationalization
~~~~~~~~~~~~~~~~~~~~

31. Is translating GIT required for wider adoption?
32. What do you need translated?
33. For what language do you need translation for?

This whole section is new, and was not present in previous survey.


What you think of GIT
~~~~~~~~~~~~~~~~~~~~~

34. Overall, how happy are you with GIT?

  Answer                         | Old | Count
  ------------------------------------------------
  unhappy                        | 1   | 13
  not so happy                   | 19  | 36
  happy                          | 53  | 179
  very happy                     | 41  | 302
  completely ecstatic            | 1   | 112
  ------------------------------------------------
  Base                           |     | 642 / 683
  Total (sum)                    | 115 | 642

During the year the balance shifted slightly in the positive
direction: from mostly happy to very happy, to mostly very happy
leaning to happy.  And we have much more percentage of completely
ecstatic.

Good work!


35. How does GIT compare to other SCM tools you have used?

  Answer                         | Old | Count
  ------------------------------------------------
  Better                         | 80  | 505
  Equal (comparable)             | 20  | 96
  Worse                          | 8   | 30
  ------------------------------------------------
  Base                           |     | 631 / 683
  Total (sum)                    | 108 | 631

Here not much changed. The shape of this histogram is almost the same,
with slight shift towards "better than other SCMs used".

Note that 2006 survey has "Equal (or uncomparable)" instead of
"Equal (comparable)" as it is now.


36. What do you like about using GIT?

TO DO. Yet another free-form question. Tabularized for 2006 survey,
most encountered answers listed without count for 2007 survey.


37. What would you most like to see improved about GIT?
    (features, bugs, plug-ins, documentation, ...)

TO DO. As above: tabularized somewhat for previous survey, with the
list of ideas (divided broadly into categories) below the table; with
some ideas dropped.  For current survey there is only list of most
commonly encountered, and most interesting ideas.

Some of the 2006 ideas got implemented, or are being implemented, like
better documentation (Git User's Manual, documenting options), shallow
clones, win32 native binaries (via MinGS, in development), subproject
support (plumbing and beginnings of porcelain), libification and
builtinification (GSoC projects), increased verbosity when needed and
making error messages more helpful, graphical merges (git-mergetool:
interface to file-level graphical mergers like Meld, KDiff3 etc.), per
user configuration (~/.gitconfig rather that ~/.gitrc, and there is
even system wide configuration).  Some of ideas are repeated (like
"The Git Book" idea, although "Git User's Manual" fills it somewhat),
some ideas provided too hard (e.g. lazy clone aka remote alternates)
or without someone to implement them.  Some got abandoned, some will
probably never get implemented.

Even some suggestions in 2007 survey are actually implemented already,
for example git development Changelog (present in the form of
RelNotes), shallow clone support, submodules support. This means that
new features are not very well announced (which was also one of
comments in current survey).


38. If you want to see GIT more widely used, what do you think
     we could do to make this happen?

TO DO. List of suggestions for 2006 survey; for current 2007 survey
only two most striking.


Changes in GIT (since year ago, or since you started using it)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

39. Did you participate in previous Git User's Survey?
40. What improvements you wanted got implemented?
41. What improvements you wanted didn't get implemented?
42. How do you compare current version with version from year ago?
43. Which of the new features do you use?

This whole section is of course new (Git User's Survey 2006 was first
git survey ever; git is not very much older than that), and was not
present in previous survey.


Documentation
~~~~~~~~~~~~~

44. Do you use the GIT wiki?
45. Do you find GIT wiki useful?

Previous survey has two questions in one here: "Do you use the GIT
wiki? If yes, do you find it useful?".  This made it hard to
distinguish if "no" means "no I don't use GIT wiki" or "no it is not
useful".

This was one of the improvements over previous version of survey.


46. Do you contribute to GIT wiki?

This question was not present in previous survey.


47. Do you find GIT's on-line help (homepage, documentation) useful?

In 2007 survey there is additional "somewhat useful" answer, which was
not present in the 2006 survey.

  Answer                         | Old | Count
  --------------------------------------------
  Yes                            | 88  | 377
  No                             | 20  | 28
  Somewhat                       | -   | 172
  ------------------------------------------
  Base                           |     | 577 / 683
  Total (sum)                    | 108 | 577

The results are similar: most users find online help useful.


47b. What is your favourite user documentation for any software
     projects or products you have used?

This question is present in 2006 survey, and was removed in current
one. The idea behind question was I guess to have the results in hand
if git ever was to change documentation format. Most likely current
format of documentation (AsciiDoc), or at least idea behind it
(it should be possible to read sources, editing sources without
specialized editor support should be easy even for people who don't
know the format) is here to stay.


48. Do you find help distributed with GIT useful
    (manpages, manual, tutorial, HOWTO, release notes)?
49. Did/Do you contribute to GIT documentation?

Those questions were not present in previous survey.


50. What could be improved on the GIT homepage?

TO DO. List of suggestions for 2006 survey, nothing yet for 2007
survey.


51. What topics would you like to have on GIT wiki?
52. What could be improved in GIT documentation?

Those questions were not present in previous survey.


Getting help, staying in touch
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

53. Have you tried to get GIT help from other people?

  Answer                         | Old | Count
  ------------------------------------------------
  Yes                            | 68  | 357
  No                             | 45  | 261
  ------------------------------------------------
  Base                           |     | 618 / 683
  Total (sum)                    | 113 | 618

Around 60% of people tried to get GIT help from other people,
for both current (2007) and previous (2006) survey.


54. If yes, did you get these problems resolved quickly
    and to your liking?

  Answer                         | Old | Count
  --------------------------------------------
  Yes                            | 68  | 326
  No                             | 45  | 53
  ------------------------------------------
  Base                           |     | 379 / 683
  Total (sum)                    | 113 | 379

The precentage was a bit worse during earlier survey (around 60%) than
for corrent one (around 86%).

This might be caused by the fact that git is now more userfriendly,
and has more features, and problems are easier to resolve.


55. Would commerical (paid) support from a support vendor
    be of interest to you/your organization?

This question was not present in previous survey. It was requested
during an RFC for this year (2007) survey.


56. Do you read the mailing list?

  Answer                         | Old | Count
  ------------------------------------------------
  Yes                            | 67  | 204
  No                             | 50  | 406
  ------------------------------------------------
  Base                           |     | 610 / 683
  Total (sum)                    | 117 | 610

Note that 2006 version had "subscribe" instead of "read" in this
question.  Even despite that the number of people reading git mailing
list decreased from more than half (around 57%) to around third
(around 33%).  This might be caused by the fact that notice / info
about Git User's Survey 2006 was distributed mainly among git mailing
list and among mailing lists for projects which use git (see also
commets to questions 19 and 30).

The fact that only one third of git users are reading mailing list
(which is nevertheless quite large percentage) means that features
_have_ to be documented somewhere besides mailing list archive and
logs (commit messages).


57. If yes, do you find the mailing list useful?
58. Do you find traffic levels on GIT mailing list OK?

Previous survey has two questions in one here: "If yes, do you find it
useful, and traffic levels OK?".  They were split in current survey.


59. Do you use the IRC channel (#git on irc.freenode.net)?

  Answer                         | Old | Count
  ------------------------------------------------
  Yes                            | 23  | 182
  No                             | 93  | 376
  ------------------------------------------------
  Base                           |     | 558 / 683
  Total (sum)                    | 116 | 558

More people use #git channel now (33% as compared to 20% before).
Nevertheless relatively few people use this form of comminication and
getting help.


60. If yes, do you find IRC channel useful?

This question was not present in previous survey. It nicely follows in
the series of questions about git wiki and git mailing list (do you
use? is it useful?).


61. Did you have problems getting GIT help on mailing list
    or on IRC channel? What were it? What could be improved?

This question was not present in previous survey.


Open forum
~~~~~~~~~~

62. What other comments or suggestions do you have
    that are not covered by the questions above?

TO DO. There is list of responses for 2006 survey; the 141 responses
in current (2007) survey are not yet analysed.

-- 
Jakub Narebski
(currently away from net)
