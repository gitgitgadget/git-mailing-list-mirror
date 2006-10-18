From: Sean <seanlkml@sympatico.ca>
Subject: Re: VCS comparison table
Date: Wed, 18 Oct 2006 17:29:45 -0400
Message-ID: <20061018172945.c0c58c38.seanlkml__5735.08153106577$1161333739$gmane$org@sympatico.ca>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
	<45349162.90001@op5.se> <453536AE.6060601@utoronto.ca>
	<200610172301.27101.jnareb@gmail.com>
	<45354AD0.1020107@utoronto.ca>
	<BAYC1-PASMTP07AB11A64250AAF683424DAE0E0@CEZ.ICE>
	<45355CBB.80108@utoronto.ca>
	<BAYC1-PASMTP01369CD694D75CB61ACCC7AE0E0@CEZ.ICE>
	<eh64tk$rug$2@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: bazaar-ng@lists.canonical.com, git@vger.kernel.org
X-From: bazaar-ng-bounces@lists.canonical.com Fri Oct 20 10:42:15 2006
Return-path: <bazaar-ng-bounces@lists.canonical.com>
Envelope-to: gcvbg-bazaar-ng@m.gmane.org
Received: from esperanza.ubuntu.com ([82.211.81.173])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gapx7-0000tF-Hu
	for gcvbg-bazaar-ng@m.gmane.org; Fri, 20 Oct 2006 10:42:05 +0200
Received: from localhost ([127.0.0.1] helo=esperanza.ubuntu.com)
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <bazaar-ng-bounces@lists.canonical.com>)
	id 1GapNW-0007lu-Gr; Fri, 20 Oct 2006 09:05:18 +0100
Received: from bayc1-pasmtp06.bayc1.hotmail.com ([65.54.191.166])
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <seanlkml@sympatico.ca>) id 1GaIyy-0004oW-QN
	for bazaar-ng@lists.canonical.com; Wed, 18 Oct 2006 22:29:49 +0100
X-Originating-IP: [65.93.43.81]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([65.93.43.81]) by
	BAYC1-PASMTP06.bayc1.hotmail.com over TLS secured channel with
	Microsoft SMTPSVC(6.0.3790.1830); Wed, 18 Oct 2006 14:32:57 -0700
Received: from guru.attic.local ([10.10.10.28])
	by linux1.attic.local with esmtp (Exim 4.43)
	id 1GaI2s-0002gW-1h; Wed, 18 Oct 2006 16:29:46 -0400
To: Charles Duffy <cduffy@spamcop.net>
Message-Id: <20061018172945.c0c58c38.seanlkml@sympatico.ca>
In-Reply-To: <eh64tk$rug$2@sea.gmane.org>
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.10.4; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 18 Oct 2006 21:32:57.0546 (UTC)
	FILETIME=[FA86DAA0:01C6F2FC]
X-Mailman-Approved-At: Fri, 20 Oct 2006 09:04:05 +0100
X-BeenThere: bazaar-ng@lists.canonical.com
X-Mailman-Version: 2.1.8
Precedence: list
List-Id: bazaar-ng discussion <bazaar-ng.lists.canonical.com>
List-Unsubscribe: <https://lists.ubuntu.com/mailman/listinfo/bazaar-ng>,
	<mailto:bazaar-ng-request@lists.canonical.com?subject=unsubscribe>
List-Archive: <https://lists.ubuntu.com/archives/bazaar-ng>
List-Post: <mailto:bazaar-ng@lists.canonical.com>
List-Help: <mailto:bazaar-ng-request@lists.canonical.com?subject=help>
List-Subscribe: <https://lists.ubuntu.com/mailman/listinfo/bazaar-ng>,
	<mailto:bazaar-ng-request@lists.canonical.com?subject=subscribe>
Sender: bazaar-ng-bounces@lists.canonical.com
Errors-To: bazaar-ng-bounces@lists.canonical.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29420>

On Wed, 18 Oct 2006 16:04:52 -0500
Charles Duffy <cduffy@spamcop.net> wrote:

> Example time!
> 
> There's a plugin for Bzr which adds support for Cygwin-compatible 
> symlink support on Windows. (IIRC, this involves monkey-patching some of 
> the Python standard library bits).
> 
> Now, this is something which is *proposed* as a feature to be merged 
> into upstream bzr, and it may happen at some point. That said, when I 
> have a Windows-using coworker who wants to check out a repository that 
> has symlinks in it (with his win32-native, no-cygwin-required bzr 
> upstream binary), I don't need to tell him to go download and build bzr 
> from a third party; instead, I just need to tell him to run a single 
> command to check out the plugin in question into the bzr plugins folder.
> 
>  From an end-user convenience perspective, it's a pretty significant win.

You'll need a better example than that.  Git has supported a version
of Cygwin-compatible symlink support on Windows for quite some time.
And no plugins were needed.

Sean
