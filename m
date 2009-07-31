From: Jakub Narebski <jnareb@gmail.com>
Subject: Git User's Survey 2009 partial summary, part 1 - announcing survey, participation
Date: Fri, 31 Jul 2009 22:46:10 +0200
Message-ID: <200907312246.12134.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 31 22:46:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWyzl-00045c-R9
	for gcvg-git-2@gmane.org; Fri, 31 Jul 2009 22:46:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752289AbZGaUqW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Jul 2009 16:46:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752230AbZGaUqV
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Jul 2009 16:46:21 -0400
Received: from mail-ew0-f214.google.com ([209.85.219.214]:47394 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752031AbZGaUqV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Jul 2009 16:46:21 -0400
Received: by ewy10 with SMTP id 10so1794612ewy.37
        for <git@vger.kernel.org>; Fri, 31 Jul 2009 13:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=jDwh7GJWs0+ubSIXurUBnxaGVWVdkUlbhQP/sLzJTiE=;
        b=Z0LBU1dEsd+XuZ7S4b7v9DVymW5sAks4R36JWzWPD6R72Tv9KxVKqxISF2m4JNwVc1
         /cPAcAVpAVm7Fpn0n7Qr+cHfGbWGKK2w6PxJQ7o/g1OGXkMvKxlbqzUVJnqAu8IA9Dqg
         pjsCD32ggZKssRB6CUK+oq1ZJSPblSvgxfoNU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        b=GxZjawXS0irjW6f/klijgQu5yPDfJj7im4wkv9i2nokn0TSj8u7X16bqooWxCm8ov7
         hT0/NkdABsJHBXQ9FitdWAm/du5Nz5q9kh5pQzrjmep7YX0mJtDNaEQ6P43OtQDkacDx
         gqWBC0hswCTRqSWlCMF3kxjfuTETUGHUTGKpM=
Received: by 10.210.81.3 with SMTP id e3mr3693066ebb.12.1249073179944;
        Fri, 31 Jul 2009 13:46:19 -0700 (PDT)
Received: from ?192.168.1.13? (abvt17.neoplus.adsl.tpnet.pl [83.8.217.17])
        by mx.google.com with ESMTPS id 5sm4272542eyh.16.2009.07.31.13.46.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 31 Jul 2009 13:46:19 -0700 (PDT)
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124599>

It was half a month since Git User's Survey 2009 was started (it was
started on 15 July 2009), a quarter of duration time of the survey.

So I think this is time for partial summary of Git User's Survey 2009.


You can see summary of Git User's Survey 2009 responses (and make your
own analysis) at the following URL:

  http://www.survs.com/shareResults?survey=2PIMZGU0&rndm=678J66QRA2
  http://tinyurl.com/GitSurvey2009Analyze

After the survey ends (or earlier, if it is requested) the raw data
would be published on GitSurvey2009 page on Git Wiki in CSV and XLS
formats (like for GitSurvey2008).


We have currently (at the time I have checked this) around 2424
responses, as compared to 3236 individual responses (including 21
responses in 'test' channel) for survey in 2008, 683 individual
responses in 2007, and around 117 responses in 2006.

Those 3236 responses in 2008 were for around month and a half of
duration of survey, as compared to 2424 in half a month (16 days) now.
In 2008 after the first 3 days of [official] running we had 1045
responses.  In 2009 first three days bring 564+126+134 = 824
responses, but one should take into account the fact that announcement
mechanism was slightly different, and that announcement on GitHub was
delayed.  See also analysis of completion rate graph below, and its
correlation with the dates of announcing it in different places.

(Side note: perhaps it would be better to run Git User's Survey in
different term, and not in summer in the middle of holidays?).

There are three spikes on Completion Rate Graph - July 2009 ('Monthly'
view):
  Jul 15 | 564 respondents / day
  Jul 21 | 696 respondents / day
  Jul 27 | 152 respondents / day
(note that there is/was bug in Survs.com that made dates in 'Monthly'
view to be off by 1 day).  See below for analysis.

  Total respondents:  2424
  First response:     Jul 15, 2009
  Last response:      Jul 31, 2009
  Open during:        24 days
  Average time:       36 minutes

There were 12 responses in the channel that required no cookies, and
was totally anonymous, at the cost of not being able to go back to
one's responses to correct or complete it.

This survey was announced at the following blogs (note that dates
below for blog posts are in local timezone of blog, while Survs.com
dates are in survey admin timezone, currently GMT+01:00):
  July 14  | http://gitster.livejournal.com/36139.html
  July 15  | http://blogs.gnome.org/newren/2009/07/15/git-users-survey-2009
  July 15  | http://gitlog.wordpress.com/2009/07/15/git-users-survey-2009
  July 17  | http://blog.gitorious.org/2009/07/17/the-git-users-survey
  July 20* | http://github.com/blog/460-git-user-s-survey-2009

And also on the following blogs I have just found via blogsearch:
  July 17  | http://marilyn.frields.org:8080/~paul/wordpress/?p=2632
  July 17  | http://markelikalderon.com/blog/2009/07/17/git-users-survey-2009/
  July 27* | http://blog.hartwork.org/?p=451

If you know of any blogs which posted announcement about the survey,
but are not listed here, feel free to drop information about them
(with link).

As you can see the announcement on GitHub Blog (and via Twitter:
http://twitter.com/github/status/2746745923) correlate with the second
spike in responses, when we take difference in timezone into account.

It looks like the announcement on Hartwork Blog, part of Planet
Gentoo, was responsible for small spike in responses at 27 July.
But it might have been cased by announcement arriving via other
channel, see the table below.

The announcement was posted (with slight delay) on git homepage
(http://git-scm.com), and is present on "git ready" site with git tips
(http://www.gitready.com).  

The following git hosting sites have announced the survey:
 * repo.or.cz
 * git.kernel.org
 * GitHub (via blog)
 * Gitorious (via blog)

The following git hosting sites promised to announce the survey:
 * Assembla
 * Unfuddle
 * Codebase
 * InDefero

The announcement was added on http://wiki.debian.org/DeveloperNews
wiki page, where it would be relayed to debian-devel-announce mailing
list (hopefully before survey ends ;-)).

I have sent request for Git User's Survey 2009 announcement also to
Ohloh (software metric site), Perlbuzz (blog and Twitter) and LWN
(Linux Weekly News), currently without response or results.

Where should we send request for announcing Git User's Survey 2009?

----
Below there is analysis of single question from this survey;
the question which is related to announcing survey (and participation).

29) How did you hear about this Git User's Survey? 
    (Choice - Single answer)

===============================================================
Source                                   | resp [%] | resp [n]
---------------------------------------------------------------
blog (or blog planet)                    |      29% |      653
Twitter or other microblogging platform  |      14% |      310
git hosting site[1]                      |      14% |      308
git mailing list                         |      10% |      221
git homepage[2]                          |       5% |      117
mailing list or forum of some project[3] |       4% |       89
news web site or social news site[4]     |       4% |       87
software-related web site[5]             |       3% |       74
announcement on IRC channel              |       2% |       39
git wiki                                 |       2% |       38
git-related mailing list[6]              |       2% |       34
#git IRC channel topic[7]                |       1% |       21
other kind of web site                   |       1% |       20
.........................................|..........|..........
other - please specify                   |      11% |      244
-----------------------------------------+---------------------
Total respondents                        |                2255
Respondents who skipped this question    |                 169
===============================================================

Results are sorted in descending order of number of responses.  

As you can see most popular channel was blog or blog planet.  Next
are, with nearly the same number of votes (responses) are:
microblogging platform such as Twitter, Plurk, Jaiku, identi.ca or
Pownce, and announcement on git hosting site (note that some git
hosting site post announcement/news via blogs).  Third in turn was git
mailing list.

Note that this year I didn't "spam" mailing lists for projects which
use Git with announcement about Git User's Survey; nevertheless
announcement on project mailing list or forum is in the middle
(median) of announcement channels.

The free-form answer "other (please specify)" haven't been yet
analysed, but among others there are replies of 'reddit' and
'ycombinator' (which belongs IMHO in "news web site or social news
site" category), 'blog'/'planet xxx' (which belong to "blog (or blog
planet)" category), differently phrased 'word of mouth' / 'colleague'
category, 'instant messaging', [forwarded] [personal] email or
corporate mailing list or wiki, gitready (which I forgot to put as
possible option in the list), GitHub (which belong either to "blog" or
"git hosting site" category... although as one of responder states
"github, it is more than git hosting site" ;-)).

Footnotes:
----------
[1] sites such as git.kernel.org, repo.or.cz, GitHub, Gitorious;
    note that some git hosting sites use blogs to announce news
[2] some responders have chosen this option _before_ there was
    announcement posted on Git Homepage (http://git-scm.com) :-)
[3] this time I didn't send announcement to mailing list of (some)
    of projects using Git, with the sole exception of LKML (Linux)
[4] sites such as Digg, Reddit, Hacker News (YCombinator), etc.
[5] sites such as Ohloh or Freshmeat
[6] "Git for Human Beings" Google Group, msysGit mailing list,
    GitHub Google Group, Gitorious Google Group.
[7] other IRC channels like #github and #gitorious also put 
    announcement in the channel topic (channel description)

-- 
Jakub Narebski
Git User's Survey 2009: http://tinyurl.com/GitSurvey2009
