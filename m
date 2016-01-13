From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/5] config.mak.uname: support MSys2
Date: Wed, 13 Jan 2016 11:11:29 -0500
Message-ID: <20160113161128.GA11898@sigill.intra.peff.net>
References: <cover.1452691805.git.johannes.schindelin@gmx.de>
 <e63d391a79396e095d2ebb139bb44c390e50bb62.1452691805.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jan 13 17:11:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJO1I-00017X-Ts
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jan 2016 17:11:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753144AbcAMQLc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2016 11:11:32 -0500
Received: from cloud.peff.net ([50.56.180.127]:52946 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752975AbcAMQLc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2016 11:11:32 -0500
Received: (qmail 1826 invoked by uid 102); 13 Jan 2016 16:11:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 13 Jan 2016 11:11:31 -0500
Received: (qmail 28791 invoked by uid 107); 13 Jan 2016 16:11:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 13 Jan 2016 11:11:49 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 13 Jan 2016 11:11:29 -0500
Content-Disposition: inline
In-Reply-To: <e63d391a79396e095d2ebb139bb44c390e50bb62.1452691805.git.johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283922>

On Wed, Jan 13, 2016 at 02:30:53PM +0100, Johannes Schindelin wrote:

> For a long time, Git for Windows lagged behind Git's 2.x releases because
> the Git for Windows developers wanted to let that big jump coincide with
> a well-needed jump away from MSys to MSys2.
> [...]

I can't say much about the patch itself, but I think this commit is
worth it for the message alone. Now I finally know the subtle
differences between all of those systems!

-Peff
