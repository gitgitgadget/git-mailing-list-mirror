From: "Sean" <seanlkml@sympatico.ca>
Subject: Re: Mercurial vs Updated git HOWTO for kernel hackers
Date: Tue, 28 Jun 2005 18:59:28 -0400 (EDT)
Message-ID: <4846.10.10.10.24.1119999568.squirrel@linux1>
References: <42B9E536.60704@pobox.com> <20050623235634.GC14426@waste.org>
	<20050624064101.GB14292@pasky.ji.cz>
	<20050624123819.GD9519@64m.dyndns.org>
	<20050628150027.GB1275@pasky.ji.cz> <20050628180157.GI12006@waste.org>
	<62CF578B-B9DF-4DEA-8BAD-041F357771FD@mac.com>
	<3886.10.10.10.24.1119991512.squirrel@linux1>
	<20050628221422.GT12006@waste.org>
	<3993.10.10.10.24.1119997389.squirrel@linux1>
	<20050628224946.GU12006@waste.org>
Mime-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Cc: mercurial@selenic.com, Petr Baudis <pasky@ucw.cz>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Kyle Moffett <mrmacman_g4@mac.com>, Jeff Garzik <jgarzik@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
X-From: mercurial-bounces@selenic.com Wed Jun 29 00:53:01 2005
Return-path: <mercurial-bounces@selenic.com>
Received: from waste.org ([216.27.176.166])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DnOwf-0004HJ-AR
	for gcvmd-mercurial@gmane.org; Wed, 29 Jun 2005 00:52:45 +0200
Received: from waste.org (localhost [127.0.0.1])
	by waste.org (8.13.4/8.13.4/Debian-3) with ESMTP id j5SMxiqV023281;
	Tue, 28 Jun 2005 17:59:44 -0500
Received: from simmts6-srv.bellnexxia.net (simmts6.bellnexxia.net
	[206.47.199.164])
	by waste.org (8.13.4/8.13.4/Debian-3) with ESMTP id j5SMxdFu023261;
	Tue, 28 Jun 2005 17:59:40 -0500
Received: from linux1 ([69.156.137.160]) by simmts6-srv.bellnexxia.net
	(InterMail vM.5.01.06.10 201-253-122-130-110-20040306) with ESMTP
	id <20050628225928.MQTA11463.simmts6-srv.bellnexxia.net@linux1>;
	Tue, 28 Jun 2005 18:59:28 -0400
Received: from linux1 (linux1.attic.local [127.0.0.1])
	by linux1 (8.12.11/8.12.11) with ESMTP id j5SMxQs4017265;
	Tue, 28 Jun 2005 18:59:27 -0400
Received: from 10.10.10.24 (SquirrelMail authenticated user sean)
	by linux1 with HTTP; Tue, 28 Jun 2005 18:59:28 -0400 (EDT)
In-Reply-To: <20050628224946.GU12006@waste.org>
To: "Matt Mackall" <mpm@selenic.com>
User-Agent: SquirrelMail/1.4.4-2
X-Priority: 3 (Normal)
Importance: Normal
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

On Tue, June 28, 2005 6:49 pm, Matt Mackall said:

> Again, have fun with that. Mercurial already went down this path a
> month ago, discovered it couldn't reasonably be fixed without
> abandoning the hashes as file name scheme, and changed repo layout.
>
> Git's going to have a much harder time as it's pretty solidly tied to
> lookup by contents hash. If you throw that out, you might as well use
> Mercurial.
>

By the sounds of it, git could just use Mecurial or some variation thereof
as a back end.  Git is not tied to it's back end.   Afterall, Mecurial
just took the basic ideas from Linus' and adapted them to a different back
end.  But there are very few situation where Git performance is a
practical problem, and where it is things are being addressed.   Git is
already so much better for the things I do than BK ever was, I'll stick
with it.

Sean.
