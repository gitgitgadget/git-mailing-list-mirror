From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] contrib/vim: change URL to point to the latest syntax
	files
Date: Tue, 13 Jan 2009 02:56:07 -0500
Message-ID: <20090113075607.GA15941@coredump.intra.peff.net>
References: <200901130310.26727.markus.heidelberg@web.de> <20090113071623.GB12631@coredump.intra.peff.net> <8763kjej3p.fsf@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Markus Heidelberg <markus.heidelberg@web.de>, git@vger.kernel.org
To: Teemu Likonen <tlikonen@iki.fi>
X-From: git-owner@vger.kernel.org Tue Jan 13 08:57:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMe9V-0001BO-Ve
	for gcvg-git-2@gmane.org; Tue, 13 Jan 2009 08:57:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752840AbZAMH4M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jan 2009 02:56:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752694AbZAMH4J
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Jan 2009 02:56:09 -0500
Received: from peff.net ([208.65.91.99]:46900 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752670AbZAMH4J (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jan 2009 02:56:09 -0500
Received: (qmail 26733 invoked by uid 107); 13 Jan 2009 07:56:09 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 13 Jan 2009 02:56:09 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 13 Jan 2009 02:56:07 -0500
Content-Disposition: inline
In-Reply-To: <8763kjej3p.fsf@iki.fi>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105467>

On Tue, Jan 13, 2009 at 09:54:50AM +0200, Teemu Likonen wrote:

> Vim is essentially just a one-man project and the maintainer doesn't use
> version control system. He just piles "diff -c" -type patches on top of
> the previous release and sends them to vim-dev mailing list and to some
> FTP site. Then other people try to maintain VCS repositories based on
> the patches and resources that are available.
> 
> Vim's bus factor: 1

Ah. He should use git. ;)

Thanks for the explanation.

-Peff
