From: Jakub Narebski <jnareb@gmail.com>
Subject: Git User's Survey 2008 partial summary, part 3
Date: Sat, 6 Sep 2008 04:22:32 +0200
Message-ID: <200809060422.34779.jnareb@gmail.com>
References: <200809031607.19722.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 06 04:24:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KbnSy-00015o-7g
	for gcvg-git-2@gmane.org; Sat, 06 Sep 2008 04:24:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752123AbYIFCWg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Sep 2008 22:22:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752117AbYIFCWg
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Sep 2008 22:22:36 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:48657 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752108AbYIFCWf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Sep 2008 22:22:35 -0400
Received: by fg-out-1718.google.com with SMTP id 19so871700fgg.17
        for <git@vger.kernel.org>; Fri, 05 Sep 2008 19:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:references:in-reply-to:mime-version:content-disposition
         :content-type:content-transfer-encoding:message-id;
        bh=3HZMi86KbkEoVpnC44mTm46YkbsenH1YcSXvxzaMkV8=;
        b=OnlQ6RWU9DA/Sdehgn2QYlN3qbYvf+1r6c6Um6kNP7Dq3P5nn3sfZmdRGtoFID4mdS
         iiTZqtKZHKnRdAancOZG1oKdAKNKl7Sz0qzLooe9voKOytNzmqmd7AoMBGLh1rfvUxSA
         gJv+2OSB2k7sb0u8slQTFrCfUfrmREncSakp0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:references:in-reply-to:mime-version
         :content-disposition:content-type:content-transfer-encoding
         :message-id;
        b=Gw2+eX85KKQmzgkHbQddZua/ANRhAD55kCza2S9ZIGlQ83NdgPKe+hcVD27YqmzGmT
         zB3kwrQMJzjhIJNDFayRcWbMjzP32P2HoOdUhV5YjKEf8IcB11oCSVmz6hJFCAC/sMwL
         FDXef+lArPGWnYKk8/Rc+Jhwrf9cSUbvS9sNw=
Received: by 10.86.79.19 with SMTP id c19mr9294751fgb.79.1220667753751;
        Fri, 05 Sep 2008 19:22:33 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.234.117])
        by mx.google.com with ESMTPS id d4sm1903949fga.5.2008.09.05.19.22.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 05 Sep 2008 19:22:33 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <200809031607.19722.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95057>

This is partial summary of Git User's Survey 2008 after more that 2000 
(yes, that is more than _two thousands_ responses) just after the 5 days
of running the survey.  It is based on "Analysis" page for this survey:
  http://www.survs.com/shareResults?survey=M3PIVU72&rndm=OKJQ45LAG8

We have around 2040 individual responses (excluding 21 responses in the 
'testing' channel), as compared to 683 individual responses for 2007 
survey, and (I think) 115 answers (Base = 115) for 2006 survey. 
That is quite a lot, especially after only five days (or so) since 
staring the survey.
 

Getting started with Git:
~~~~~~~~~~~~~~~~~~~~~~~~~

05. Did you find Git easy to learn?

Replies look like nice gaussian-like distribution, centered around the 
middle, but with slight bias towards 'easy' part, with 16% hard vs 24% 
easy, and 2% very hard vs 6% very easy.

The 2% (33) for 'very hard' can be a bit of a concern...


09. How long do you use Git?

Majority of people use Git for about from 3 months to 1 year (29% for 
3-6 months, 26% for 6-12 months). The graph is centered around this 
values, too. Few people (58, 3%) said that they use Git more than two 
years, fewer still (41, 2%) stated that they use it from the very 
beginning.

This hopefully means that most people had contact with git after it had 
improved its UI.


10. Rate your own proficiency with Git

Here again the distribution is almost perfectly symmetric.  Most people 
say that they are proficient with Git enough for everyday use (44%), 
slightly more (23%) can offer advice than selected 'casual, needs 
advice', while slightly more (7%) thinks themself novices than people 
who think that know Git very well (4%).

For this survey it seems to imply that results would not be biased 
(scewed) by people who know Git well to very well.


11. Does git.git repository include code produced by you?

154 says yes, 1674 says no, 227 skipped this question.

It is not just git developers that answer this question... which is kind 
of obvious because we do not have that many developers (I wish).


How do you use Git:
~~~~~~~~~~~~~~~~~~~

18. What operating system do you use Git on? (multiple answers)

This question was made multiple choices (one can use Git on different 
operating systems; either multi-boot, or multiple machines), as 
compared to free-form question in 2006 and 2007 survey.

Linux (or should we say GNU/Linux?) dominates with 82%, second is
MacOS X (Darwin) with 59%, and MS Windows is only third with 25%
(here msysGit is more popular with 15% than Cygwin with 10%).
If we consider fact that MS Windows dominates desktop, one can see that 
Git is not very popular choice for Windows machines, probably because 
of perceived and real shortcomings when trying to run it on non-POSIX 
operating system.  The domination of Linux is not strange considering 
fact that Git was created for the purpose of being distributed version 
control system for Linux kernel, and is designed around Linux features 
(fast fork, fast stat, prototyping using scripts, etc.).

Among 'other' operating systems there is iPhone, iPod, 
MS Windows/AndLinux,... but also for example Ubuntu or Debian Sarge,
which clearly should be marked as Linux instead.


19. What hardware platforms do you use Git on? (multiple answers)

Here slightly more people (88%) use 32-bit machines than 64-bit machines 
(61%)... if we can say that, as it is multiple choice question.  Few 
people chose 'portable/handheld' (51, 3%), fewer still selected 
'other' (8 replies). 

Here 'other' I think mean: I don't know which option to chose.  There is 
one OLPC-XO, but also PowerPC and PPC/G4.


20. What editor, IDE or RAD you use working with Git?

Currently Vim, with 48% or 841 responses, wins by narrow margin over 
TextMate which has 44% (782 responses).  Curious.

Emacs is third with 18%, followed closely by Eclipse with 13%.  More 
than 50 replies (responses) also have NetBeans IDE, XCode, MS Visual 
Studio and Notepad++.

Among 'other (please specify)' we have nano, Kate, Gedit, Geany, 
e-Editor (aka. TextMate for Windows) or just e, jEdit, SlickEdit, 
SharpDevelop, SciTE, Code::Blocks, joe, ActiveState Komodo, Aptana and 
a few others; even one 'ed' ;-)

Note that quite a few people wrote about integration with IDE/editor in 
the "35. What tools (or kind of tools) would you like to see Git 
support in?" question.

To be continued...

-- 
Jakub Narebski
Poland
