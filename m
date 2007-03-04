From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Conflict editing
Date: Sun, 4 Mar 2007 18:40:30 -0500
Message-ID: <20070304234030.GA20116@spearce.org>
References: <Pine.LNX.4.63.0703041339350.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Mar 05 00:40:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HO0Jk-0005sq-44
	for gcvg-git@gmane.org; Mon, 05 Mar 2007 00:40:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752533AbXCDXkf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Mar 2007 18:40:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752518AbXCDXkf
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Mar 2007 18:40:35 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:50772 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752177AbXCDXke (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Mar 2007 18:40:34 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HO0JS-0000G5-Go; Sun, 04 Mar 2007 18:40:22 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 8DCFF20FBAE; Sun,  4 Mar 2007 18:40:30 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0703041339350.22628@wbgn013.biozentrum.uni-wuerzburg.de>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41389>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> I often end up with conflicts, and I just want to edit the conflicting 
> files, one after another. To make this easier, I wrote a script (yes, no 
> builtin) to start the editor with the files having conflicts.
> 
> -- snipsnap --
> #!/bin/sh
> #
> # Copyright (c) 2006, Shawn O. Pearce

Sweet!  My evil plan is working...  you do all of the work and I
get all of the credit!  Last year to boot!  ;-)


Yes, I did see the other message about how you copied the preamble
from git-gc.sh...  ;-)

-- 
Shawn.
