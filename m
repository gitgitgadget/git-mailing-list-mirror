From: "Sean" <seanlkml@sympatico.ca>
Subject: Re: Mercurial vs Updated git HOWTO for kernel hackers
Date: Tue, 28 Jun 2005 19:37:36 -0400 (EDT)
Message-ID: <1765.10.10.10.24.1120001856.squirrel@linux1>
References: <42B9E536.60704@pobox.com> <20050623235634.GC14426@waste.org>
	<20050624064101.GB14292@pasky.ji.cz>
	<20050624123819.GD9519@64m.dyndns.org>
	<20050628150027.GB1275@pasky.ji.cz> <20050628180157.GI12006@waste.org>
	<62CF578B-B9DF-4DEA-8BAD-041F357771FD@mac.com>
	<3886.10.10.10.24.1119991512.squirrel@linux1>
	<20050628221422.GT12006@waste.org>
	<3993.10.10.10.24.1119997389.squirrel@linux1>
	<20050628224946.GU12006@waste.org>
	<4846.10.10.10.24.1119999568.squirrel@linux1>
	<40A9C7C2-1AFE-45BC-90A5-571628304479@mac.com>
Mime-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Cc: mercurial@selenic.com, Petr Baudis <pasky@ucw.cz>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Jeff Garzik <jgarzik@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
X-From: mercurial-bounces@selenic.com Wed Jun 29 01:31:13 2005
Return-path: <mercurial-bounces@selenic.com>
Received: from waste.org ([216.27.176.166])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DnPXY-0000vM-Gd
	for gcvmd-mercurial@gmane.org; Wed, 29 Jun 2005 01:30:52 +0200
Received: from waste.org (localhost [127.0.0.1])
	by waste.org (8.13.4/8.13.4/Debian-3) with ESMTP id j5SNbpvf029407;
	Tue, 28 Jun 2005 18:37:54 -0500
Received: from simmts12-srv.bellnexxia.net (simmts12.bellnexxia.net
	[206.47.199.141])
	by waste.org (8.13.4/8.13.4/Debian-3) with ESMTP id j5SNbgEj029381;
	Tue, 28 Jun 2005 18:37:42 -0500
Received: from linux1 ([69.156.137.160]) by simmts12-srv.bellnexxia.net
	(InterMail vM.5.01.06.10 201-253-122-130-110-20040306) with ESMTP
	id <20050628233736.JHAJ1005.simmts12-srv.bellnexxia.net@linux1>;
	Tue, 28 Jun 2005 19:37:36 -0400
Received: from linux1 (linux1.attic.local [127.0.0.1])
	by linux1 (8.12.11/8.12.11) with ESMTP id j5SNbZX4018286;
	Tue, 28 Jun 2005 19:37:35 -0400
Received: from 10.10.10.24 (SquirrelMail authenticated user sean)
	by linux1 with HTTP; Tue, 28 Jun 2005 19:37:36 -0400 (EDT)
In-Reply-To: <40A9C7C2-1AFE-45BC-90A5-571628304479@mac.com>
To: "Kyle Moffett" <mrmacman_g4@mac.com>
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

On Tue, June 28, 2005 7:25 pm, Kyle Moffett said:
> On Jun 28, 2005, at 18:59:28, Sean wrote:
>> By the sounds of it, git could just use Mecurial or some variation
>> thereof
>> as a back end.
>
> Umm, you seem to miss the point, sir.  If you use Mercurial, there is no
> reason you should layer any part of Git on top of it.  It already does
> everything that git does anyways.

No, you seem to miss the point.  Git already does everything Mercurial
does, and does it pretty well too.  The _point_ was that if the big
"feature" of Mercurial is it's on disk format, Git is perfectly capable of
copying it at any point.   The on disk format just ISN'T CLOSE TO BEING
THE MOST IMPORTANT THING AT THE MOMENT.

>
>> Git is already so much better for the things I do than BK ever was,
>> I'll
>> stick with it.
>
> This is like saying "Windows 3.1 is already so much better for the
> things
> I do than DOS ever was, I'll stick with it."  :-D

Yes, so what's your point?  Mercurial is trying to solve a problem that is
already perfectly well handled for me by Git.   Therefore I have _zero_
motivation to direct my efforts elsewhere.

Cheers,
Sean
