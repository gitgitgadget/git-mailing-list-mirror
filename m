From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] add GIT_PATHSPEC_GLOB environment variable
Date: Wed, 19 Dec 2012 17:20:35 -0500
Message-ID: <20121219222035.GA22998@sigill.intra.peff.net>
References: <20121219203449.GA10001@sigill.intra.peff.net>
 <7vk3sd930z.fsf@alter.siamese.dyndns.org>
 <20121219210919.GA11894@sigill.intra.peff.net>
 <20121219215008.GA17908@sigill.intra.peff.net>
 <7v7god8zz0.fsf@alter.siamese.dyndns.org>
 <20121219221250.GA22823@sigill.intra.peff.net>
 <7v38z18z6z.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 19 23:21:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TlS0b-0006MY-DX
	for gcvg-git-2@plane.gmane.org; Wed, 19 Dec 2012 23:21:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751832Ab2LSWUn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Dec 2012 17:20:43 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:58845 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751777Ab2LSWUj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Dec 2012 17:20:39 -0500
Received: (qmail 1974 invoked by uid 107); 19 Dec 2012 22:21:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 19 Dec 2012 17:21:44 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 19 Dec 2012 17:20:35 -0500
Content-Disposition: inline
In-Reply-To: <7v38z18z6z.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211859>

On Wed, Dec 19, 2012 at 02:16:52PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> >> Will queue; thanks.
> >
> > Do we want to change the variable name and invert the logic?
> 
> That would be my preference.
> 
> I am deep into today's integration cycle, and this PATHSPEC_GLOB
> version is sitting at the tip of 'pu', so today's pushout will
> contain that version, though.

That's fine. I'll send out a revised version, and you can pick it up
later.

-Peff
