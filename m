From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: What's in git.git (stable)
Date: Fri, 4 Apr 2008 23:13:41 -0400
Message-ID: <20080405031341.GR10274@spearce.org>
References: <7vablloqqe.fsf@gitster.siamese.dyndns.org> <7vod9wlfx5.fsf@gitster.siamese.dyndns.org> <7v8x0wie56.fsf@gitster.siamese.dyndns.org> <7v4pbhv87i.fsf@gitster.siamese.dyndns.org> <7vfxv0npis.fsf@gitster.siamese.dyndns.org> <7vod9hr7p1.fsf@gitster.siamese.dyndns.org> <7veja192i4.fsf@gitster.siamese.dyndns.org> <7vk5jn7hb2.fsf@gitster.siamese.dyndns.org> <7v8wzzmgmf.fsf@gitster.siamese.dyndns.org> <7vbq4pzde4.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 05 05:14:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JhyrL-0005wd-95
	for gcvg-git-2@gmane.org; Sat, 05 Apr 2008 05:14:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751247AbYDEDNo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Apr 2008 23:13:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751241AbYDEDNo
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Apr 2008 23:13:44 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:42190 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751230AbYDEDNo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Apr 2008 23:13:44 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JhyqQ-0003dG-74; Fri, 04 Apr 2008 23:13:30 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 1D9A720FBAE; Fri,  4 Apr 2008 23:13:41 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7vbq4pzde4.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78834>

Junio C Hamano <gitster@pobox.com> wrote:
> * The 'master' branch has these since the last announcement and we are now
>   at 1.5.5-rc3.  The real 1.5.5 hopefully this weekend.
...
> Shawn O. Pearce (1):
>   git-gui 0.10

0.10 is a dud on Linux.  My master branch has a bug fix, but I'm
considering bringing in Michele's patch before tagging 0.10.1.

So 0.10.1, most likely tagged in a few hours, should be in 1.5.5.
Otherwise Linux users of git-gui will be sort of pissed.

Damn.

-- 
Shawn.
