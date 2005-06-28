From: Petr Baudis <pasky@ucw.cz>
Subject: Re: Mercurial vs Updated git HOWTO for kernel hackers
Date: Tue, 28 Jun 2005 17:34:50 +0200
Message-ID: <20050628153450.GE1275@pasky.ji.cz>
References: <42B9E536.60704@pobox.com> <20050623235634.GC14426@waste.org>
	<20050624064101.GB14292@pasky.ji.cz>
	<20050624130604.GK17715@g5.random>
	<42BC112C.1040009@qualitycode.com>
	<20050628150752.GC1275@pasky.ji.cz>
	<20050628151522.GO5992MdfPADPa@garage.linux.student.kuleuven.ac.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: mercurial-bounces@selenic.com Tue Jun 28 17:28:53 2005
Return-path: <mercurial-bounces@selenic.com>
Received: from waste.org ([216.27.176.166])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DnI0g-0003iz-T3
	for gcvmd-mercurial@gmane.org; Tue, 28 Jun 2005 17:28:27 +0200
Received: from waste.org (localhost [127.0.0.1])
	by waste.org (8.13.4/8.13.4/Debian-3) with ESMTP id j5SFYt3P028178;
	Tue, 28 Jun 2005 10:34:55 -0500
Received: from machine.sinus.cz (qmailr@w241.dkm.cz [62.24.88.241])
	by waste.org (8.13.4/8.13.4/Debian-3) with SMTP id j5SFYpbn028171
	for <mercurial@selenic.com>; Tue, 28 Jun 2005 10:34:52 -0500
Received: (qmail 5867 invoked by uid 2001); 28 Jun 2005 15:34:50 -0000
To: Kevin Smith <yarcs@qualitycode.com>,
        Git Mailing List <git@vger.kernel.org>, mercurial@selenic.com
Content-Disposition: inline
In-Reply-To: <20050628151522.GO5992MdfPADPa@garage.linux.student.kuleuven.ac.be>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
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

Dear diary, on Tue, Jun 28, 2005 at 05:15:22PM CEST, I got a letter
where Sven Verdoolaege <skimo@kotnet.org> told me that...
> On Tue, Jun 28, 2005 at 05:07:52PM +0200, Petr Baudis wrote:
> > Dear diary, on Fri, Jun 24, 2005 at 03:57:00PM CEST, I got a letter
> > where Kevin Smith <yarcs@qualitycode.com> told me that...
> > > - Can run on (native) MS Windows
> > >   (necessary for me because I often work on cross-platform projects)
> > 
> > I'd expect everything to work fine with Cygwin (or with only minor
> > problems easy to fix) or just any working bash + GNU coreutils
> > installation. Any issue with that?
> 
> The code is full of Unixisms.  You'd almost think that the authors
> of git have some kind of affinity towards Unix.

Ah. Well, I was speaking just of Cogito and didn't realize you might
want git too so that you can actually do anything with Cogito then. ;-)

> read-cache.c:376: warning: implicit declaration of function `mmap'

Well, I'm actually not very clueful about MS Windows environment, but
doesn't it provide any POSIX API? You might have more luck with that.
Or I guess it should work on Cygwin.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
<Espy> be careful, some twit might quote you out of context..
