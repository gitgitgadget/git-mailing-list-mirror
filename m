From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Interim maintainer tree
Date: Mon, 5 Oct 2009 07:56:15 -0700
Message-ID: <20091005145615.GA9261@spearce.org>
References: <20090925160504.GW14660@spearce.org> <7viqevu1zt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 05 17:00:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mup2f-0004Ov-BI
	for gcvg-git-2@lo.gmane.org; Mon, 05 Oct 2009 17:00:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753191AbZJEO4x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Oct 2009 10:56:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752884AbZJEO4w
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Oct 2009 10:56:52 -0400
Received: from george.spearce.org ([209.20.77.23]:42846 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752615AbZJEO4w (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Oct 2009 10:56:52 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id D62D3381FE; Mon,  5 Oct 2009 14:56:15 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <7viqevu1zt.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129565>

Junio C Hamano <gitster@pobox.com> wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> > Junio is on vaction for the next week.  In his absence Peff and I
> > are trying to keep up with current patches in my fork:
> >
> >   git://repo.or.cz/git/spearce.git
> >   http://repo.or.cz/r/git/spearce.git
> >
> > Right now the tree matches Junio's last push, I'll try to pick up
> > the patches since then and push later today.
> 
> Thanks, both.
> 
> I've fetched, but haven't fully examined "log ..spearce/*" nor "log ..peff/*"
> yet.

Sorry, I proved to be a very poor interim maintainer this cycle.
I just didn't have the time to keep up with integration each day,
and then dropped the ball on Thursday and Friday and failed to pull
anything from Peff or the list.  Peff, thanks for keeping up a bit
and at least having some tips for Junio to pick up from.
 
> I noticed that some topics in 'pu' have been rebased (not complaining, but
> just making sure I am not hallucinating).

Yes, some topics in 'pu' got rebased.  Wednesday I ran RB
after preparing a new master, and then rebuilt pu around it.
Unfortunately I somehow lost a patch on Nick's rev-list series,
not sure how I managed to do that, but I guess I did, sorry.

Were you no longer in the habit of running RB when you rebuilt pu?
 
-- 
Shawn.
