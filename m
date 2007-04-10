From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Feature request - Subtree checkouts
Date: Tue, 10 Apr 2007 09:20:11 -0400
Message-ID: <20070410132011.GH5436@spearce.org>
References: <20070410074444.GA18541@curie-int.orbis-terrarum.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Robin H. Johnson" <robbat2@gentoo.org>
X-From: git-owner@vger.kernel.org Tue Apr 10 18:23:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HbGGj-0003rd-4c
	for gcvg-git@gmane.org; Tue, 10 Apr 2007 15:20:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030490AbXDJNUR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Apr 2007 09:20:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030503AbXDJNUQ
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Apr 2007 09:20:16 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:41429 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030490AbXDJNUP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Apr 2007 09:20:15 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HbGGX-000745-3w; Tue, 10 Apr 2007 09:20:09 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id F3FE220FBAE; Tue, 10 Apr 2007 09:20:11 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20070410074444.GA18541@curie-int.orbis-terrarum.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44131>

"Robin H. Johnson" <robbat2@gentoo.org> wrote:
> P.S. Does this list do some weird spam-blocking? I've tried 3 times now
> to use git-send-email to send an unrelated minor patch set
> (--subject-prefix for git-format-patch), and it has never shown up on
> the list :-(.

Yes.  It has cut down on our spam, but it has also caused some
things to be blocked, almost without good reason.  ;-)

I send a fair number of patches to this list (at times anyway) and
am also unable to use git-send-email.  If I have the email also CC
back to me it does make it through a number of SMTP server hops,
including my own spam filters, but it never makes it through the
Git mailing list.  So I dump the patches to an mbox with --stdout,
open them up in mutt and resend them there.  I've bound shift-G
to resend-message for that purpose...

-- 
Shawn.
