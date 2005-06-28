From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: Mercurial vs Updated git HOWTO for kernel hackers
Date: Tue, 28 Jun 2005 19:25:24 -0400
Message-ID: <40A9C7C2-1AFE-45BC-90A5-571628304479@mac.com>
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
Mime-Version: 1.0 (Apple Message framework v730)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: mercurial@selenic.com, Petr Baudis <pasky@ucw.cz>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Jeff Garzik <jgarzik@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
X-From: mercurial-bounces@selenic.com Wed Jun 29 01:19:23 2005
Return-path: <mercurial-bounces@selenic.com>
Received: from waste.org ([216.27.176.166])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DnPMC-0007f0-RM
	for gcvmd-mercurial@gmane.org; Wed, 29 Jun 2005 01:19:09 +0200
Received: from waste.org (localhost [127.0.0.1])
	by waste.org (8.13.4/8.13.4/Debian-3) with ESMTP id j5SNPfhH027991;
	Tue, 28 Jun 2005 18:25:43 -0500
Received: from smtpout.mac.com (smtpout.mac.com [17.250.248.70])
	by waste.org (8.13.4/8.13.4/Debian-3) with ESMTP id j5SNPZXI027970;
	Tue, 28 Jun 2005 18:25:35 -0500
Received: from mac.com (smtpin08-en2 [10.13.10.153])
	by smtpout.mac.com (Xserve/8.12.11/smtpout13/MantshX 4.0) with ESMTP id
	j5SNPVFV011062; Tue, 28 Jun 2005 16:25:31 -0700 (PDT)
Received: from [10.0.0.2] (ip70-187-212-71.dc.dc.cox.net [70.187.212.71])
	(authenticated bits=0)
	by mac.com (Xserve/smtpin08/MantshX 4.0) with ESMTP id j5SNPP7n002243
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NO);
	Tue, 28 Jun 2005 16:25:28 -0700 (PDT)
In-Reply-To: <4846.10.10.10.24.1119999568.squirrel@linux1>
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

On Jun 28, 2005, at 18:59:28, Sean wrote:
> By the sounds of it, git could just use Mecurial or some variation  
> thereof
> as a back end.

Umm, you seem to miss the point, sir.  If you use Mercurial, there is no
reason you should layer any part of Git on top of it.  It already does
everything that git does anyways.

> Git is already so much better for the things I do than BK ever was,  
> I'll
> stick with it.

This is like saying "Windows 3.1 is already so much better for the  
things
I do than DOS ever was, I'll stick with it."  :-D

Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/U d- s++: a18 C++++>$ UB/L/X/*++++(+)>$ P+++(++++)>$
L++++(+++) E W++(+) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+
PGP+++ t+(+++) 5 X R? tv-(--) b++++(++) DI+ D+ G e->++++$ h!*()>++$  
r  !y?(-)
------END GEEK CODE BLOCK------
