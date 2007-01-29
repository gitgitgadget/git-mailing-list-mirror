From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [EGIT PATCH 2/2] Show 'StGit/Git' as project decoration
Date: Mon, 29 Jan 2007 01:30:35 -0500
Message-ID: <20070129063035.GB4634@spearce.org>
References: <20070127235718.26097.74542.stgit@lathund.dewire.com> <20070127235724.26097.38563.stgit@lathund.dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Mon Jan 29 07:30:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HBQ2N-0007Ha-HS
	for gcvg-git@gmane.org; Mon, 29 Jan 2007 07:30:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933231AbXA2Gak (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 Jan 2007 01:30:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933238AbXA2Gak
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Jan 2007 01:30:40 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:54490 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933231AbXA2Gaj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jan 2007 01:30:39 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HBQ1b-0007or-OC; Mon, 29 Jan 2007 01:29:55 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 9EC4520FBAE; Mon, 29 Jan 2007 01:30:35 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20070127235724.26097.38563.stgit@lathund.dewire.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38064>

Robin Rosenberg <robin.rosenberg@dewire.com> wrote:
> Git is spelled like this as is StGit. Since we have some support for 
> Stacked Git in the quickdiff code, we should also tell the user if we
> are in StGit mode or plain Git mode.

Thanks; both have been applied and pushed.

I *really* need to stop hacking on git-gui and work on egit again...

-- 
Shawn.
