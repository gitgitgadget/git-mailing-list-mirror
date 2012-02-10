From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 6/8] gitweb: Highlight interesting parts of diff
Date: Fri, 10 Feb 2012 16:32:09 -0500
Message-ID: <20120210213209.GA7582@sigill.intra.peff.net>
References: <1328865494-24415-1-git-send-email-michal.kiedrowicz@gmail.com>
 <1328865494-24415-7-git-send-email-michal.kiedrowicz@gmail.com>
 <20120210202008.GA5874@sigill.intra.peff.net>
 <20120210222916.2721e9e6@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?Micha=C5=82?= Kiedrowicz <michal.kiedrowicz@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 10 22:32:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rvy4m-0006de-8C
	for gcvg-git-2@plane.gmane.org; Fri, 10 Feb 2012 22:32:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760226Ab2BJVcM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Feb 2012 16:32:12 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:33566
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759047Ab2BJVcL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Feb 2012 16:32:11 -0500
Received: (qmail 8184 invoked by uid 107); 10 Feb 2012 21:39:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 10 Feb 2012 16:39:20 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 10 Feb 2012 16:32:09 -0500
Content-Disposition: inline
In-Reply-To: <20120210222916.2721e9e6@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190460>

On Fri, Feb 10, 2012 at 10:29:16PM +0100, Micha=C5=82 Kiedrowicz wrote:

> > Have you considered contributing back the enhancements to
> > contrib/diff-highlight?=20
>=20
> Yeah, I did. In fact, at work I have a hacked version of your
> diff-highlight that supports multiline changes and I use it every day=
=2E
> But I just couldn't make myself fix your long README and send a
> patch :).

Heh. Why don't you show your hack in the meantime. Even if the code is
ugly or the documentation is missing, I'd like to see the output, and
maybe we can fix those other things together.

-Peff
