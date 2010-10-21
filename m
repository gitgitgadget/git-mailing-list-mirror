From: Jakub Narebski <jnareb@gmail.com>
Subject: Git User's Survey 2010 very short summary
Date: Thu, 21 Oct 2010 23:24:56 +0200
Message-ID: <201010212324.58048.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 21 23:25:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P92dV-0002sh-AL
	for gcvg-git-2@lo.gmane.org; Thu, 21 Oct 2010 23:25:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758271Ab0JUVZH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Oct 2010 17:25:07 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:62996 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752931Ab0JUVZE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Oct 2010 17:25:04 -0400
Received: by fxm16 with SMTP id 16so74839fxm.19
        for <git@vger.kernel.org>; Thu, 21 Oct 2010 14:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=r6p+aNhnHFk8hHX0CMfKo/oEQS1he6d4SsCAc45/WNw=;
        b=oiPHowEkIIKkbE84PItEI6PvAeICoHr8SWEpLOXvPegAy6DhVnD357T3P2JulqYQ7p
         WA1ruCFBcUCoB10LsfDmHKJVbX1NWEl0vu3nnbx01QZhk6rA90P6oBPcARmZyGsGgfs/
         Ba1JBQGrumGqX6A9DqJhnDyRqeHjdpH6CRWcA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        b=GEJskX69DSySb3Ali238+Q/5kdAwVN0ATuy1QsBQS9gRGe+StuOC9UPmVCqfYVnGmQ
         CRka4mt4xOvHwCfa7/9V12WAJOYoxNFIG4Ql3A6lIvRUR6NCM3DxEc32UCDuC7wsCj7L
         wB2e6Lf0HkZxi0KcxqYcS+9AcfnmCPY768YCA=
Received: by 10.223.1.5 with SMTP id 5mr45268fad.39.1287696303200;
        Thu, 21 Oct 2010 14:25:03 -0700 (PDT)
Received: from [192.168.1.13] (abvl250.neoplus.adsl.tpnet.pl [83.8.209.250])
        by mx.google.com with ESMTPS id d17sm1100587fav.29.2010.10.21.14.25.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 21 Oct 2010 14:25:02 -0700 (PDT)
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159575>

You can see the results of "Git User's Survey 2010" at Git Wiki:

  https://git.wiki.kernel.org/index.php/GitSurvey2010


You can also view them and analyse using provided filters at
Survs.com:

  https://www.survs.com/results/33Q0OZZE/MV653KSPI2
  http://tinyurl.com/GitSurvey2010Analysis
 

..................................................................
Below there is very short summary of some of the results of
"Git User's Survey 2010"

Total responders: 8841 (compared to less that 4000 in 2009)

About you
^^^^^^^^^
Most responders are from USA among other coutries (31%), followed by
Germany, UK and France (10% to 6%).  Most responders are from Europe
among other continents (50%), with North America second (36%).

Most responders are between 26 and 30 years old; most common age (mode)
is 25 years old.  Youngest user who answered this question is 10 years 
old (next oldest is 12 years old), oldest is 87 (next to oldest is 81).


Getting started with Git
^^^^^^^^^^^^^^^^^^^^^^^^
Responders say that Git is reasonably easy to learn, and easy to 
reasonably easy to use; it is easier to use than to learn.

More than 80% use git version 1.7.x at least at one place.  There are 12 
unfortunate stragglers who use pre 1.3.x version.

Responders fall somewhere between 'everyday use' (39%) and 'can offer 
advice' (32%) proficiency.


How you use Git
^^^^^^^^^^^^^^^
Most people (74%) obtain/install Git at least at one place using ready 
binary packages.

GNU/Linux dominates among operating systems used, then there is MacOS X,
then MS Windows (where msysGit is preferred to Cygwin).

Almost 9% of responders use JGit.

gitk dominates among graphical tools (58%), GitX is second (28%), 
closely followed by git-gui (25%).

The leader among git hosting sites is (like in previous years) GitHub 
with 77% of responders (up from 62% in 2009); "self hosted" is second 
with 44%, but it is quite lower than 57% in 2009.  The high position of 
GitHub migh be at least partially caused by the fact that GitHub has 
good announcement system for new features, which was used to announce 
"Git User's Survey 2010" to GitHub users.

git:// protocol and SSH are almost the same often used to fetch changes: 
git protocol with 78%, SSH with 71%.  Only 41% responders use HTTP for 
fetching (somewhere).


Most popular feature, by quite a large margin, is *stash*, with two 
thirds (66.4%) of responses. "git stash" first appeared in git version 
1.5.3, from September 2007.

Second most common used feature is "shell completion of commands", with 
more than half of responses (52.0%).

Then there are, with percentage of responses from 40% to 45%, comitting 
with dirty tree and interactive / partial commit, interactive rebase, 
and aliases (git aliases, shell aliases, one's own git scripts).

More than third of responses have also git-aware shell prompt with 35%, 
and submodules with 33%.

Least used, with only 0.5% of responses, is "git cvsserver". 


One of the most requested features is native support for tracking empty 
directories, with 35.2%, followed closely by request for '-n' like 
option for each command, which would print what would happen, but do 
not actually execute command, with 33.5%.


What do you think of Git
^^^^^^^^^^^^^^^^^^^^^^^^
Most responders are "very happy" with Git, and this answer seems to be a 
center of responses.

User interface, tools and documentation need improvement; performance 
rather doesn't need to be improved; people mostly don't care about 
improving communities or localization (but please remember that this 
survey was in English, and announced on English-speaking sites / 
lists).


Documentation. Getting help.
^^^^^^^^^^^^^^^^^^^^^^^^^^^^
It looks like we have good community surrounding Git, if 62% of Git 
questions are resolved quickly and accurately, and only 7% couldn't get 
quick response and one to their liking. Those results are very similar 
to those from 2009 survey.

Most used way to request help about Git (help 'channel') is to simply 
ask somebody better versed in Git personally, with almost 60%; it is 
the same result as in previous surveys. This year StackOverflow 
(a Q&A site) came as second with 37%, moving up from 17% last year when 
it was a new thing (!!!).

The #git IRC channel with usually fast real-time response is now third 
at 18%, down from 31% in 2009 and 37% in 2008. Together with other IRC 
channels (git/SCM related with 7%, other with 11%) it comes up to 34%, 
close to StackOverflow 37%. One wonders how disruptive 
http://chat.stackoverflow.com would be...

Close fourth, with almost 18% of responses is instant messaging 
(XMPP/Jabber, Google Talk, AIM, QQ, ICQ, etc.), also with real-time 
response; 2009 survey had similarly 19% of IM users.

-- 
Jakub Narebski
Poland
