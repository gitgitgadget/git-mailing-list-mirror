From: Shawn Pearce <spearce@spearce.org>
Subject: Re: paginate git-diff by default?
Date: Tue, 10 Oct 2006 14:15:58 -0400
Message-ID: <20061010181558.GB16972@spearce.org>
References: <20061010181337.GE8612@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 10 20:16:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GXM9A-0001tF-Fp
	for gcvg-git@gmane.org; Tue, 10 Oct 2006 20:16:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964968AbWJJSQF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Oct 2006 14:16:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964992AbWJJSQE
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Oct 2006 14:16:04 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:54914 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S964968AbWJJSQC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Oct 2006 14:16:02 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GXM8u-0002fD-Vn; Tue, 10 Oct 2006 14:15:53 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id C133420FB00; Tue, 10 Oct 2006 14:15:58 -0400 (EDT)
To: Martin Waitz <tali@admingilde.org>
Content-Disposition: inline
In-Reply-To: <20061010181337.GE8612@admingilde.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28648>

Martin Waitz <tali@admingilde.org> wrote:
> hoi :)
> 
> I always find myself typing "git -p diff".
> Should we paginate git-diff output by default?
> 
> I was sure this was discussed before but I could not immediately
> find it, so I'm simply asking again ;-).

I agree.  I'm very used to git log automatically running my $PAGER;
I'm always surprised that git diff doesn't do the same when attached
to my tty.

-- 
Shawn.
