From: Jeff King <peff@peff.net>
Subject: Re: git ML archive for download
Date: Tue, 29 Apr 2008 14:53:03 -0400
Message-ID: <20080429185302.GB19428@sigill.intra.peff.net>
References: <4d44224d0804270017j4e290cb4jdadc21a83602f203@mail.gmail.com> <20080427072123.GA6163@sigill.intra.peff.net> <loom.20080428T140950-459@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Frederik Hohlfeld <frederik.hohlfeld@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 29 20:55:02 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jquyj-0006H1-UM
	for gcvg-git-2@gmane.org; Tue, 29 Apr 2008 20:55:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763972AbYD2SxH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2008 14:53:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763967AbYD2SxG
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Apr 2008 14:53:06 -0400
Received: from peff.net ([208.65.91.99]:1130 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763949AbYD2SxF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2008 14:53:05 -0400
Received: (qmail 5497 invoked by uid 111); 29 Apr 2008 18:53:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 29 Apr 2008 14:53:03 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Apr 2008 14:53:03 -0400
Content-Disposition: inline
In-Reply-To: <loom.20080428T140950-459@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80718>

On Mon, Apr 28, 2008 at 02:11:00PM +0000, Frederik Hohlfeld wrote:

> > http://gmane.org/export.php
> 
> Thanks, I really missed that.
> 
> Alas, it doesn't let me download many articles, and Gmane doesn't seem to have
> the list from the beginning, right?

It does let you download many. In theory, you could do:

  http://download.gmane.org/gmane.comp.version-control.git/1/80000

but it seems they have a per-request cap on processing time, so you have
to do it in chunks. I have done so, and an mbox of articles 1-80000 is
here:

  http://www.cc.gatech.edu/~peff/git-list-archive.mbox.bz2

It's about 57M. Note that the list is currently up to ~80600 or so;
fetching the rest is left as an exercise to the reader.

-Peff
