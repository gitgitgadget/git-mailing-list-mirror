From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Add warning about known issues to documentation of
	cvsimport
Date: Tue, 31 Mar 2009 07:28:12 -0400
Message-ID: <20090331112812.GA2090@coredump.intra.peff.net>
References: <20090323195304.GC26678@macbook.lan> <20090324031448.GA12829@coredump.intra.peff.net> <20090330223646.GC68118@macbook.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Tue Mar 31 13:30:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LocAH-0005gL-Eq
	for gcvg-git-2@gmane.org; Tue, 31 Mar 2009 13:29:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756320AbZCaL20 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Mar 2009 07:28:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756139AbZCaL2Y
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Mar 2009 07:28:24 -0400
Received: from peff.net ([208.65.91.99]:50961 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756525AbZCaL2Y (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Mar 2009 07:28:24 -0400
Received: (qmail 9655 invoked by uid 107); 31 Mar 2009 11:28:38 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 31 Mar 2009 07:28:38 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 31 Mar 2009 07:28:12 -0400
Content-Disposition: inline
In-Reply-To: <20090330223646.GC68118@macbook.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115251>

On Tue, Mar 31, 2009 at 12:36:46AM +0200, Heiko Voigt wrote:

> > Note the extra blank line between each heading and its list, and the
> > lack of a blank line between the end of the first list and the heading
> > of the second. Your source is very readable, so it really is just
> > asciidoc being silly, but I wonder if there is a way to work around
> > that.
> 
> My xmlto is not working at the moment. I will check that.

I looked into it a little more; it happens all over the place, so it is
a problem somewhere in the documentation toolchain. So don't worry about
it for this particular patch.

-Peff
