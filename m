From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/9] fprintf(stderr, "warning: ") -> warning() patches
Date: Tue, 24 Mar 2009 03:35:13 -0400
Message-ID: <20090324073513.GA32400@coredump.intra.peff.net>
References: <7v3ad5dxt5.fsf@gitster.siamese.dyndns.org> <cover.1237856682.git.vmiklos@frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	John Tapsell <johnflux@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Tue Mar 24 08:36:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lm1Bt-00082f-CY
	for gcvg-git-2@gmane.org; Tue, 24 Mar 2009 08:36:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753706AbZCXHfX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Mar 2009 03:35:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752287AbZCXHfX
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Mar 2009 03:35:23 -0400
Received: from peff.net ([208.65.91.99]:44647 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750937AbZCXHfX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Mar 2009 03:35:23 -0400
Received: (qmail 27452 invoked by uid 107); 24 Mar 2009 07:35:32 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 24 Mar 2009 03:35:32 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 24 Mar 2009 03:35:13 -0400
Content-Disposition: inline
In-Reply-To: <cover.1237856682.git.vmiklos@frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114406>

On Tue, Mar 24, 2009 at 02:09:08AM +0100, Miklos Vajna wrote:

> Okay, here it is, applies on top of master. All, except the http-push
> one, applies cleanly on top of next as well here.

I manually scanned the patches and they all look sane to me.
Thanks.

-Peff
