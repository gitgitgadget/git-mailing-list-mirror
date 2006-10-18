From: Sean <seanlkml@sympatico.ca>
Subject: Re: [ANNOUNCE] Example Cogito Addon - cogito-bundle
Date: Wed, 18 Oct 2006 17:54:43 -0400
Message-ID: <BAYC1-PASMTP11CB0FFA29B2098DFE92FEAE0F0@CEZ.ICE>
References: <200610172351.17377.jnareb@gmail.com>
	<4535590C.4000004@utoronto.ca>
	<200610180057.25411.jnareb@gmail.com>
	<Pine.LNX.4.64.0610171610270.3962@g5.osdl.org>
	<20061018053647.GA3507@coredump.intra.peff.net>
	<Pine.LNX.4.64.0610180739230.3962@g5.osdl.org>
	<20061018185225.GU20017@pasky.or.cz>
	<20061018155704.b94b441d.seanlkml@sympatico.ca>
	<20061018204618.GW20017@pasky.or.cz>
	<20061018165341.bcece11f.seanlkml@sympatico.ca>
	<20061018213935.GX20017@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 18 23:54:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GaJNB-0004iI-LY
	for gcvg-git@gmane.org; Wed, 18 Oct 2006 23:54:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423040AbWJRVyq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Oct 2006 17:54:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423047AbWJRVyq
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Oct 2006 17:54:46 -0400
Received: from bayc1-pasmtp11.bayc1.hotmail.com ([65.54.191.171]:17872 "EHLO
	BAYC1-PASMTP11.CEZ.ICE") by vger.kernel.org with ESMTP
	id S1423040AbWJRVyp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Oct 2006 17:54:45 -0400
X-Originating-IP: [65.93.43.81]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([65.93.43.81]) by BAYC1-PASMTP11.CEZ.ICE over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Wed, 18 Oct 2006 15:03:30 -0700
Received: from guru.attic.local ([10.10.10.28])
	by linux1.attic.local with esmtp (Exim 4.43)
	id 1GaIR1-0002my-N3; Wed, 18 Oct 2006 16:54:43 -0400
To: Petr Baudis <pasky@suse.cz>
Message-Id: <20061018175443.50b728f6.seanlkml@sympatico.ca>
In-Reply-To: <20061018213935.GX20017@pasky.or.cz>
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.10.4; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 18 Oct 2006 22:03:30.0906 (UTC) FILETIME=[3F4B63A0:01C6F301]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, 18 Oct 2006 23:39:35 +0200
Petr Baudis <pasky@suse.cz> wrote:

> You can use just this single tool from Cogito. ;-)

I'd rather not have to keep two separate tools up to date, i just want
to install Git and have all these features installed.  Especially since
there is so much overlap in what these two packages do.  That would seem
like the best thing to do for most users in fact, asking them to install
and keep both up to date just doesn't make sense, to me at least.

> The point is, I'll of course prefer doing this stuff in Cogito while I'm
> enhancing Cogito, and I'll work on Cogito while I and others will be
> using it. I didn't move on to pure Git long time ago since I simply
> consider its UI much inferior to Cogito's. Sure, given enough time and
> work, it is fixable - but UI flaws are very hard to fix and I find it
> more effective to work on Cogito for the time being, at least until I
> bring it to 1.0, then I'll see.
> 
> Besides, I'm used to Cogito. :-)
> 
> So yes, current Git code definitely is a part of the reason, but it is
> certainly not the main part of it.

It's just a shame that your talents are split off from helping the main
project more.  Git would be further along today in content and PR if it
had managed to attract you back from your Cogito adventure.  Then all
the nice things you're able to say about Cogito might then be said
about Git proper, and maybe we'd attract even more users.

While you've contributed more to Git than many others (including me
obviously), it would sure be nice to see you back full time on Git.
I want to type "git bundle" without having to install more
software damnit ;o)  But of course you have to decide what's best
for yourself.

Sean
