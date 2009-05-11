From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] gitk: use --textconv to generate diff text
Date: Mon, 11 May 2009 18:38:47 -0400
Message-ID: <20090511223847.GA22424@coredump.intra.peff.net>
References: <4A07D160.9020709@viscovery.net> <20090511091346.GA5685@coredump.intra.peff.net> <18952.40905.302916.243355@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Git Mailing List <git@vger.kernel.org>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Tue May 12 00:39:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3eA9-00086o-Hl
	for gcvg-git-2@gmane.org; Tue, 12 May 2009 00:39:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759556AbZEKWit (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 May 2009 18:38:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760242AbZEKWir
	(ORCPT <rfc822;git-outgoing>); Mon, 11 May 2009 18:38:47 -0400
Received: from peff.net ([208.65.91.99]:55444 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759667AbZEKWiq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 May 2009 18:38:46 -0400
Received: (qmail 29149 invoked by uid 107); 11 May 2009 22:39:07 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 11 May 2009 18:39:07 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 11 May 2009 18:38:47 -0400
Content-Disposition: inline
In-Reply-To: <18952.40905.302916.243355@cargo.ozlabs.ibm.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118859>

On Tue, May 12, 2009 at 07:59:37AM +1000, Paul Mackerras wrote:

> > I had trouble finding much discussion in the archive, but I think it may
> > not have been taken because we were in release freeze (and textconv was
> > a brand new feature in the release at the time).
> 
> Which release did --textconv first appear in?

v1.6.1

-Peff
