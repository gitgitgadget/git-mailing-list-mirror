From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Git User's Survey 2009 partial summary, part 2 - from
 first 10
Date: Mon, 17 Aug 2009 23:39:06 +0200
Message-ID: <200908172339.08767.jnareb@gmail.com>
References: <200908171224.44686.jnareb@gmail.com> <200908171244.21693.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, msysgit@googlegroups.com
To: Johan Herland <johan@herland.net>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Mon Aug 17 23:32:18 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-yw0-f140.google.com ([209.85.211.140])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Md9oP-0005Oz-1j
	for gcvm-msysgit@m.gmane.org; Mon, 17 Aug 2009 23:32:17 +0200
Received: by mail-yw0-f140.google.com with SMTP id 4so5219939ywh.22
        for <gcvm-msysgit@m.gmane.org>; Mon, 17 Aug 2009 14:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received:received-spf:authentication-results
         :received:dkim-signature:domainkey-signature:received:received:from
         :to:subject:date:user-agent:cc:references:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :message-id:sender:precedence:x-google-loop:mailing-list:list-id
         :list-post:list-help:list-unsubscribe:x-beenthere-env:x-beenthere;
        bh=HSfctTHX6NW0so8XlBftm4MJJaPL2DDRwHY8NiBdXyo=;
        b=a/0DSzj7r3RONwaedfnY7ntKFf1zBBkgR3eQBh2k077joF4ggauuG+PfxGFDVQcF0N
         hfbMQNLlZRs0h6hRM+AHsPobm743WE0zH7nnZbXEwkNR9ZY0CeRo6RCiJpwQo/0FbAwS
         wP256KpihnG+0X1aVV9N5pcAFNjPrT/VJM7Zs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :dkim-signature:domainkey-signature:from:to:subject:date:user-agent
         :cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id:sender
         :precedence:x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        b=i++/JjK5M52oWZeJTdFFmG2oVqqV2WzScalaZHV7+L1RU78pCXCFbb1dIkCCg5tr3N
         pmh7iO2Na5bRLOPImUvrIqGVASG34nb4hnnk7n96tnGcahkI/PPFV7mFQD/aLW7fIScm
         xYSv8e918oZjPeIHYbijAvtrp+LBGduBo+FWg=
Received: by 10.150.160.10 with SMTP id i10mr1283389ybe.11.1250544731380;
        Mon, 17 Aug 2009 14:32:11 -0700 (PDT)
Received: by 10.176.46.2 with SMTP id t2gr6407yqt.0;
	Mon, 17 Aug 2009 14:32:09 -0700 (PDT)
X-Sender: jnareb@gmail.com
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.204.39.198 with SMTP id h6mr207658bke.23.1250544727519; Mon, 17 Aug 2009 14:32:07 -0700 (PDT)
Received: by 10.204.39.198 with SMTP id h6mr207657bke.23.1250544727499; Mon, 17 Aug 2009 14:32:07 -0700 (PDT)
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.159]) by gmr-mx.google.com with ESMTP id 16si669439bwz.4.2009.08.17.14.32.06; Mon, 17 Aug 2009 14:32:06 -0700 (PDT)
Received-SPF: pass (google.com: domain of jnareb@gmail.com designates 72.14.220.159 as permitted sender) client-ip=72.14.220.159;
Authentication-Results: gmr-mx.google.com; spf=pass (google.com: domain of jnareb@gmail.com designates 72.14.220.159 as permitted sender) smtp.mail=jnareb@gmail.com; dkim=pass (test mode) header.i=@gmail.com
Received: by fg-out-1718.google.com with SMTP id e12so738219fga.0 for <msysgit@googlegroups.com>; Mon, 17 Aug 2009 14:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma; h=domainkey-signature:received:received:from:to:subject:date :user-agent:cc:references:in-reply-to:mime-version:content-type :content-transfer-encoding:content-disposition:message-id; bh=ciJa1spRxUkenm2N5slO2B7dQs46Otl5zwfmD1FbBJ0=; b=u4E/7glkwUdNf4jHfuiaU/+cG7HYn16DcA3q4ABf65WDpLb3TIJwVkOUqkJHGuLNwQ MozMK3faUlZMJwGGfoPn/SXH5ew1Ni76zAtCUmccQHB5K2LMy6MENjXF7JGg9+qpZcy4 gSok3EHbiUbcr8XwHf9toy6/d+NoxFfyNFKM8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=gmail.com; s=gamma; h=from:to:subject:date:user-agent:cc:references:in-reply-to :mime-version:content-type:content-transfer-encoding :content-disposition:message-id; b=dU0p74F/+JM2mAhoaU/+KCIM7Ye4MP79M4kt9IhuMj8DSlhX+etndrDtkv913diRVT jn7jZw+N1jNChtudGUYHRKzJq1XirlW+wcqODHXdC3A6HTyuc8+pxabRo5qGOznjXq3T IhXCXxvMbOx2yQ4TTtYz0EyGm2/s3cHUHP6SA=
Received: by 10.86.247.18 with SMTP id u18mr2699447fgh.43.1250544726171; Mon, 17 Aug 2009 14:32:06 -0700 (PDT)
Received: from ?192.168.1.13? (abvz12.neoplus.adsl.tpnet.pl [83.8.223.12]) by mx.google.com with ESMTPS id 3sm3805278fge.25.2009.08.17.14.32.04 (version=TLSv1/SSLv3 cipher=RC4-MD5); Mon, 17 Aug 2009 14:32:04 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <200908171244.21693.johan@herland.net>
Content-Disposition: inline
Sender: msysgit@googlegroups.com
Precedence: bulk
X-Google-Loop: groups
Mailing-List: list msysgit@googlegroups.com;
	contact msysgit+owner@googlegroups.com
List-Id: <msysgit.googlegroups.com>
List-Post: <mailto:msysgit@googlegroups.com>
List-Help: <mailto:msysgit+help@googlegroups.com>
List-Unsubscribe: <http://googlegroups.com/group/msysgit/subscribe>,
	<mailto:msysgit+unsubscribe@googlegroups.com>
X-BeenThere-Env: msysgit@googlegroups.com
X-BeenThere: msysgit@googlegroups.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126291>


On Mon, 17 Aug 2009, Johan Herland wrote:
> On Monday 17 August 2009, Jakub Narebski wrote:

> > 9) On which operating system(s) do you use Git?
> >    (Choice - Multiple answers)
> >
> > On Unix-based operating system you can get the name of operation
> > system by running 'uname'.
> 
> I find it interesting to compare the answers to this question against 
> previous years' surveys:
> 
> =============================================================
> Operating system            | 2009 [%] | 2008 [%] | 2007 [%]
> -------------------------------------------------------------
> Linux                       |      88% |      86% |      90%
> MacOS X (Darwin)            |      44% |      47% |      15%
> MS Windows/Cygwin           |       9% |      10% |      >3%?
> MS Windows/msysGit (MINGW)  |      21% |      16% |      >0%?
> ............................|..........|..........|..........
> MS Windows (any)            |      27% |     <26%?|       9%

Whet might be also interesting is to have (also) bare numbers of
responses.  Percentage alone wouldn't tell full story.  If you have
(for example) 1000 Linux users, and there gets released native MacOS X
binary installer, and here comes 500 MacOS X users, the percentage
would decrease, because there are now more users, some of which are
not Linux users.

=================================================
Operating system            | 2009 | 2008 | 2007#
-------------------------------------------------
Linux                       | 2623 | 2434 |  582
MacOS X (Darwin)            | 1304 | 1330 |   94
MS Windows/Cygwin           |  279 |  297 |   22
MS Windows/msysGit (MINGW)  |  625 |  452 |    1
............................|......|......|......
MS Windows (any)            |  820 |  749?|   58*
----------------------------+------+------+------
Answers                     | 2991 | 2842 |  645       
=================================================

Footnotes:
[#] First download on current msysGit page is from Aug 2007
[*] Including unspecified version of Git for MS Windows.
[?] "Other, please specify" not included.  It also doesn't
    take into account overlap (one might use both msysGit and Cygwin
    version, e.g. on different computers)

-- 
Jakub Narebski

Git User's Survey 2009: http://tinyurl.com/GitSurvey2009
