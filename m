From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Add a compat/strtoumax.c for Solaris 8.
Date: Mon, 19 Feb 2007 21:51:10 -0500
Message-ID: <20070220025110.GA28797@spearce.org>
References: <17777.1171930976@lotus.CS.Berkeley.EDU> <20070220003533.GB28314@spearce.org> <7vfy9136zu.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jason Riedy <ejr@EECS.Berkeley.EDU>, git <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Feb 20 03:51:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJL67-0007FQ-2C
	for gcvg-git@gmane.org; Tue, 20 Feb 2007 03:51:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965593AbXBTCvP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Feb 2007 21:51:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932815AbXBTCvP
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Feb 2007 21:51:15 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:34925 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932812AbXBTCvP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Feb 2007 21:51:15 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HJL5p-0007PC-TN; Mon, 19 Feb 2007 21:51:01 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 1834B20FBAE; Mon, 19 Feb 2007 21:51:11 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <7vfy9136zu.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40203>

Junio C Hamano <junkio@cox.net> wrote:
> Yours talk about Sol 9 and Jason talks about Sol 8.  Should I
> take your ack to mean you want this patch on top of Jason's?

Yes, indeed.  Please apply that.  :-)

-- 
Shawn.
