From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Make git-clean a builtin
Date: Sun, 7 Oct 2007 22:08:15 -0400
Message-ID: <20071008020815.GB20050@coredump.intra.peff.net>
References: <11917040461528-git-send-email-shawn.bohrer@gmail.com> <20071008020435.GA20050@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Shawn Bohrer <shawn.bohrer@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 08 04:08:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iei2m-0008Gn-4D
	for gcvg-git-2@gmane.org; Mon, 08 Oct 2007 04:08:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754551AbXJHCIR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Oct 2007 22:08:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754072AbXJHCIR
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Oct 2007 22:08:17 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2498 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753156AbXJHCIR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Oct 2007 22:08:17 -0400
Received: (qmail 9091 invoked by uid 111); 8 Oct 2007 02:08:16 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sun, 07 Oct 2007 22:08:16 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 07 Oct 2007 22:08:15 -0400
Content-Disposition: inline
In-Reply-To: <20071008020435.GA20050@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60276>

On Sun, Oct 07, 2007 at 10:04:35PM -0400, Jeff King wrote:

> This doesn't always put you back where you started, due to symlinks. For
> example:
> [and other complaints]

Oops, didn't see that there was another thread for the reworked patch.
My comments still stand, but it looks like others have weighed in as
well. Sorry.

-Peff
