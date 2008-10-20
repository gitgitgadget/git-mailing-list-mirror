From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] fix for "index-pack: rationalize delta resolution code"
Date: Mon, 20 Oct 2008 16:10:44 -0400
Message-ID: <20081020201044.GA20244@coredump.intra.peff.net>
References: <alpine.LFD.2.00.0810201357340.26244@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Tue Oct 21 00:48:14 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ks16e-0000wq-1j
	for gcvg-git-2@gmane.org; Mon, 20 Oct 2008 22:12:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752973AbYJTUKr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Oct 2008 16:10:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752909AbYJTUKr
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Oct 2008 16:10:47 -0400
Received: from peff.net ([208.65.91.99]:4705 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752856AbYJTUKr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Oct 2008 16:10:47 -0400
Received: (qmail 15611 invoked by uid 111); 20 Oct 2008 20:10:46 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Mon, 20 Oct 2008 16:10:46 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 20 Oct 2008 16:10:44 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0810201357340.26244@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98737>

On Mon, Oct 20, 2008 at 02:12:04PM -0400, Nicolas Pitre wrote:

> Could anyone having problems fetching from kernel.org with git from the 
> next branch confirm that this also fixes that? Thanks.

Nope, this does not fix it for me.

-Peff
