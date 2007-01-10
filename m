From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Detached HEAD (experimental)
Date: Tue, 9 Jan 2007 21:28:30 -0500
Message-ID: <20070110022829.GB30765@spearce.org>
References: <7virffkick.fsf@assigned-by-dhcp.cox.net> <20070109213117.GB25012@fieldses.org> <87zm8ryiyz.wl%cworth@cworth.org> <20070109234421.GD30023@spearce.org> <eo1bqu$hji$1@sea.gmane.org> <20070110003433.GH30023@spearce.org> <Pine.LNX.4.64.0701092014390.4964@xanadu.home> <7vwt3vfzd1.fsf@assigned-by-dhcp.cox.net> <20070110014000.GA30765@spearce.org> <Pine.LNX.4.64.0701092045090.4964@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, Jakub Narebski <jnareb@gmail.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 10 03:28:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4TCj-000476-Ve
	for gcvg-git@gmane.org; Wed, 10 Jan 2007 03:28:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932664AbXAJC2j (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Jan 2007 21:28:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932669AbXAJC2j
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jan 2007 21:28:39 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:40038 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932664AbXAJC2j (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jan 2007 21:28:39 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1H4TCP-0006Z6-LT; Tue, 09 Jan 2007 21:28:21 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id D3BF120FBAE; Tue,  9 Jan 2007 21:28:30 -0500 (EST)
To: Nicolas Pitre <nico@cam.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0701092045090.4964@xanadu.home>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36472>

Nicolas Pitre <nico@cam.org> wrote:
> On Tue, 9 Jan 2007, Shawn O. Pearce wrote:
> > But if you reflog a detached
> > HEAD its there as HEAD@{2}.
> 
> But when your head is not detached anymore then HEAD@{2} changes 
> meaning and that is rather not good.

Ah, yes, apparently my own head is detached and not clearly thinking.
Thanks.  That UI is not so good.

-- 
Shawn.
