From: Jeff King <peff@peff.net>
Subject: Re: Automated/Daily build systems supporting git?
Date: Tue, 8 Apr 2008 10:59:54 -0400
Message-ID: <20080408145953.GA8159@sigill.intra.peff.net>
References: <1207666672.5698.4.camel@pitcairn.cambridgebroadband.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Alex Bennee <kernel-hacker@bennee.com>
X-From: git-owner@vger.kernel.org Tue Apr 08 17:02:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JjFJu-0006Gy-TE
	for gcvg-git-2@gmane.org; Tue, 08 Apr 2008 17:01:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753183AbYDHO75 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Apr 2008 10:59:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751780AbYDHO75
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Apr 2008 10:59:57 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2104 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753183AbYDHO74 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Apr 2008 10:59:56 -0400
Received: (qmail 23630 invoked by uid 111); 8 Apr 2008 14:59:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 08 Apr 2008 10:59:55 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 08 Apr 2008 10:59:54 -0400
Content-Disposition: inline
In-Reply-To: <1207666672.5698.4.camel@pitcairn.cambridgebroadband.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79001>

On Tue, Apr 08, 2008 at 03:57:52PM +0100, Alex Bennee wrote:

> I'm currently doing some investigation into automated/daily build
> systems to track the health of a source tree. There seem to be a number
> about but as I'm also looking to move the CVS tree over to git I was
> wondering if the denziens of the list knew of any they could recommend?

Have you looked at contrib/continuous?

-Peff
