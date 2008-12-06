From: Jeff King <peff@peff.net>
Subject: Re: git tag -s: TAG_EDITMSG should not be deleted upon failures
Date: Sat, 6 Dec 2008 14:42:30 -0500
Message-ID: <20081206194230.GB18418@coredump.intra.peff.net>
References: <4936AB74.3090901@jaeger.mine.nu> <20081206194034.GA18418@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Christian Jaeger <christian@jaeger.mine.nu>
X-From: git-owner@vger.kernel.org Sat Dec 06 20:43:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L9349-0002dU-8W
	for gcvg-git-2@gmane.org; Sat, 06 Dec 2008 20:43:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752614AbYLFTmd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Dec 2008 14:42:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752356AbYLFTmc
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Dec 2008 14:42:32 -0500
Received: from peff.net ([208.65.91.99]:4080 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752599AbYLFTmc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Dec 2008 14:42:32 -0500
Received: (qmail 6936 invoked by uid 111); 6 Dec 2008 19:42:31 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sat, 06 Dec 2008 14:42:31 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 06 Dec 2008 14:42:30 -0500
Content-Disposition: inline
In-Reply-To: <20081206194034.GA18418@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102471>

On Sat, Dec 06, 2008 at 02:40:34PM -0500, Jeff King wrote:

> Subject: Re: git tag -s: TAG_EDITMSG should not be deleted upon failures
>
> tag: delete TAG_EDITMSG only on successful tag

Oops, of course I bungled the subject here, and the email subject should
simply be ignored.

-Peff
