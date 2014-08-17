From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-imap-send: simplify tunnel construction
Date: Sun, 17 Aug 2014 03:30:58 -0400
Message-ID: <20140817073058.GF23808@peff.net>
References: <53EBA0C3.2040805@raz.or.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Bernhard Reiter <ockham@raz.or.at>
X-From: git-owner@vger.kernel.org Sun Aug 17 09:31:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XIuvh-0005ao-7R
	for gcvg-git-2@plane.gmane.org; Sun, 17 Aug 2014 09:31:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750857AbaHQHbA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Aug 2014 03:31:00 -0400
Received: from cloud.peff.net ([50.56.180.127]:53539 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750809AbaHQHa7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Aug 2014 03:30:59 -0400
Received: (qmail 6232 invoked by uid 102); 17 Aug 2014 07:31:00 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 17 Aug 2014 02:31:00 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 17 Aug 2014 03:30:58 -0400
Content-Disposition: inline
In-Reply-To: <53EBA0C3.2040805@raz.or.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255354>

On Wed, Aug 13, 2014 at 07:30:43PM +0200, Bernhard Reiter wrote:

> Signed-off-by: Bernhard Reiter <ockham@raz.or.at>
> ---
>  imap-send.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)

Thanks, this looks obviously correct and is a good direction.

-Peff
