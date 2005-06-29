From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: Mercurial vs Updated git HOWTO for kernel hackers
Date: Tue, 28 Jun 2005 23:53:47 -0400
Message-ID: <12B6F9A5-81F8-46BD-A05D-B9FA1A70A9FF@mac.com>
References: <42B9E536.60704@pobox.com> <20050623235634.GC14426@waste.org>
	<20050624064101.GB14292@pasky.ji.cz>
	<20050624123819.GD9519@64m.dyndns.org>
	<20050628150027.GB1275@pasky.ji.cz>
	<20050628180157.GI12006@waste.org>
	<62CF578B-B9DF-4DEA-8BAD-041F357771FD@mac.com>
	<3886.10.10.10.24.1119991512.squirrel@linux1>
	<20050628221422.GT12006@waste.org>
	<3993.10.10.10.24.1119997389.squirrel@linux1>
	<20050628224946.GU12006@waste.org>
	<4846.10.10.10.24.1119999568.squirrel@linux1>
	<40A9C7C2-1AFE-45BC-90A5-571628304479@mac.com>
	<1765.10.10.10.24.1120001856.squirrel@linux1>
	<40A4071C-ED45-4280-928F-BCFC8761F47E@mac.com>
	<2661.10.10.10.24.1120004702.squirrel@linux1>
Mime-Version: 1.0 (Apple Message framework v730)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: mercurial@selenic.com, Petr Baudis <pasky@ucw.cz>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Jeff Garzik <jgarzik@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
X-From: mercurial-bounces@selenic.com Wed Jun 29 05:48:04 2005
Return-path: <mercurial-bounces@selenic.com>
Received: from waste.org ([216.27.176.166])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DnTXn-0001g1-HF
	for gcvmd-mercurial@gmane.org; Wed, 29 Jun 2005 05:47:23 +0200
Received: from waste.org (localhost [127.0.0.1])
	by waste.org (8.13.4/8.13.4/Debian-3) with ESMTP id j5T3rxXB025951;
	Tue, 28 Jun 2005 22:54:00 -0500
Received: from smtpout.mac.com (smtpout.mac.com [17.250.248.86])
	by waste.org (8.13.4/8.13.4/Debian-3) with ESMTP id j5T3rto3025942;
	Tue, 28 Jun 2005 22:53:55 -0500
Received: from mac.com (smtpin08-en2 [10.13.10.153])
	by smtpout.mac.com (Xserve/8.12.11/smtpout04/MantshX 4.0) with ESMTP id
	j5T3rqX3006622; Tue, 28 Jun 2005 20:53:52 -0700 (PDT)
Received: from [10.0.0.2] (ip70-187-212-71.dc.dc.cox.net [70.187.212.71])
	(authenticated bits=0)
	by mac.com (Xserve/smtpin08/MantshX 4.0) with ESMTP id j5T3rmdh000194
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NO);
	Tue, 28 Jun 2005 20:53:50 -0700 (PDT)
In-Reply-To: <2661.10.10.10.24.1120004702.squirrel@linux1>
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

On Jun 28, 2005, at 20:25:02, Sean wrote:
> there will be a price to pay if the linux community fragments over  
> choice
> of scm.

I don't agree.  With the current set of SCMs, I don't think it will  
be long
before somebody invents a gitweb/Mercurial/whatever gateway, such  
that I can
"hg serve" from my Mercurial repository and have Linus "git pull" from a
multiprotocol bridge.

> the good news is that we're no longer locked into the whims of
> some proprietary system.  so it should be straight forward for  
> those who
> choose any tool to work with those who've chosen another.  this is  
> already
> evidenced by the fact that the git repository is pulled and re- 
> exeported
> with mecurial.

I agree completely!  Cheers to the end of proprietary revision storage!

> anyway, all the best, just wish you guys would spend less time  
> trying to
> convert git users and more time advancing your own tool.

A project with no users isn't much of a project, now is it?  In any  
case,
this thread has long since passed its usefulness, so let's let it  
die, ok?

Cheers,
Kyle Moffett

--
I lost interest in "blade servers" when I found they didn't throw  
knives at people who weren't supposed to be in your machine room.
   -- Anthony de Boer
