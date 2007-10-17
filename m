From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 2/3] git-cvsexportcommit.perl tmpdir removed
Date: Tue, 16 Oct 2007 22:25:27 -0400
Message-ID: <20071017022527.GQ13801@spearce.org>
References: <1192522094-4988-1-git-send-email-mfwitten@mit.edu> <1192522094-4988-2-git-send-email-mfwitten@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Michael Witten <mfwitten@mit.edu>
X-From: git-owner@vger.kernel.org Wed Oct 17 04:25:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhybP-0008M5-AU
	for gcvg-git-2@gmane.org; Wed, 17 Oct 2007 04:25:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756691AbXJQCZc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 22:25:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761232AbXJQCZb
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 22:25:31 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:52115 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755636AbXJQCZb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 22:25:31 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1Ihyaz-0006vw-B4; Tue, 16 Oct 2007 22:25:17 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id A47B620FBC9; Tue, 16 Oct 2007 22:25:27 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <1192522094-4988-2-git-send-email-mfwitten@mit.edu>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61318>

Michael Witten <mfwitten@mit.edu> wrote:
> Signed-off-by: Michael Witten <mfwitten@mit.edu>
> ---
>     This is perhaps a duplicate of another patch sent in,
>     but it applies to the tabified version.

Yea, I don't know if you know this but I do already have this in my
master branch.  Same change but it came from Johannes Schindelin.
I just happened to come across his patch first in my inbox last
night when I was processing through what I could.
     
-- 
Shawn.
