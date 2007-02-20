From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Add a compat/strtoumax.c for Solaris 8.
Date: Mon, 19 Feb 2007 19:58:22 -0500
Message-ID: <20070220005821.GC28314@spearce.org>
References: <17777.1171930976@lotus.CS.Berkeley.EDU> <20070220003533.GB28314@spearce.org> <7virdx4pl2.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jason Riedy <ejr@EECS.Berkeley.EDU>, git <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Feb 20 01:58:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJJKx-0003aj-Kq
	for gcvg-git@gmane.org; Tue, 20 Feb 2007 01:58:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965847AbXBTA62 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Feb 2007 19:58:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965848AbXBTA61
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Feb 2007 19:58:27 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:60415 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965847AbXBTA60 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Feb 2007 19:58:26 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HJJKg-0007P4-AX; Mon, 19 Feb 2007 19:58:14 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 9696820FBAE; Mon, 19 Feb 2007 19:58:22 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <7virdx4pl2.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40189>

Junio C Hamano <junkio@cox.net> wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> 
> > This is a better version than the patch I sent out last night,
> > so Junio please drop my patch in favor of Jason's.
> 
> Agh.  Too late...
> 
> I need some rewinding and reshuffling.

Whoops.  :-)

I hear Git is good at rewinding and reshuffling.  Provided you have
not pushed the commits out yet.  Maybe that will help you here?  ;-)

-- 
Shawn.
