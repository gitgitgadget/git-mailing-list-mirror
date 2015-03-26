From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Mar 2015, #08; Mon, 23)
Date: Thu, 26 Mar 2015 12:18:18 -0400
Message-ID: <20150326161818.GD6564@peff.net>
References: <1418825936-18575-1-git-send-email-peter@lekensteyn.nl>
 <xmqqtwxa3ul7.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Peter Wu <peter@lekensteyn.nl>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 26 17:18:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YbAUE-0004fZ-PK
	for gcvg-git-2@plane.gmane.org; Thu, 26 Mar 2015 17:18:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752375AbbCZQSV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Mar 2015 12:18:21 -0400
Received: from cloud.peff.net ([50.56.180.127]:38764 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752117AbbCZQSV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Mar 2015 12:18:21 -0400
Received: (qmail 15570 invoked by uid 102); 26 Mar 2015 16:18:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 26 Mar 2015 11:18:20 -0500
Received: (qmail 24895 invoked by uid 107); 26 Mar 2015 16:18:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 26 Mar 2015 12:18:36 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 26 Mar 2015 12:18:18 -0400
Content-Disposition: inline
In-Reply-To: <xmqqtwxa3ul7.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266334>

On Tue, Mar 24, 2015 at 03:21:24PM -0700, Junio C Hamano wrote:

> > * pw/remote-set-url-fetch (2014-11-26) 1 commit
> >  - remote: add --fetch and --both options to set-url
> 
> This has not seen any activity for a few months since $gmane/261483; 
> is anybody still interested in resurrecting it?

I actually thought this had been merged. I was happy enough with the v4
you linked above, though it looks like you had some minor-ish comments.
I do not personally have a big interest in it and wasn't planning
anything else on it. But if Peter is still interested, I think it is
close to ready, and I'd be happy to do another round of review.

-Peff
