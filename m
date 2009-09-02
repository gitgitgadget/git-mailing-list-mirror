From: Jakub Narebski <jnareb@gmail.com>
Subject: Git User's Survey 2009 partial summary, part 3 - last 10 questions (incl. getting help)
Date: Wed, 2 Sep 2009 23:26:36 +0200
Message-ID: <200909022326.39338.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 02 23:27:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MixM4-0005Xu-Hk
	for gcvg-git-2@lo.gmane.org; Wed, 02 Sep 2009 23:27:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753043AbZIBV0m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Sep 2009 17:26:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753434AbZIBV0m
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Sep 2009 17:26:42 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:53994 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752855AbZIBV0l (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Sep 2009 17:26:41 -0400
Received: by bwz19 with SMTP id 19so1054822bwz.37
        for <git@vger.kernel.org>; Wed, 02 Sep 2009 14:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=yYJPU9iN67VUybDtGn1DhUo8amdN26MCTWE+rPP2EGw=;
        b=bEAwGrVInM5C1nwTrCtZl5u3VqtwWEe/A92ZkCfaDj/teT1HlWjsLLqAnXUwIIQBhl
         SGnLRA/bMvPGHOWJuKqEWrwTAaPmlUAZmO5D0K5h31ilUbfwEkGIVHxkT7tDSw83nzRr
         FsPi4xTvLcGlE/4ZkmkV+SbDbx6qCgk+PSn6g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        b=npjgSYbVchdI/zqP6fMoC2NyPGLhm4eZqf9fjv7M7gdxKF+7XVu/oUqTNJeiQC/ddy
         QxbPzx+ES6/RsP2hiH2F1hxS5j5hm2NKLW7ug296zcUBgnQALcPMK5QAF/Hx4MvM0W26
         bzhyPc/h522OElZJpT+doKi6hFjnhzsysZO/M=
Received: by 10.103.50.28 with SMTP id c28mr3816590muk.17.1251926801650;
        Wed, 02 Sep 2009 14:26:41 -0700 (PDT)
Received: from ?192.168.1.13? (abwf169.neoplus.adsl.tpnet.pl [83.8.229.169])
        by mx.google.com with ESMTPS id u26sm81231mug.17.2009.09.02.14.26.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 02 Sep 2009 14:26:40 -0700 (PDT)
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127632>

It is around month and a half since Git User's Survey 2009 was started
(it was started on 15 July 2009), which is a 3/4 of planned duration
time of the survey.

So I think this is time for third part partial summary of Git User's
Survey 2009.  The previous parts can be found at
  http://thread.gmane.org/gmane.comp.version-control.git/124599
  Subject: Git User's Survey 2009 partial summary, part 1 -
           - announcing survey, participation
  Message-Id: <200907312246.12134.jnareb@gmail.com>
and
  http://thread.gmane.org/gmane.comp.version-control.git/126153
  Subject: Git User's Survey 2009 partial summary, part 2 - 
           - from first 10
  Message-Id: <200908171224.44686.jnareb@gmail.com>

You can see summary of Git User's Survey 2009 responses (and make your
own analysis, optionally using provided set of filters) at the
following URL:

  http://www.survs.com/shareResults?survey=2PIMZGU0&rndm=678J66QRA2
  http://tinyurl.com/GitSurvey2009Analyze

After the survey ends (or earlier, if it is requested) the raw data
would be published on GitSurvey2009 page on Git Wiki in CSV and XLS
formats (like on http://git.or.cz/giwiki/GitSurvey2008).

........................................................

Total respondents:	3519
First response:	Jul 15, 2009
Last response:	Sep 01, 2009 (included in this analysis)
Open during:	56 days
Average time:	44 minutes

We have currently (status for 1 September 2009) around 3519 responses,
as compared to 3236 individual responses (including 21 responses in
'test' channel) for survey in 2008, 683 individual responses in 2007,
and around 117 responses in 2006.


20) Overall, how happy are you with Git? 
    (Choice - Single answer)

===========================================
Answer                | resp [%] | resp [n]
-------------------------------------------
unhappy               |      1%  |      34
not so happy          |      4%  |     140
happy                 |     23%  |     758
very happy            |     52%  |    1696
completely ecstatic   |     20%  |     650
----------------------+--------------------
Total respondents     |               3278
Skipped this question |                241
===========================================

There were some complaints during planning stage of this year survey
that the answers for this question are not symmetric; nevertheless it
is set of answers that was used in previous survey(s), and it would
help comparing data with previous surveys to keep it as it is now.

Most responders are very happy with Git, and this answer seems to be a
center of responses.  One should take into account that if one is
unhappy with Git, it is less likely that one would continue using it
(unless other circumstances would force using it, like the project one
contributes to using Git as DVCS of choice), thus less likely to be
Git user and to participate in this Git User's Survey.  There can be
bias because it is _Git_ survey; it might be different if it was
generic survey about (distributed) version control systems.


21) In your opinion, which areas in Git need improvement? 
    Please state your preference. 
    (Matrix - Rating)

------------------------------------------------------------------------------
Area in Git       | don't need |  a little  |    some    |    much    || Avg.
==============================================================================
user-interface    |  428 - 14% |  882 - 28% | 1055 - 33% |  707 - 22% || 2.59
documentation     |  340 - 11% |  946 - 30% | 1252 - 40% |  551 - 17% || 2.60
performance       | 2167 - 69% |  660 - 21% |  174 -  6% |   46 -  1% || 1.33
more features     | 1595 - 51% | 1007 - 32% |  360 - 11% |   53 -  2% || 1.55
tools (e.g. GUI)  |  681 - 22% |  696 - 22% |  934 - 30% |  758 - 24% || 2.51
i18n[1]           | 2184 - 69% |  398 - 13% |  225 -  7% |   89 -  3% || 1.27
------------------+-----------------------------------------------------------
Total respondents | 	                 3155
Skipped           | 	                  364
==============================================================================

Footnotes:
~~~~~~~~~~
[1] Originally "localization (translation)", shortened to "i18n"
    to reduce line length

Going by average rating, it is documentation (2.60) and user-interface
(2.59), and then tools (2.51) that needs improvements.  Areas that
needs improvement 'much' are tools (24%), UI (22%) and documentation
(17%); the same set, different priority.  Areas that needs 'some'
improvement are documentation (40%), then UI (33%) and tools (30%).
Areas that 'don't need' improvements are localization (translations)
and performance, both with around 69%, then 'more features' with 51%.



22) Did you participate in previous Git User's Surveys? 
    (Choice - Multiple answers)

=======================================================
Year                  | resp [%] | resp [n] || in year
-------------------------------------------------------
in 2006               |      11% |       88 ||     117
in 2007               |      30% |      251 ||     683
in 2008               |      97% |      801 ||    3236
----------------------+--------------------------------
Total respondents     |                 823
Skipped this question |                2696
=======================================================

"In year" column refers to number of replies (number of responses) in
the Git User's Survey for given year.  The percentage is calculated
relative to number of replies in this question, not to the total
number of responders.

======================================================
Year                  | resp   | resp      || in year
                      | / 3519 | / in year ||
------------------------------------------------------
in 2006               |   2.5% |     75.2% ||     117
in 2007               |   7.1% |     36.8% ||     683
in 2008               |  22.8% |     24.8% ||    3236
======================================================

Without further analysis (and the data that we don't have) we can only
assume that 2006 survey (narrowly announced) was answered mainly by
hard-core Git users and contributors, which follow Git announcements
and participate in surveys.

Note that 2008 (previous) and 2009 (this one) surveys were announced
in slightly different ways: 2008 was announced on git mailing lists,
2009 was announced on blogs and hosting sites.

If you want to try to do further analysis, there are filters for this
answers one can use to analyze survey responses.


23) How do you compare the current version with the version
    from one year ago? 
    (Choice - Single answer)

[FYI There is list of changes from year ago in the survey text]

===========================================
Answer                | resp [%] | resp [n]
-------------------------------------------
better                |     50%  |    1385
no changes            |      8%  |     228
worse                 |      0%  |      10
cannot say            |     42%  |    1162
----------------------+--------------------
Total respondents     |               2785
Skipped this question |                734
===========================================

Most people (50%) think that Git improved since year ago; very few 
(10 in 2785) think it is worse... but almost as many 'cannot say' (42%) 
if it is better than year ago.

If we take 'cannot say' as indication that responder didn't use Git a
year ago, and that is the reason they cannot do comparison, it seems
that there are many new Git users participating in this survey.


24) How useful have you found the following forms of Git documentation?
    (Matrix - One answer per row)

======================================================================
Documentation     | never used | not useful |  somewhat  | is useful
----------------------------------------------------------------------
Git Wiki          | 1138 - 36% |  135 -  4% | 1174 - 37% |  652 - 21%
on-line help      |  404 - 13% |  100 -  3% | 1283 - 40% | 1351 - 43%
help in git       |  249 -  8% |  199 -  6% | 1126 - 36% | 1560 - 49%
------------------+---------------------------------------------------
Total respondents |                                              3169
Skipped           |                                               350
======================================================================

Least used form of documentation is Git Wiki (http://git.or.cz/gitwiki)
with 36% responders never using it, but those that use it feel that it
is somewhat useful to useful.

Both help distributed with Git (manpages, Git User's Manual, HOWTOs,
etc.) and on-line help (including but not limited to Git Community
Book, and tutorials and guides on Git homepage) are almost the same
useful, with help included in Git felt to be more useful than on-line
help (49% vs 43% is useful, 36% vs 40% only somewhat).


25) Have you tried to get help regarding Git from other people?
    (Choice - Single answer)

This question, and questions following it were meant to be about
getting help from other people, rather than trying to find help by
self.  From the set of "other (please specify)" answers for "help
channel" (which include among others many instances of "Google search"
or equivalent) it looks like it was not entirely clean.

===========================================
Answer                | resp [%] | resp [n]
-------------------------------------------
Yes                   |     65%  |    2082
No                    |     35%  |    1121
----------------------+--------------------
Total respondents     |               3203
Skipped this question |                316
===========================================

As you can see 2/3 responders tried to get help regarding Git from
other people.


26) If yes, did you get these problems resolved quickly
    and to your liking?
    (Choice - Single answer)

===========================================
Answer                | resp [%] | resp [n]
-------------------------------------------
Yes                   |     63%  |    1349
No                    |      6%  |     122
Somewhat              |     32%  |     686
----------------------+--------------------
Total respondents     |        2157 / 2082
Skipped this question |        1362
===========================================

Consistency check: 2082 people answered that they tried to get help
about Git from other people, but we have 2157 responses in this
question...

It looks like we have good community surrounding Git, if 2/3 Git
questions are resolved quickly and accurately, and only 6% couldn't
get quick and to their liking response.


27) What channel(s) did you use to request help? 
    (Choice - Multiple answers)

==============================================================
Channel                                 | resp [%] | resp [n]
--------------------------------------------------------------
git mailing list (git@vger.kernel.org)  |     12%  |     261
"Git for Human Beings" Google Group     |      2%  |      48
IRC (#git)                              |     31%  |     668
IRC (other, e.g. #github)               |     10%  |     221
request in blog post or on wiki[1]      |      8%  |     176
asking git guru/colleague               |     58%  |    1248
project mailing list, or IRC, or forum  |     19%  |     416
Twitter or other microblogging platform |     12%  |     267
instant messaging (IM) like XMPP/Jabber |     19%  |     413
StackOverflow[2]                        |     17%  |     367
........................................|.....................
other (please specify)                  |      7%  |     154
--------------------------------------------------------------
Total respondents                       |     2148 / 2082
Respondents who skipped this question   |     1371
==============================================================

Footnotes:
~~~~~~~~~~
[1] Here I mainly meant asking a question on one's blog, and waiting
    for response in comments, like e.g.
      http://jjnapiorkowski.vox.com/library/post/migrating-to-git-from-subversion.html
    or asking on Git Wiki (as if it was help forum), or on Talk page
    of some other wiki (no example).
[2] StackOverflow is a community driven programming-related Q&A site
      http://stackoverflow.com/questions/tagged/git

Most used 'channel' is to simply ask somebody better versed in Git
personally (58%), then is #git channel with usually fast real-time
response (31%).  Git mailing list has only 12% of replies, below
(quite new) forums and project mailing lists (19% - wide category),
instant messaging (19%), and quite new StackOverflow (17%), and very
similar to microblogging platforms such as Twitter or Identi.ca (also
12%).

"Git for Human Beings" Google Group is rarely used, with only 2% of
responses...

As for "other (please specify)" response: 
* There are some responses ("Internet search", "Google", a book) that
  show that it was not entirely clear that the question was about
  asking _other people_ for help regarding Git, not searching for help
  oneself.
* Some responses (e.g. "colleagues") were variant of provided channel.
* Some responses were more detailed specification (description) of
  channel used; examples include "#dri-devel on freenode", 
  "Rick (friend)", "IRC (channel of project using git)", 
  "Rotating my chair and asking", etc.
* And there were channels that were not included in the list of
  provided answers (some because channel is rare, some because I
  didn't think of such channel):
   - GitHub mailing list / GitHub Google Group
   - asking a guy who gave a talk about git at a conference
   - messages through GitHub
   - private email
   - direct email with tutorial author
   - msysGit mailing list / msysGit Google Group
   - Server Fault (but Stack Overflow is on list)
   - Specialists at the work office

Perhaps this question should be about all kinds of getting help, not
only about requesting (asking for) Git-related help?  What do you
think?


When doing this analysis I have realized that we have survey question
about _requesting help_, but we don't have question about _providing
help_.  Do you participate in Git mailing list?  Are you present on
#git channel on FreeNode (or other IRC channel) and reply to
questions?  Or perhaps you are editing Git Wiki (or at least remove
spam)?  Do you post responses (answers) to questions tagged [git] on
Stack Overflow (and Server Fault and Superuser)?  Are you considered
to be Git guru and/or go-to guy in questions related to Git by your
colleagues or/and co-workers?

The next question is a bit related, but is only about using specified
channels, which can include providing help in given channel, but
doesn't need to.


28) Which communication channel(s) do you use? 
    Do you read the mailing list, or watch IRC channel?
    (Choice - Multiple answers)

==============================================================
Channel                                 | resp [%] | resp [n]
--------------------------------------------------------------
git@vger.kernel.org (main)              |     42%  |     368
Git for Human Beings (Google Group)     |      7%  |      64
msysGit                                 |     10%  |      89
#git IRC channel                        |     54%  |     473
#github or #gitorious IRC channel       |     22%  |     188
#revctrl IRC channel                    |      0%  |       4
--------------------------------------------------------------
Total respondents                       |                868
Respondents who skipped this question   |               2651
==============================================================

Note that percentage is relative to the (small) number of replies to
this question, not relative to the number of all responders.

Among listed channels, most commonly used are #git IRC channel on
FreeNode with 54%, and git mailing list (git@vger,kernel.org) with
42%.  Third is #github and #gitorious IRC channels together, with 22%
or replies to this question.

-- 
Jakub Narebski

Git User's Survey will last till 15 September
http://tinyurl.comGitSurvey2009
