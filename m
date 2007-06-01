From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Make the installation target of git-gui a little less chatty
Date: Thu, 31 May 2007 23:02:57 -0400
Message-ID: <20070601030257.GX7044@spearce.org>
References: <20070531222527.GB12204@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 01 05:03:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HtxQ5-0005y8-Rx
	for gcvg-git@gmane.org; Fri, 01 Jun 2007 05:03:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751397AbXFADDH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 31 May 2007 23:03:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752018AbXFADDH
	(ORCPT <rfc822;git-outgoing>); Thu, 31 May 2007 23:03:07 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:56140 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751397AbXFADDG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 May 2007 23:03:06 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HtxPe-00019o-5E; Thu, 31 May 2007 23:02:50 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 638FF20FBAE; Thu, 31 May 2007 23:02:58 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20070531222527.GB12204@steel.home>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48838>

Alex Riesen <raa.lkml@gmail.com> wrote:
> Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
> ---

I have the exact same reaction as Junio had to the same change in
git.git...  I'll apply it if you resend according to his guidelines.
 
> The patch is hand-tuned to start in git-gui, so that it can be applied
> in git-gui repo.

Hand-tuning the patch isn't necessary, just making the change its
own patch is all that is required.  Git has these nifty flags for
git-am like -p2 and -3 that make editing filenames in the patch
completely unnecessary.  ;-)

-- 
Shawn.
