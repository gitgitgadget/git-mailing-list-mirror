From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] send-pack: improve error reporting for total remote
	unpack
Date: Sun, 18 Nov 2007 00:59:21 -0500
Message-ID: <20071118055920.GA19539@sigill.intra.peff.net>
References: <20071118055804.GA19313@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Daniel Barkalow <barkalow@iabervon.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 18 06:59:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ItdC2-00070v-Lh
	for gcvg-git-2@gmane.org; Sun, 18 Nov 2007 06:59:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751403AbXKRF7Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Nov 2007 00:59:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751383AbXKRF7Z
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Nov 2007 00:59:25 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4289 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750832AbXKRF7Y (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Nov 2007 00:59:24 -0500
Received: (qmail 8487 invoked by uid 111); 18 Nov 2007 05:59:23 -0000
Received: from ppp-216-106-96-70.storm.ca (HELO sigill.intra.peff.net) (216.106.96.70)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Sun, 18 Nov 2007 00:59:23 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 18 Nov 2007 00:59:21 -0500
Content-Disposition: inline
In-Reply-To: <20071118055804.GA19313@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65342>

> Subject: [PATCH] send-pack: improve error reporting for total remote unpack

Oops, the subject was supposed to be "...total remote _failure_".

-Peff
