From: Jeff King <peff@peff.net>
Subject: Re: Interim maintainer tree
Date: Mon, 5 Oct 2009 11:05:47 -0400
Message-ID: <20091005150546.GA18460@coredump.intra.peff.net>
References: <20090925160504.GW14660@spearce.org>
 <7viqevu1zt.fsf@alter.siamese.dyndns.org>
 <20091005145615.GA9261@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Oct 05 17:11:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MupD8-0002YD-1R
	for gcvg-git-2@lo.gmane.org; Mon, 05 Oct 2009 17:10:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753341AbZJEPGe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Oct 2009 11:06:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753332AbZJEPGd
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Oct 2009 11:06:33 -0400
Received: from peff.net ([208.65.91.99]:49727 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753313AbZJEPGd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Oct 2009 11:06:33 -0400
Received: (qmail 18233 invoked by uid 107); 5 Oct 2009 15:09:22 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 05 Oct 2009 11:09:22 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 05 Oct 2009 11:05:47 -0400
Content-Disposition: inline
In-Reply-To: <20091005145615.GA9261@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129566>

On Mon, Oct 05, 2009 at 07:56:15AM -0700, Shawn O. Pearce wrote:

> Sorry, I proved to be a very poor interim maintainer this cycle.
> I just didn't have the time to keep up with integration each day,
> and then dropped the ball on Thursday and Friday and failed to pull
> anything from Peff or the list.  Peff, thanks for keeping up a bit
> and at least having some tips for Junio to pick up from.

It was an interesting experience this time, having two people doing it.
I think the communication overhead may have overwhelmed any help we were
giving each other. Perhaps if there had been more, larger series, it
might have made sense to assign somebody to track a topic and its
iterations, and then finally sign off on it being ready. But being -rc
period, things seem to have settled down, and most patches were one-off
bugfixes all over the place.

-Peff
