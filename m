From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Introduce git version --list-features for porcelain use
Date: Thu, 31 May 2007 09:30:11 -0400
Message-ID: <20070531133011.GW7044@spearce.org>
References: <Pine.LNX.4.64.0705301333410.4011@racer.site> <20070531002030.GA15714@spearce.org> <81b0412b0705302350i3ebf48e8h24537c20a413e709@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 31 15:30:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HtkjO-0004Vl-Qg
	for gcvg-git@gmane.org; Thu, 31 May 2007 15:30:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750853AbXEaNaT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 31 May 2007 09:30:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751082AbXEaNaT
	(ORCPT <rfc822;git-outgoing>); Thu, 31 May 2007 09:30:19 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:33408 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750853AbXEaNaR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 May 2007 09:30:17 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HtkjB-0008Gz-2s; Thu, 31 May 2007 09:30:09 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 1376020FBAE; Thu, 31 May 2007 09:30:12 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <81b0412b0705302350i3ebf48e8h24537c20a413e709@mail.gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48810>

Alex Riesen <raa.lkml@gmail.com> wrote:
> On 5/31/07, Shawn O. Pearce <spearce@spearce.org> wrote:
> >Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> >>
> >> On Wed, 30 May 2007, Alex Riesen wrote:
> >>
> >> > git-version --features?
> >>
> >> Melikes.
> >
> >Good?
> >
> 
> Was just a suggestion. Good.

Well, a quick poll on IRC seemed to get like 5 additional votes for
this being a switch on git-version.  That sealed the deal.  I wasn't
committed one way or the other.  I just wanted the functionality...

Also votes from you and Dscho carry a little weight around here.  :-)

-- 
Shawn.
