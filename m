From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git(1): remove a defunct link to "list of authors"
Date: Thu, 13 Dec 2012 07:25:19 -0500
Message-ID: <20121213122518.GA25613@sigill.intra.peff.net>
References: <7vobi5hhn9.fsf@alter.siamese.dyndns.org>
 <7vk3sthhfy.fsf@alter.siamese.dyndns.org>
 <CACsJy8A7AYpZs7mTc+B-F7BBLPdACim=gHCg8sK1Aci8YSEB4Q@mail.gmail.com>
 <7vboe2ct9p.fsf@alter.siamese.dyndns.org>
 <CACsJy8Dg1a0siDbiHtk4m1RhjLt-XKiS8kOO7qPKjwRczLF9vA@mail.gmail.com>
 <20121212122448.GA20057@sigill.intra.peff.net>
 <7v8v935en3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 13 13:25:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tj7rG-0000yA-FH
	for gcvg-git-2@plane.gmane.org; Thu, 13 Dec 2012 13:25:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753970Ab2LMMZa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Dec 2012 07:25:30 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:48526 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753603Ab2LMMZ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Dec 2012 07:25:29 -0500
Received: (qmail 3492 invoked by uid 107); 13 Dec 2012 12:26:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 13 Dec 2012 07:26:31 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 13 Dec 2012 07:25:19 -0500
Content-Disposition: inline
In-Reply-To: <7v8v935en3.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211449>

On Wed, Dec 12, 2012 at 10:06:24AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I find the ohloh one a little more informative than the GitHub graph. I
> > couldn't find any others (Google Code does not seem to have one,
> > kernel.org and other gitweb sites do not, and I can't think of anywhere
> > else that hosts a mirror).
> 
> Then let's do this.
> 
> -- >8 --
> Subject: git(1): show link to contributor summary page
> 
> We earlier removed a link to list of contributors that pointed to a
> defunct page; let's use a working one from Ohloh.net to replace it
> instead.

Looks good to me. Thanks.

-Peff
