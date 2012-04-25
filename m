From: Jeff King <peff@peff.net>
Subject: Re: Wither --local
Date: Wed, 25 Apr 2012 17:43:00 -0400
Message-ID: <20120425214300.GB8590@sigill.intra.peff.net>
References: <799127EF-097F-41DA-A331-E38968ED531D@justatheory.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "David E. Wheeler" <david@justatheory.com>
X-From: git-owner@vger.kernel.org Wed Apr 25 23:43:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SN9zT-00082r-95
	for gcvg-git-2@plane.gmane.org; Wed, 25 Apr 2012 23:43:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757549Ab2DYVnE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Apr 2012 17:43:04 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:44822
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750742Ab2DYVnD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Apr 2012 17:43:03 -0400
Received: (qmail 6827 invoked by uid 107); 25 Apr 2012 21:43:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 25 Apr 2012 17:43:15 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 25 Apr 2012 17:43:00 -0400
Content-Disposition: inline
In-Reply-To: <799127EF-097F-41DA-A331-E38968ED531D@justatheory.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196340>

On Wed, Apr 25, 2012 at 11:09:33AM -0700, David E. Wheeler wrote:

> I notice that the usage statement displayed for `git config` mentions
> --local, but `git help config` does not. Should it? It seems a bit
> under-documented=E2=80=A6

Yes, it should. Original motivation is here:

  http://thread.gmane.org/gmane.comp.version-control.git/152524

-Peff
