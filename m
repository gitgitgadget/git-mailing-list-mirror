From: Jeff King <peff@peff.net>
Subject: Re: [BUG?] Fail to pull from kernel.org: pack has bad object
Date: Mon, 20 Oct 2008 13:56:48 -0400
Message-ID: <20081020175648.GB18539@coredump.intra.peff.net>
References: <200810201010.29173.johan@herland.net> <20081020121533.GA2177@coredump.intra.peff.net> <alpine.LFD.2.00.0810200955250.26244@xanadu.home> <200810201610.54427.trast@student.ethz.ch> <alpine.LFD.2.00.0810201112360.26244@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Rast <trast@student.ethz.ch>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Tue Oct 21 00:28:20 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Krz11-0004um-Ef
	for gcvg-git-2@gmane.org; Mon, 20 Oct 2008 19:58:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752195AbYJTR4v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Oct 2008 13:56:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752084AbYJTR4v
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Oct 2008 13:56:51 -0400
Received: from peff.net ([208.65.91.99]:4481 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751352AbYJTR4v (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Oct 2008 13:56:51 -0400
Received: (qmail 14561 invoked by uid 111); 20 Oct 2008 17:56:49 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Mon, 20 Oct 2008 13:56:49 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 20 Oct 2008 13:56:48 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0810201112360.26244@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98728>

On Mon, Oct 20, 2008 at 01:49:33PM -0400, Nicolas Pitre wrote:

> >   http://n.ethz.ch/~trast/download/tmp_pack_NMj69p
> 
> Yes, except I can't resolve any of the deltas in there...  Is it from 
> the Linux kernel repository?

I don't know about Thomas's example, but this one is from git.git:

  http://peff.net/tmp_pack_c7KnC6

-Peff
