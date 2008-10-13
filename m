From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Fwd: git status options feature suggestion
Date: Sun, 12 Oct 2008 18:30:42 -0700
Message-ID: <20081013013042.GI4856@spearce.org>
References: <20081009061136.GA24288@coredump.intra.peff.net> <81bfc67a0810082327p421ca4e9v84f4b33023bc6fe6@mail.gmail.com> <81bfc67a0810082327q71b9d6apf2787eb8519031bb@mail.gmail.com> <alpine.DEB.1.00.0810091101230.22125@pacific.mpi-cbg.de.mpi-cbg.de> <48EE1F58.2060707@drmicha.warpmail.net> <20081012044900.GA27845@coredump.intra.peff.net> <7vwsgegvsh.fsf@gitster.siamese.dyndns.org> <20081012064512.GA32597@coredump.intra.peff.net> <7v1vymgrom.fsf@gitster.siamese.dyndns.org> <20081013010415.GB3768@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Caleb Cushing <xenoterracide@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Oct 13 03:31:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KpCHr-0007A6-NO
	for gcvg-git-2@gmane.org; Mon, 13 Oct 2008 03:31:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754278AbYJMBan (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Oct 2008 21:30:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754264AbYJMBan
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Oct 2008 21:30:43 -0400
Received: from george.spearce.org ([209.20.77.23]:49713 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754261AbYJMBan (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Oct 2008 21:30:43 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 371843835F; Mon, 13 Oct 2008 01:30:42 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20081013010415.GB3768@coredump.intra.peff.net>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98072>

Jeff King <peff@peff.net> wrote:
> However, now that Shawn has revealed the existence of his super-secret
> status replacement, I am going to wait to see that before moving any
> further. :)

I'll talk about it more at the GitTogether.  I expect the sources
to be published and available for download between now and then.
I'll post a pointer to it here on the Git ML once the sources
go live.

So you shouldn't have to wait too much longer.

But as I said, it really is just a trivial redisplay of what
diff-files and diff-index produces.  Anyone could probably code up
the same result in 15 minutes in Perl or Python; or slightly longer
in C.

-- 
Shawn.
