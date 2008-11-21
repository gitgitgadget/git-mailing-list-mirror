From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-send-email: provide hook to send lines more than
	998 symbols
Date: Fri, 21 Nov 2008 09:08:04 -0500
Message-ID: <20081121140803.GA32323@coredump.intra.peff.net>
References: <1227261564-13268-1-git-send-email-andy.shevchenko@gmail.com> <20081121115813.GB3747@sigill.intra.peff.net> <4926AE4E.5000604@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Nov 21 15:09:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L3WhQ-0007ux-15
	for gcvg-git-2@gmane.org; Fri, 21 Nov 2008 15:09:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753038AbYKUOIK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Nov 2008 09:08:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752988AbYKUOIJ
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Nov 2008 09:08:09 -0500
Received: from peff.net ([208.65.91.99]:2774 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752973AbYKUOII (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Nov 2008 09:08:08 -0500
Received: (qmail 29916 invoked by uid 111); 21 Nov 2008 14:08:06 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Fri, 21 Nov 2008 09:08:06 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 21 Nov 2008 09:08:04 -0500
Content-Disposition: inline
In-Reply-To: <4926AE4E.5000604@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101530>

On Fri, Nov 21, 2008 at 01:49:18PM +0100, Michael J Gruber wrote:

> In fact it is documented in git-send-email.txt:
> 
> --[no-]validate::
>         Perform sanity checks on patches.
>         Currently, validation means the following:

Oh, right. Sorry, I stupidly looked at an older installed manpage
instead of going right to the source. So yes, it is documented.

-Peff
