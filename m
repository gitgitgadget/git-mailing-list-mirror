From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] add --remote option to git-clone.
Date: Thu, 1 Feb 2007 18:31:09 -0500
Message-ID: <20070201233109.GA19446@spearce.org>
References: <20070201220122.GF17617@mellanox.co.il> <Pine.LNX.4.63.0702020028540.18776@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Michael S. Tsirkin" <mst@mellanox.co.il>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Feb 02 00:31:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HClOg-0001fT-NQ
	for gcvg-git@gmane.org; Fri, 02 Feb 2007 00:31:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422893AbXBAXbQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Feb 2007 18:31:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422894AbXBAXbQ
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Feb 2007 18:31:16 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:51887 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422893AbXBAXbP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Feb 2007 18:31:15 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HClOQ-0002Oy-CF; Thu, 01 Feb 2007 18:31:02 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id EC5E020FBAE; Thu,  1 Feb 2007 18:31:09 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0702020028540.18776@wbgn013.biozentrum.uni-wuerzburg.de>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38430>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> would this option not be better named "--branch"? Of course, you'd have to 
> support this, too:
> 
> 	$ git clone --branch topic1 --branch topic2 git://...

Yes, --branch sounds better here.

-- 
Shawn.
