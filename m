From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] send-pack: respect '+' on wildcard refspecs
Date: Fri, 19 Oct 2007 05:04:51 -0400
Message-ID: <20071019090451.GA9037@coredump.intra.peff.net>
References: <20071019090400.GA8944@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, dan@archlinux.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Oct 19 11:06:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IinnA-0006fh-BW
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 11:05:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764171AbXJSJEz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Oct 2007 05:04:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764167AbXJSJEy
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Oct 2007 05:04:54 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3833 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1764075AbXJSJEx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Oct 2007 05:04:53 -0400
Received: (qmail 10908 invoked by uid 111); 19 Oct 2007 09:04:52 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Fri, 19 Oct 2007 05:04:52 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 19 Oct 2007 05:04:51 -0400
Content-Disposition: inline
In-Reply-To: <20071019090400.GA8944@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61680>

On Fri, Oct 19, 2007 at 05:04:00AM -0400, Jeff King wrote:

> to pull the 'force' parameter from wildcard respects (but

Urgh, that should be "refspecs", not "respects". Maybe I should quit for
the night.

-Peff
