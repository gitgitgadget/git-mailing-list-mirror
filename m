From: Jeff King <peff@peff.net>
Subject: Re: Git documentation at kernel.org
Date: Sun, 12 Feb 2012 17:25:08 -0500
Message-ID: <20120212222508.GA25619@sigill.intra.peff.net>
References: <CAPyqok3USqMxm0gNf_T9vnCoicp9XSwpWUCYJ8jh79h=V_UuOA@mail.gmail.com>
 <20120208213410.GA5768@ecki>
 <7vmx8rtu3e.fsf@alter.siamese.dyndns.org>
 <20120210200401.GB5504@sigill.intra.peff.net>
 <vpqehtz909k.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Clemens Buchacher <drizzd@aon.at>, ftpadmin@kernel.org,
	Petr Onderka <gsvick@gmail.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Sun Feb 12 23:25:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RwhrF-0007Qi-LT
	for gcvg-git-2@plane.gmane.org; Sun, 12 Feb 2012 23:25:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755854Ab2BLWZL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Feb 2012 17:25:11 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:34161
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754901Ab2BLWZL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Feb 2012 17:25:11 -0500
Received: (qmail 25710 invoked by uid 107); 12 Feb 2012 22:32:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 12 Feb 2012 17:32:20 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 12 Feb 2012 17:25:08 -0500
Content-Disposition: inline
In-Reply-To: <vpqehtz909k.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190592>

On Sun, Feb 12, 2012 at 11:04:23PM +0100, Matthieu Moy wrote:

> Jeff King <peff@peff.net> writes:
> 
> > If there is interest in this, we would be happy to host the
> > documentation. Let me know if that is the case, and we can give it a
> > much better URL than schacon.github.com. However, I tend to think that
> > since the project is hosted[1] at kernel.org, the official documentation
> > site should be there as well.
> 
> kernel.org is probably the most "official" place for developers, but for
> Git users, http://git-scm.com/ is most likely the best entry point. If
> it were not for historical reasons, I think http://git-scm.com/docs/ or
> so would be the most natural URL to host official docs.

Good point. That is probably the best place to host it.

As far as historical reasons, perhaps the right answer is to put the
documentation where it makes sense to go _now_, and ask kernel.org to
issue http redirects for http://kernel.org/pub/software/scm/git/docs.

-Peff
