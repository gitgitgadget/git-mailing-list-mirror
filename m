From: Jeff King <peff@peff.net>
Subject: Re: [RFC2 9/9] send-email: signedoffcc -> signedoffbycc, but
	handle both
Date: Mon, 29 Sep 2008 13:44:45 -0400
Message-ID: <20080929174445.GA6015@coredump.intra.peff.net>
References: <20080929162935.GA2628@coredump.intra.peff.net> <1222710066-57768-1-git-send-email-mfwitten@mit.edu> <1222710066-57768-2-git-send-email-mfwitten@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Michael Witten <mfwitten@MIT.EDU>
X-From: git-owner@vger.kernel.org Mon Sep 29 19:45:58 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KkMon-0001nC-9O
	for gcvg-git-2@gmane.org; Mon, 29 Sep 2008 19:45:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751411AbYI2Ros (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Sep 2008 13:44:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751377AbYI2Ros
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Sep 2008 13:44:48 -0400
Received: from peff.net ([208.65.91.99]:3742 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751337AbYI2Ror (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Sep 2008 13:44:47 -0400
Received: (qmail 25924 invoked by uid 111); 29 Sep 2008 17:44:46 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Mon, 29 Sep 2008 13:44:46 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 29 Sep 2008 13:44:45 -0400
Content-Disposition: inline
In-Reply-To: <1222710066-57768-2-git-send-email-mfwitten@mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97037>

On Mon, Sep 29, 2008 at 12:41:06PM -0500, Michael Witten wrote:

> The documentation now mentions sendemail.signedoffbycc instead
> of sendemail.signedoffcc in order to match with the options
> --signed-off-by-cc; the code has been updated to reflect this
> as well, but sendemail.signedoffcc is still handled.

This new series looks fine to me.

-Peff
