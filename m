From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH] Contributed bash completion support for core Git tools.
Date: Thu, 28 Sep 2006 12:28:10 -0400
Message-ID: <20060928162810.GA3201@spearce.org>
References: <20060918004831.GA19851@spearce.org> <7vodtex9xm.fsf@assigned-by-dhcp.cox.net> <20060918011855.GA19955@spearce.org> <7v64f8vueh.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 28 18:28:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSykN-000652-Du
	for gcvg-git@gmane.org; Thu, 28 Sep 2006 18:28:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932462AbWI1Q2R (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Sep 2006 12:28:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932504AbWI1Q2Q
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Sep 2006 12:28:16 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:51920 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S932462AbWI1Q2O (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Sep 2006 12:28:14 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GSyk2-0007HS-KR; Thu, 28 Sep 2006 12:28:06 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id AD3C720FB28; Thu, 28 Sep 2006 12:28:10 -0400 (EDT)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v64f8vueh.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28017>

Junio C Hamano <junkio@cox.net> wrote:
> Shawn Pearce <spearce@spearce.org> writes:
> 
> > I'm not sure there are too many other things to hook into bash in
> > addition to completion so contrib/completion/git-completion.bash may
> > be the better location, assuming it doesn't graduate out of contrib/.
> 
> Just so that we do not forget, I applied this (and your
> follow-up patch).

Thanks.  I was starting to wonder about that patch set and was
probably going to send a reminder next week.  Now I don't have to.
:-)

-- 
Shawn.
