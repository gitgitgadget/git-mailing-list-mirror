From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Bisect: fix a removed variable that is still used.
Date: Thu, 18 Oct 2007 01:13:41 -0400
Message-ID: <20071018051341.GF14735@spearce.org>
References: <20071018005256.280dfaab.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio Hamano <junkio@cox.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Thu Oct 18 07:14:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IiNhn-0002jK-7o
	for gcvg-git-2@gmane.org; Thu, 18 Oct 2007 07:13:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753334AbXJRFNs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2007 01:13:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753150AbXJRFNs
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Oct 2007 01:13:48 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:51190 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751916AbXJRFNr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2007 01:13:47 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IiNhT-0006C9-Bt; Thu, 18 Oct 2007 01:13:39 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 8896420FBAE; Thu, 18 Oct 2007 01:13:41 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20071018005256.280dfaab.chriscool@tuxfamily.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61477>

Christian Couder <chriscool@tuxfamily.org> wrote:
> 	This is fix for something I forgot in the patch named:
> 
> 	[PATCH 6/7] Bisect: factorise "bisect_{bad,good,dunno}" 
> 	into "bisect_state".
> 
> 	I can send an updated version of the above patch if
> 	needed.

Thanks.  Squashed into 6/7.
 
-- 
Shawn.
