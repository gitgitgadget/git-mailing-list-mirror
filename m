From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: Mercurial vs Updated git HOWTO for kernel hackers
Date: Tue, 28 Jun 2005 18:47:36 -0400
Message-ID: <6CD96997-0454-40C0-89B3-AD2A2A7692B3@mac.com>
References: <42B9E536.60704@pobox.com> <20050623235634.GC14426@waste.org>
	<20050624064101.GB14292@pasky.ji.cz>
	<20050624123819.GD9519@64m.dyndns.org>
	<20050628150027.GB1275@pasky.ji.cz>
	<20050628180157.GI12006@waste.org>
	<62CF578B-B9DF-4DEA-8BAD-041F357771FD@mac.com>
	<3886.10.10.10.24.1119991512.squirrel@linux1>
	<20050628221422.GT12006@waste.org>
	<3993.10.10.10.24.1119997389.squirrel@linux1>
Mime-Version: 1.0 (Apple Message framework v730)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: mercurial@selenic.com, Petr Baudis <pasky@ucw.cz>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Jeff Garzik <jgarzik@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
X-From: mercurial-bounces@selenic.com Wed Jun 29 00:41:38 2005
Return-path: <mercurial-bounces@selenic.com>
Received: from waste.org ([216.27.176.166])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DnOlc-0002bM-M6
	for gcvmd-mercurial@gmane.org; Wed, 29 Jun 2005 00:41:21 +0200
Received: from waste.org (localhost [127.0.0.1])
	by waste.org (8.13.4/8.13.4/Debian-3) with ESMTP id j5SMlvht022081;
	Tue, 28 Jun 2005 17:47:57 -0500
Received: from smtpout.mac.com (smtpout.mac.com [17.250.248.89])
	by waste.org (8.13.4/8.13.4/Debian-3) with ESMTP id j5SMln0L022069;
	Tue, 28 Jun 2005 17:47:49 -0500
Received: from mac.com (smtpin01-en2 [10.13.10.146])
	by smtpout.mac.com (Xserve/8.12.11/smtpout02/MantshX 4.0) with ESMTP id
	j5SMlg8Q017768; Tue, 28 Jun 2005 15:47:42 -0700 (PDT)
Received: from [10.0.0.2] (ip70-187-212-71.dc.dc.cox.net [70.187.212.71])
	(authenticated bits=0)
	by mac.com (Xserve/smtpin01/MantshX 4.0) with ESMTP id j5SMlb1Q028497
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NO);
	Tue, 28 Jun 2005 15:47:40 -0700 (PDT)
In-Reply-To: <3993.10.10.10.24.1119997389.squirrel@linux1>
X-Priority: 3 (Normal)
To: Sean <seanlkml@sympatico.ca>
X-Mailer: Apple Mail (2.730)
X-Virus-Scanned: by amavisd-new
X-BeenThere: mercurial@selenic.com
X-Mailman-Version: 2.1.5
Precedence: list
List-Id: mercurial.selenic.com
List-Unsubscribe: <http://selenic.com/mailman/listinfo/mercurial>,
	<mailto:mercurial-request@selenic.com?subject=unsubscribe>
List-Archive: <http://www.selenic.com/pipermail/mercurial>
List-Post: <mailto:mercurial@selenic.com>
List-Help: <mailto:mercurial-request@selenic.com?subject=help>
List-Subscribe: <http://selenic.com/mailman/listinfo/mercurial>,
	<mailto:mercurial-request@selenic.com?subject=subscribe>
Sender: mercurial-bounces@selenic.com
Errors-To: mercurial-bounces@selenic.com

On Jun 28, 2005, at 18:23:09, Sean wrote:
> Git is still developing, there will be new ways to seek and cache  
> things
> etc eventually that remove any performance issue.  Git gets this  
> right, it
> concentrates on what is important, stays flexible and trusts that  
> down the
> road as things mature any performance problems can be dealt with.

Have you tried (or even looked at) Mercurial?  I'm now using it for four
different projects that used to be in CVS and I'm loving it.

> It already has some tools that are better than BK ever had (gitk,  
> gitweb,
> etc..)

Likewise for Mercurial, except that IMHO, a from-scratch Mercurial  
pull via
HTTP + Mercurial checkout is faster than a BK or GIT checkout alone.   
And
then there's the fact that it stores the whole mess in a fraction of the
space used by git.

Please, just _try_ it first.  You'll like it, I promise.  (It's also a
much smaller codebase too)

Cheers,
Kyle Moffett

--
I lost interest in "blade servers" when I found they didn't throw  
knives at people who weren't supposed to be in your machine room.
   -- Anthony de Boer
