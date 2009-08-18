From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Git User's Survey 2009 partial summary, part 2 - from first 10
Date: Tue, 18 Aug 2009 19:00:00 +0200
Message-ID: <200908181900.03356.jnareb@gmail.com>
References: <200908171224.44686.jnareb@gmail.com> <20090818155452.GA12938@vidovic>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
X-From: git-owner@vger.kernel.org Tue Aug 18 19:00:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdS3A-0005Yu-P1
	for gcvg-git-2@lo.gmane.org; Tue, 18 Aug 2009 19:00:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759433AbZHRRAO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Aug 2009 13:00:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759427AbZHRRAO
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Aug 2009 13:00:14 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:16726 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759409AbZHRRAM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Aug 2009 13:00:12 -0400
Received: by fg-out-1718.google.com with SMTP id e21so901682fga.17
        for <git@vger.kernel.org>; Tue, 18 Aug 2009 10:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=cSBN+wg0lFKtfjF2x5fN4GbjhOYnia4c4fAWtrX9cdY=;
        b=ZJQKGDFFUWB3hP3f2YzaU6GkgyuxnEXq18XsdN1cy8sXgxFNhtXLRurX5E5E59Rdob
         IgNh6jTK5SEb52tokQThlac1RKb2qbVWo/6YJIOXgKUe1BDdos4ZQnCOuBUu8uitT5Uo
         3BB7mNPrgBw+cj/6xcJPDe66sbWagGUleZjKw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=xy21mwe+ewsK2eS6U+int8L1X+elhXS5+i5Bj/r8OOXuHF8gfUQNe5JNLkNkkuJiIf
         FPtq9uK2+LXUHrCFwXZbSXGCnbQpCgCpnUTpbL4pRDFSnT25dx5Y6715jEayH4zXHnqJ
         J8LYSjeMBQU44gGBvv6OzIousrjUek4o5cqzY=
Received: by 10.86.217.8 with SMTP id p8mr3432799fgg.73.1250614813048;
        Tue, 18 Aug 2009 10:00:13 -0700 (PDT)
Received: from ?192.168.1.13? (abvz12.neoplus.adsl.tpnet.pl [83.8.223.12])
        by mx.google.com with ESMTPS id l19sm11310925fgb.7.2009.08.18.10.00.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 18 Aug 2009 10:00:11 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20090818155452.GA12938@vidovic>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126421>

On Tue, 18 Aug 2009, Nicolas Sebrecht wrote:
> The 17/08/09, Jakub Narebski wrote:
> 
> > Git User's Survey 2009 partial summary, part 2 - git difficulty,
> > proficiency, uses, install, OS, editors.
> 
> Thanks for these partial summaries.

You are welcome.  Next summary either around 1 September (3/4 duration),
or after passing number of responses in previous survey; it also depends
when I would have time.

> > 3) Have you found Git easy to learn?
> > 4) Have you found Git easy to use?
> >    (Choice - Single answer)
> > 
> > ================================================
> > Answer            | to learn [%] |   to use [%]
> > ------------------------------------------------
> > Very easy         |          4%  |          9%
> > Easy              |         20%  |         36%
> > Reasonably easy   |         55%  |         45%
> > Hard              |         19%  |          8%
> > Very hard         |          2%  |          1%
> > ------------------------------------------------
> > Total respondents |        2942  |        2959
> > ================================================
> 
> <...>
> 
> > What's interesting is comparing (percentage) results for questions
> > 3. and 4.; how hard is git to learn versus how hard is to use.  It
> > seems like Git is reasonably easy to learn, and reasonably easy to
> > easy to use.  So it looks like Git just have somewhat steep learning
> > curve, and the difficulty to learn pays in being more powerful to
> > use.
> 
> I believe it would be interesting to know who (from the question 6.)
> think what later. We may expect that people of the grade 4 and 5 ("can
> offer advice" and "know it very well") underestimate the difficulty to
> learn Git.

Well, you can do some analysis yourself, using just created filters at
http://www.survs.com/shareResults?survey=2PIMZGU0&rndm=678J66QRA2

For example:

================================================|
                  |    proficiency with Git     |
To learn          |-----------------------------|
                  | any*[%] | 1-3 [%] | 4-5 [%] |
------------------------------------------------|
Very easy         |     4%  |     3%  |     5%  |
Easy              |    20%  |    19%  |    22%  |
Reasonably easy   |    55%  |    55%  |    56%  |
Hard              |    19%  |    20%  |    16%  |
Very hard         |     2%  |     3%  |     1%  |
------------------------------------------------|
Total respondents |   3005  |   1786  |   1212  |
================================================|

Footnote:
^^^^^^^^^
[*] This means no filter, which includes people who didn't answered
    question about proficiency, but answered this one.
 
> Also (and as you said), this "Git's users" survey won't have answers
> from unsatisfied users who left Git. We can't rate the number of users
> who left Git because they found it too much hard to learn.

Here also you have to be careful about the fact that "correlation does
not imply causation" (or, if you prefer Latin version, "cum hoc ergo
propter hoc").  The causation might be both ways: gurus don't find
git hard to learn, or don't remember that it was hard to learn; people
who find git hard to learn do not become git gurus.

-- 
Jakub Narebski

http://git.or.cz/gitwiki/GitSurvey2009
