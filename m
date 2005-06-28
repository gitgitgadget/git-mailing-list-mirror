From: Kevin Smith <yarcs@qualitycode.com>
Subject: Cygwin and Native MS Windows (was: Mercurial vs Updated git HOWTO
 for kernel hackers)
Date: Tue, 28 Jun 2005 12:50:04 -0400
Message-ID: <42C17FBC.7030509@qualitycode.com>
References: <42B9E536.60704@pobox.com> <20050623235634.GC14426@waste.org>
	<20050624064101.GB14292@pasky.ji.cz>
	<20050624130604.GK17715@g5.random>
	<42BC112C.1040009@qualitycode.com>
	<20050628150752.GC1275@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: mercurial@selenic.com, Git Mailing List <git@vger.kernel.org>
X-From: mercurial-bounces@selenic.com Tue Jun 28 18:46:09 2005
Return-path: <mercurial-bounces@selenic.com>
Received: from waste.org ([216.27.176.166])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DnJCw-0000kk-2z
	for gcvmd-mercurial@gmane.org; Tue, 28 Jun 2005 18:45:10 +0200
Received: from waste.org (localhost [127.0.0.1])
	by waste.org (8.13.4/8.13.4/Debian-3) with ESMTP id j5SGplH3007181;
	Tue, 28 Jun 2005 11:51:50 -0500
Received: from vulcan.rootr.net (deuterium.rootr.net [203.194.209.160])
	by waste.org (8.13.4/8.13.4/Debian-3) with ESMTP id j5SGpfBR007157
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <mercurial@selenic.com>; Tue, 28 Jun 2005 11:51:44 -0500
Received: from [192.168.15.101] (653221hfc195.tampabay.res.rr.com
	[65.32.21.195])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by vulcan.rootr.net (Postfix) with ESMTP id 0E62B3C11;
	Tue, 28 Jun 2005 16:51:35 +0000 (UTC)
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050404)
X-Accept-Language: en-us, en
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050628150752.GC1275@pasky.ji.cz>
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

Petr Baudis wrote:
 > Dear diary, on Fri, Jun 24, 2005 at 03:57:00PM CEST, I got a letter
 > where Kevin Smith <yarcs@qualitycode.com> told me that...
 >
 >>- Can run on (native) MS Windows
 >>  (necessary for me because I often work on cross-platform projects)
 >
 >
 > I'd expect everything to work fine with Cygwin (or with only minor
 > problems easy to fix) or just any working bash + GNU coreutils
 > installation. Any issue with that?

I don't see cygwin as being a reasonable option for a core tool like 
SCM. Cygwin is too large and invasive to expect Windows users to install 
and use it. For my own projects, native Windows operation is a requirement.

Kevin
