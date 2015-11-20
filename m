From: Jeff King <peff@peff.net>
Subject: Re: [PULL] git-svn: improve rebase/mkdirs performance
Date: Fri, 20 Nov 2015 06:57:14 -0500
Message-ID: <20151120115713.GA14712@sigill.intra.peff.net>
References: <20151111205741.GA2591@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Dair Grant <dair@feralinteractive.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Fri Nov 20 12:57:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZzkJo-0003CH-PD
	for gcvg-git-2@plane.gmane.org; Fri, 20 Nov 2015 12:57:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759922AbbKTL5R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Nov 2015 06:57:17 -0500
Received: from cloud.peff.net ([50.56.180.127]:60094 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759595AbbKTL5R (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Nov 2015 06:57:17 -0500
Received: (qmail 21110 invoked by uid 102); 20 Nov 2015 11:57:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 20 Nov 2015 05:57:17 -0600
Received: (qmail 26889 invoked by uid 107); 20 Nov 2015 11:57:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 20 Nov 2015 06:57:49 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 20 Nov 2015 06:57:14 -0500
Content-Disposition: inline
In-Reply-To: <20151111205741.GA2591@dcvr.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281512>

On Wed, Nov 11, 2015 at 08:57:41PM +0000, Eric Wong wrote:

> Hi Jeff/Junio, nothing urgent, please pull at your convenience.
> Thanks.

Thanks, pulled.

-Peff
