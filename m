From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv4 0/4] verify-commit: verify commit signatures
Date: Fri, 27 Jun 2014 20:48:14 -0400
Message-ID: <20140628004814.GC13228@sigill.intra.peff.net>
References: <xmqqoaxjb9rr.fsf@gitster.dls.corp.google.com>
 <cover.1403877430.git.git@drmicha.warpmail.net>
 <xmqqoaxe1894.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 28 02:48:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X0goV-0000uO-TC
	for gcvg-git-2@plane.gmane.org; Sat, 28 Jun 2014 02:48:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753454AbaF1AsQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2014 20:48:16 -0400
Received: from cloud.peff.net ([50.56.180.127]:52388 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750831AbaF1AsQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2014 20:48:16 -0400
Received: (qmail 24185 invoked by uid 102); 28 Jun 2014 00:48:16 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 27 Jun 2014 19:48:16 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 27 Jun 2014 20:48:14 -0400
Content-Disposition: inline
In-Reply-To: <xmqqoaxe1894.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252593>

On Fri, Jun 27, 2014 at 12:07:35PM -0700, Junio C Hamano wrote:

> > - Should we do this now or go for generic "git verify" right away?
> 
> I do not think we are ready to do "git verify" yet.

If there is one thing that this discussion have convinced me of, it is
this. :)

-Peff
