From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Git User's Survey 2008 partial summary, part 2
Date: Thu, 4 Sep 2008 15:23:37 +0200
Message-ID: <200809041523.40601.jnareb@gmail.com>
References: <200809031607.19722.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 04 15:25:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KbEpQ-0001ao-Gn
	for gcvg-git-2@gmane.org; Thu, 04 Sep 2008 15:24:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753315AbYIDNXp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Sep 2008 09:23:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753208AbYIDNXp
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Sep 2008 09:23:45 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:24095 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753191AbYIDNXo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Sep 2008 09:23:44 -0400
Received: by nf-out-0910.google.com with SMTP id d3so586872nfc.21
        for <git@vger.kernel.org>; Thu, 04 Sep 2008 06:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:references:in-reply-to:mime-version:content-disposition
         :content-type:content-transfer-encoding:message-id;
        bh=HQRSdSiq0k5uggw0OSTWKIW+n5I10ampP+wnAL61n/M=;
        b=JoBYhyN6s1QZ6dWA19y6gDjbZHgHxNaKwM3vFWlDMGupgHq+lVcXXN0I6sCPi/IYbG
         Bt2JMhbSNiK6hPzEj159rnpsKxUSEHOm6M6i3Nym3jTkkje4lcy7SwOVh0ba5LCOryOk
         oKZQ7XjpZguzOvWsu/PVtjWkPZLQpLRTxaKO0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:references:in-reply-to:mime-version
         :content-disposition:content-type:content-transfer-encoding
         :message-id;
        b=vXufXXtPrr8iWDWIf68bqSpYnR54av1kwU8OXgV0ybD5aD6ZfG26pjRCoe7MCApBkE
         R2FrQa8niwbuOr5LdwVN9v9wNt5Q/z1wux2BF24E00ThzUa2kIOLpzuTXlqODUCZEv6Y
         5jYJ3LV3IsDUFIYDn+7QEEosPaOUkIHXqPcqk=
Received: by 10.210.41.1 with SMTP id o1mr11898586ebo.143.1220534622757;
        Thu, 04 Sep 2008 06:23:42 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.201.254])
        by mx.google.com with ESMTPS id 3sm13825607eyi.5.2008.09.04.06.23.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 04 Sep 2008 06:23:42 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <200809031607.19722.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94931>

This is partial summary of Git User's Survey 2008 after more that 1600 
(yes, that is more 1.6 _thousands_ responses) just after the 4 days
of running the survey.  It is based on "Analysis" page for this survey:
  http://www.survs.com/shareResults?survey=M3PIVU72&rndm=OKJQ45LAG8
 
We have around 1606 individual responses (excluding 21 responses in the 
'testing' channel), as compared to 683 individual responses for 2007 
survey, and (I think) 115 answers (Base = 115) for 2006 survey. 
That is a lot, especially after so short time since staring the 
survey.


03. With which programming languages are you proficient?

Situation changed a bit since last announcement.  Nor Ruby with 59%
dominates a bit over C with 55%.  I guess this is caused by GitHub
crowd: announcement about this survey was posted on GitHub blog
(thanks defunkt!).
 
There are now 22 responses (around 1%) of "I am not a programmer".
This means that you don't need to be a programmer to use Git.

Popular (from what I have glanced) languages in the 'other' section
include Erlang, Lua, OCaml, Haskell, Objective-C; there is Scala, Vala, 
Smalltalk, R, ActionScript, Prolog, SQL, Forth, and even TeX/LaTeX 
mentioned; someone even wrote Brainfuck here. 


04. How did you hear about Git?

Here 'blog entry' and 'some project uses it' with 38% dominates over 
'Linux kernel news' and 'word of mouth' with 22-24%.

Among 'other' there is quite popular Google Tech Talk about Git by Linus 
Torvalds, available on YouTube (which admittedly probably should be as 
one of choices), LKML (Linix kernel mailing list) which probably some 
put as 'Linux kernel news' and some not, FLOSS podcast, GitHub, Ruby 
adopting Git.  Among more unique and interesting 'other' replies there 
is "Faculty Advisor at NSF REU" and "school Professor", "Ruby community 
just went apeshit all of a sudden" ;-) and "Ruby On Rails switching to 
git overnight"; some individual people line 'Randall Schwartz' or 
'Scott Chacon'.


08. Which Git version(s) are you using? (multiple choices)

Most people use current version of git: 70% use git 1.5.x, and 40% use 
git 1.6.x, and only 3 people use pre 1.3.x version.  Note that some
people use different versions on different machines, or on different 
operating systems, so the numbers do not add to 100%.

Around 8% (123 replies) use 'master' branch.  Sorry Junio, it looks like 
it wouldn't be easy to find/detect bugs as soon as they hit 'master', 
before releasing.  (Unfortunately this survey lack question to find how 
many people run *-rcN (release candidate) version, but it is very long 
as it is with 60 questions and 55 minutes average time of answering 
question, and anegdotical evidence (comments) of requiring around 15 
minutes to fill it without spending much time on free-form questions).


25. How do you publish/propagate your changes? (multiple choices)

Most people (92%) simply push to publishing public repository.  Second 
is 'pull request' with 32%; I guess this includes GitHub social thingy.
git-svn as form of publishing changes is third with 27%; thanks Eric 
Wong!  Format-patch + email is only fourth with 22%, but quite close to 
git-svn and pull-request.

For publishing to other SCMs (32 replies, 2% or responses) people use 
git-bzr, git-p4, git-cvsexportcommit, git-acu (AccuRev); some publish 
to Mercurial, ClearCase or Visual SourceSafe.


To be continued...

P.S. Which non free-form questions are you interested most, BTW?
-- 
Jakub Narebski
Poland
