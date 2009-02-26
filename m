From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 00/21] git remote: set-head and new show output
Date: Thu, 26 Feb 2009 09:53:15 -0500
Message-ID: <20090226145315.GC9693@coredump.intra.peff.net>
References: <cover.1235546707.git.jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 26 15:55:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LchdO-0004rT-Cb
	for gcvg-git-2@gmane.org; Thu, 26 Feb 2009 15:54:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753573AbZBZOxT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Feb 2009 09:53:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753362AbZBZOxS
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Feb 2009 09:53:18 -0500
Received: from peff.net ([208.65.91.99]:45306 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753320AbZBZOxS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Feb 2009 09:53:18 -0500
Received: (qmail 5271 invoked by uid 107); 26 Feb 2009 14:53:42 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 26 Feb 2009 09:53:42 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 26 Feb 2009 09:53:15 -0500
Content-Disposition: inline
In-Reply-To: <cover.1235546707.git.jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111567>

On Wed, Feb 25, 2009 at 03:32:07AM -0500, Jay Soffian wrote:

> This series replaces three related topics from pu:
> 
>   js/remote-set-head
>   jk/head-lookup
>   js/remote-display

With the exception of my comments on 08/21, this looks ready for 'next'
to me. Though I have to admit, given the number of patches and the
number of times I've looked at these changes before, my eyes started to
glaze over near the end. ;)

> I signed off on Jeff's patches; please remove my SoB from those if it is
> inappropriate for me to have done so.

I think that is fine. It is really about "I think this code is OK
license-wise to go into the project". So if I SoB and you have no reason
to doubt me, and you didn't change anything (or you added minor things
which you would SoB), then your SoB makes sense.

-Peff
