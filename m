From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 0/9] Bisect skip
Date: Mon, 22 Oct 2007 02:02:19 -0400
Message-ID: <20071022060219.GQ14735@spearce.org>
References: <200710220747.28731.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio Hamano <junkio@cox.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Mon Oct 22 08:02:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IjqN3-0002k7-Si
	for gcvg-git-2@gmane.org; Mon, 22 Oct 2007 08:02:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751517AbXJVGC0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Oct 2007 02:02:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751344AbXJVGC0
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Oct 2007 02:02:26 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:46873 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751188AbXJVGCZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Oct 2007 02:02:25 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IjqMn-0001Sp-4Q; Mon, 22 Oct 2007 02:02:21 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id B055820FBAE; Mon, 22 Oct 2007 02:02:19 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <200710220747.28731.chriscool@tuxfamily.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61950>

Christian Couder <chriscool@tuxfamily.org> wrote:
> Here is the "bisect skip" patch series.
> It's just a rename from "dunno" to "skip" compared to the previous "dunno" 
> patch series that was in Shawn's pu branch.
> 
> In fact there is no change in the first 3 patches and trivial changes in the 
> other patches.

Thanks.  I'm reparking this new version in pu tonight.  It is too
late in the morning here for me to go through this any further than
applying and merging.  I'm almost done looking through and testing
the new option parser series and then will be looking at this one
next; probably Tuesday.

-- 
Shawn.
