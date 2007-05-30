From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Makefile: Use generic rule to build test programs
Date: Wed, 30 May 2007 19:27:33 -0400
Message-ID: <20070530232733.GS7044@spearce.org>
References: <20070530232206.25366.89397.julian@quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Thu May 31 01:27:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HtXa1-0001DU-CC
	for gcvg-git@gmane.org; Thu, 31 May 2007 01:27:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751130AbXE3X1j (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 30 May 2007 19:27:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751806AbXE3X1j
	(ORCPT <rfc822;git-outgoing>); Wed, 30 May 2007 19:27:39 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:44097 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751130AbXE3X1i (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 May 2007 19:27:38 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HtXZd-0001oT-F2; Wed, 30 May 2007 19:27:25 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id B84AF20FBAE; Wed, 30 May 2007 19:27:33 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20070530232206.25366.89397.julian@quantumfyre.co.uk>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48788>

Julian Phillips <julian@quantumfyre.co.uk> wrote:
> Use a generic make rule to build all the test programs, rather than
> specifically mentioning each one.
> 
> Signed-off-by: Julian Phillips <julian@quantumfyre.co.uk>

Yes.  ;-)

I was going to do this tonight.  Thank you for beating me to it!

-- 
Shawn.
