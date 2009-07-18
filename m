From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] Re: show: suppress extra newline when showing
 annotated tag
Date: Fri, 17 Jul 2009 23:47:10 -0400
Message-ID: <20090718034710.GA18873@coredump.intra.peff.net>
References: <20090717231622.GA13511@coredump.intra.peff.net>
 <20090717231834.GA13624@coredump.intra.peff.net>
 <20090718032527.GA16708@vidovic>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
X-From: git-owner@vger.kernel.org Sat Jul 18 05:47:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MS0tS-0005Ja-Pm
	for gcvg-git-2@gmane.org; Sat, 18 Jul 2009 05:47:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757603AbZGRDrQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jul 2009 23:47:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757419AbZGRDrQ
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Jul 2009 23:47:16 -0400
Received: from peff.net ([208.65.91.99]:44418 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757222AbZGRDrQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jul 2009 23:47:16 -0400
Received: (qmail 30637 invoked by uid 107); 18 Jul 2009 03:49:15 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 17 Jul 2009 23:49:15 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 17 Jul 2009 23:47:10 -0400
Content-Disposition: inline
In-Reply-To: <20090718032527.GA16708@vidovic>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123507>

On Sat, Jul 18, 2009 at 05:25:27AM +0200, Nicolas Sebrecht wrote:

> I can't see the double-newline.
> [...]
> I guess you meant:
> 
>      $ git show v1.6.3
>      tag v1.6.3
>      Tagger: Junio C Hamano <gitster@pobox.com>
>      Date:   Wed May 6 18:16:47 2009 -0700
> 
>  
>      GIT 1.6.3
>      -----BEGIN PGP SIGNATURE-----
>      ...

Urgh, sorry, yes. I accidentally cut-and-pasted from the _fixed_
version. :)

-Peff
