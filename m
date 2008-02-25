From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Instituting feature and infrastructure enhancement proposal window?
Date: Sun, 24 Feb 2008 19:52:54 -0500
Message-ID: <20080225005254.GJ8410@spearce.org>
References: <7v8x1ataiu.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.00.0802241226340.21332@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Feb 25 01:54:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTRbP-0007bv-KX
	for gcvg-git-2@gmane.org; Mon, 25 Feb 2008 01:53:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755204AbYBYAxF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Feb 2008 19:53:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754827AbYBYAxE
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Feb 2008 19:53:04 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:60314 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753394AbYBYAxD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Feb 2008 19:53:03 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JTRaJ-0002DN-5Y; Sun, 24 Feb 2008 19:52:47 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 8DA6520FBAE; Sun, 24 Feb 2008 19:52:55 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.00.0802241226340.21332@woody.linux-foundation.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74978>

Linus Torvalds <torvalds@linux-foundation.org> wrote:
> On Sun, 24 Feb 2008, Junio C Hamano wrote:
> >
> > The important dates in the above would be (in parentheses are my
> > straw-mans):
> 
> So I would basically cut you target timeframes into half (except for the 
> first -rc release - there's no point in making that less than a week). 
> Three months is just going to make people who miss the release window 
> antsy. It's what the kernel has in practice, and I would *not* advocate it 
> as ideal - I actually aim for 2 months and we then invariably slip a bit..
> 
> So I'd suggest:
>  - first -rc in 1 week
>  - window closes in 3 weeks
>  - next release in 6 weeks
>  - rinse and repeat

Yea, I agree with Linus suggestion of cutting the time windows
down to closer to 2 months per release.  1.5.4 took a long time.
It doesn't really affect me as I usually run the bleeding edge
'next', but I think most of our users feel warm and fuzzy about
running a released version.  As a community we need to help Junio
get stable releases out more often, so users can benefit from the
improvements we've made.

-- 
Shawn.
