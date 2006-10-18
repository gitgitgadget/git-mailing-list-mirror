From: Sean <seanlkml@sympatico.ca>
Subject: Re: VCS comparison table
Date: Wed, 18 Oct 2006 17:29:45 -0400
Message-ID: <BAYC1-PASMTP069C473B2E79389E5BFC92AE0F0@CEZ.ICE>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
	<45349162.90001@op5.se>
	<453536AE.6060601@utoronto.ca>
	<200610172301.27101.jnareb@gmail.com>
	<45354AD0.1020107@utoronto.ca>
	<BAYC1-PASMTP07AB11A64250AAF683424DAE0E0@CEZ.ICE>
	<45355CBB.80108@utoronto.ca>
	<BAYC1-PASMTP01369CD694D75CB61ACCC7AE0E0@CEZ.ICE>
	<eh64tk$rug$2@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, bazaar-ng@lists.canonical.com
X-From: git-owner@vger.kernel.org Wed Oct 18 23:29:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GaIz2-0008Ej-MY
	for gcvg-git@gmane.org; Wed, 18 Oct 2006 23:29:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422988AbWJRV3t (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Oct 2006 17:29:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422995AbWJRV3t
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Oct 2006 17:29:49 -0400
Received: from bayc1-pasmtp06.bayc1.hotmail.com ([65.54.191.166]:35296 "EHLO
	BAYC1-PASMTP06.bayc1.hotmail.com") by vger.kernel.org with ESMTP
	id S1422988AbWJRV3s (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Oct 2006 17:29:48 -0400
X-Originating-IP: [65.93.43.81]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([65.93.43.81]) by BAYC1-PASMTP06.bayc1.hotmail.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Wed, 18 Oct 2006 14:32:57 -0700
Received: from guru.attic.local ([10.10.10.28])
	by linux1.attic.local with esmtp (Exim 4.43)
	id 1GaI2s-0002gW-1h; Wed, 18 Oct 2006 16:29:46 -0400
To: Charles Duffy <cduffy@spamcop.net>
Message-Id: <20061018172945.c0c58c38.seanlkml@sympatico.ca>
In-Reply-To: <eh64tk$rug$2@sea.gmane.org>
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.10.4; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 18 Oct 2006 21:32:57.0546 (UTC) FILETIME=[FA86DAA0:01C6F2FC]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

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
