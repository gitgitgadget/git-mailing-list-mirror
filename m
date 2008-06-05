From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH] Keep committer and committer dates
Date: Thu, 5 Jun 2008 15:38:44 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0806051528220.1798@tm8103-a.perex-int.cz>
References: <Pine.LNX.4.61.0806031647320.1798@tm8103-a.perex-int.cz>
 <alpine.DEB.1.00.0806032115340.13507@racer.site.net>
 <Pine.LNX.4.61.0806041113520.1798@tm8103-a.perex-int.cz>
 <20080604102906.GA2126@diana.vm.bytemark.co.uk> <m3ej7dzc7y.fsf@localhost.localdomain>
 <Pine.LNX.4.61.0806041424140.1798@tm8103-a.perex-int.cz>
 <alpine.DEB.1.00.0806041641150.13507@racer.site.net> <20080605010330.GB24466@leksak.fem-net>
 <alpine.DEB.1.00.0806050523120.21190@racer> <4847917A.2050700@viscovery.net>
 <Pine.LNX.4.61.0806051428390.1798@tm8103-a.perex-int.cz>
 <alpine.DEB.1.00.0806051408520.21190@racer>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Stephan Beyer <s-beyer@gmx.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jun 05 15:39:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4Fgw-0008VK-T1
	for gcvg-git-2@gmane.org; Thu, 05 Jun 2008 15:39:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754391AbYFENis (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2008 09:38:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754495AbYFENis
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jun 2008 09:38:48 -0400
Received: from mail1.perex.cz ([212.20.107.53]:59851 "EHLO mail1.perex.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754323AbYFENir (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2008 09:38:47 -0400
Received: from server.perex.cz (server.perex.cz [172.16.0.20])
	by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 92E38149D8C;
	Thu,  5 Jun 2008 15:38:46 +0200 (CEST)
Received: from tm8103.perex-int.cz (localhost [127.0.0.1])
	by server.perex.cz (Perex's E-mail Delivery System) with ESMTP id 770DB84355;
	Thu,  5 Jun 2008 15:38:46 +0200 (CEST)
Received: by tm8103.perex-int.cz (Postfix, from userid 1000)
	id 3E2AA57FEC; Thu,  5 Jun 2008 15:38:44 +0200 (CEST)
X-X-Sender: perex@tm8103-a.perex-int.cz
In-Reply-To: <alpine.DEB.1.00.0806051408520.21190@racer>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83932>

On Thu, 5 Jun 2008, Johannes Schindelin wrote:

> It would make a wonderfully helpful tool less helpful.

I don't agree. Tool is tool. Every tool can be used in a wrong way.
A notice to documentation that some of functionality should be used very 
carefully should be enough.

> > Also, having a possibility to easy remove a changeset (hardly - not 
> > revert) without touching all other changesets on top is a function worth 
> > to include.
> 
> The problem there is that you -- again -- lie about the committers.  They 
> _never_ saw, approved, or tested those commits.

If I changed portion of unpublished tree, as maintainer I can combine any 
patches and it might make sense to keep at least my commit dates for my 
reference.

					Thanks,
						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
