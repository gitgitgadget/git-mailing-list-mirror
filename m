From: Jeff King <peff@peff.net>
Subject: Re: On Tabs and Spaces
Date: Wed, 17 Oct 2007 20:32:56 -0400
Message-ID: <20071018003256.GA5062@coredump.intra.peff.net>
References: <1192548367.3821.4.camel@lt21223.campus.dmacc.edu> <B2F6DB0C-4EFE-4C56-8E7A-31820320CA02@mit.edu> <3awb7zw6.fsf@blue.sea.net> <alpine.LFD.0.999.0710161214530.6887@woody.linux-foundation.org> <1192565900.6430.16.camel@athena> <alpine.LFD.0.999.0710161559150.6887@woody.linux-foundation.org> <20071017015109.303760cc@localhost.localdomain> <alpine.LFD.0.999.0710161722320.26902@woody.linux-foundation.org> <3A9408D5-2667-43A6-A0CE-C0720B3A3987@vicaya.com> <alpine.LFD.0.999.0710170849590.26902@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Luke Lu <git@vicaya.com>, Christer Weinigel <christer@weinigel.se>,
	Tom Tobin <korpios@korpios.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Oct 18 02:33:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IiJK3-0007Yg-BR
	for gcvg-git-2@gmane.org; Thu, 18 Oct 2007 02:33:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760048AbXJRAdA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Oct 2007 20:33:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760885AbXJRAdA
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Oct 2007 20:33:00 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2172 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759864AbXJRAc7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Oct 2007 20:32:59 -0400
Received: (qmail 31177 invoked by uid 111); 18 Oct 2007 00:32:58 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 17 Oct 2007 20:32:58 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 17 Oct 2007 20:32:56 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.999.0710170849590.26902@woody.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61447>

On Wed, Oct 17, 2007 at 08:53:55AM -0700, Linus Torvalds wrote:

> > Well, we just established that all-space is perfect, look-wise.
> 
> But we also established that an all-space model is not stable, because any 
> unix developers will start adding tabs instead of spaces.

In what way does an all-space model cause people to accidentally add
tabs, but an all-tab model does not cause people to accidentally add
spaces?

-Peff
