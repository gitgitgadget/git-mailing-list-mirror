From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH(amend)] core.workdir config variable
Date: Wed, 14 Mar 2007 10:20:02 -0400
Message-ID: <20070314142002.GC22034@spearce.org>
References: <20070311043250.GA21331@moooo.ath.cx> <fcaeb9bf0703110542t49bb3e77kb164ba7bfee1a6ed@mail.gmail.com> <20070311155649.GA29663@moooo.ath.cx> <20070311212906.GA18208@moooo.ath.cx> <20070313231004.GA15058@moooo.ath.cx> <20070313235755.GA25013@moooo.ath.cx> <20070314060145.GB20978@spearce.org> <7vfy88fepp.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthias Lederhofer <matled@gmx.net>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Mar 14 15:20:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HRUL1-0006JH-V0
	for gcvg-git@gmane.org; Wed, 14 Mar 2007 15:20:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161291AbXCNOUJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Mar 2007 10:20:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161292AbXCNOUJ
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Mar 2007 10:20:09 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:59806 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161291AbXCNOUH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Mar 2007 10:20:07 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HRUKc-0003dd-AG; Wed, 14 Mar 2007 10:19:58 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 33B4E20FBAE; Wed, 14 Mar 2007 10:20:02 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7vfy88fepp.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42208>

Junio C Hamano <junkio@cox.net> wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> 
> > Matthias Lederhofer <matled@gmx.net> wrote:
> >> core.workdir is used as default value for $GIT_WORK_DIR
> > ...
> >> -- 
> >> gitgui.0.6.3.g4bccd
> >
> > Really?  gitgui generates emails now?  ;-)
> 
> It might not be a bad idea actually.  You let people make
> commits.  Why not let them pick commits, run format-patch and
> drive send-email for them from the UI?

No, its not.  There's a lot of stuff I want to put into there;
that just happens to be one of them.  ;-)

-- 
Shawn.
