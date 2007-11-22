From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] rebase -i: move help to end of todo file
Date: Thu, 22 Nov 2007 07:31:37 -0500
Message-ID: <20071122123137.GG10389@sigill.intra.peff.net>
References: <7vlk8q7hzg.fsf@gitster.siamese.dyndns.org> <Pine.LNX.4.64.0711221113360.27959@racer.site> <7vbq9m5wpa.fsf@gitster.siamese.dyndns.org> <Pine.LNX.4.64.0711221225570.27959@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Nov 22 13:31:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IvBDo-0005eS-P5
	for gcvg-git-2@gmane.org; Thu, 22 Nov 2007 13:31:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751711AbXKVMbj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Nov 2007 07:31:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751506AbXKVMbj
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Nov 2007 07:31:39 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4234 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751253AbXKVMbj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Nov 2007 07:31:39 -0500
Received: (qmail 23613 invoked by uid 111); 22 Nov 2007 12:31:38 -0000
Received: from c-24-125-35-113.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (24.125.35.113)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 22 Nov 2007 07:31:38 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 22 Nov 2007 07:31:37 -0500
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0711221225570.27959@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65819>

On Thu, Nov 22, 2007 at 12:30:10PM +0000, Johannes Schindelin wrote:

> I meant to "move" everything.  Sorry.
> 
> > but leaving the single line at the beginning is not an improvement.  
> > What's on that single line is not particularly useful but that is a 
> > separate issue.
> 
> Okay, so you'd like this better?

I like it much better (I was about to send the same complaint about the
top line, but Junio beat me to it).

-Peff
