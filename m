From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] grep: --full-tree
Date: Fri, 27 Nov 2009 01:22:04 -0500
Message-ID: <20091127062203.GB20844@coredump.intra.peff.net>
References: <7vk4xggv27.fsf@alter.siamese.dyndns.org>
 <20091125203922.GA18487@coredump.intra.peff.net>
 <7viqcytjic.fsf@alter.siamese.dyndns.org>
 <20091125210034.GC18487@coredump.intra.peff.net>
 <7vmy2as319.fsf@alter.siamese.dyndns.org>
 <20091125214949.GA31473@coredump.intra.peff.net>
 <7vtywiqmbs.fsf@alter.siamese.dyndns.org>
 <20091125222625.GB2861@coredump.intra.peff.net>
 <7v8wdup2z2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 27 07:22:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDuDX-00049h-5f
	for gcvg-git-2@lo.gmane.org; Fri, 27 Nov 2009 07:22:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753130AbZK0GV4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Nov 2009 01:21:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752240AbZK0GV4
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Nov 2009 01:21:56 -0500
Received: from peff.net ([208.65.91.99]:43767 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751886AbZK0GVz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Nov 2009 01:21:55 -0500
Received: (qmail 24949 invoked by uid 107); 27 Nov 2009 06:26:27 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 27 Nov 2009 01:26:27 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 27 Nov 2009 01:22:04 -0500
Content-Disposition: inline
In-Reply-To: <7v8wdup2z2.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133859>

On Wed, Nov 25, 2009 at 04:02:57PM -0800, Junio C Hamano wrote:

> Yeah; what is your take on tr/reset-checkout-patch topic, by the way?  I
> do not particularly like a configuration that changes the behaviour of a
> command in a drastic way---it will make helping others much harder, but I
> guess it should be Ok?
> 
> This may sound like an OffTopic, but because we _are_ discussing
> consistency, it matters.

It is near the top of my to-review queue. Honestly, despite any
arguments I may have made when the original reset/checkout -p series was
posted, I have been pretty happy with the current behavior. I'll take a
look now and respond in more detail in that thread.

-Peff
