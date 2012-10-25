From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] fix 'make test' for HP NonStop
Date: Thu, 25 Oct 2012 06:52:36 -0400
Message-ID: <20121025105236.GA2962@sigill.intra.peff.net>
References: <001e01cdb061$c25f6380$471e2a80$@schmitz-digital.de>
 <20121025095826.GM8390@sigill.intra.peff.net>
 <002e01cdb29a$893593f0$9ba0bbd0$@schmitz-digital.de>
 <20121025104900.GA6363@sigill.intra.peff.net>
 <002f01cdb29e$c2db47e0$4891d7a0$@schmitz-digital.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Joachim Schmitz <jojo@schmitz-digital.de>
X-From: git-owner@vger.kernel.org Thu Oct 25 12:52:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TRL3T-00038L-9F
	for gcvg-git-2@plane.gmane.org; Thu, 25 Oct 2012 12:52:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757785Ab2JYKwk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2012 06:52:40 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:56137 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754065Ab2JYKwj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Oct 2012 06:52:39 -0400
Received: (qmail 8216 invoked by uid 107); 25 Oct 2012 10:53:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 25 Oct 2012 06:53:18 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 25 Oct 2012 06:52:36 -0400
Content-Disposition: inline
In-Reply-To: <002f01cdb29e$c2db47e0$4891d7a0$@schmitz-digital.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208388>

On Thu, Oct 25, 2012 at 12:51:59PM +0200, Joachim Schmitz wrote:

> > But then I would think using /usr/local would be the sane thing to put
> > there, if that is the closest to "standard" for your platform.
> 
> OK, yes, hardcoding /usr/local seems OK too.
> Would I need to re-roll?

Please do.

-Peff
