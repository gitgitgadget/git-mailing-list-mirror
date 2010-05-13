From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC resend] diff-options: make --patch a synonym for -p
Date: Thu, 13 May 2010 07:45:54 -0400
Message-ID: <20100513114554.GA10963@coredump.intra.peff.net>
References: <1273741140.2516.15.camel@wpalmer.simply-domain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com
To: Will Palmer <wmpalmer@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 13 13:46:06 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OCWre-0005JU-4a
	for gcvg-git-2@lo.gmane.org; Thu, 13 May 2010 13:46:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753928Ab0EMLp7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 May 2010 07:45:59 -0400
Received: from peff.net ([208.65.91.99]:41769 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751931Ab0EMLp6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 May 2010 07:45:58 -0400
Received: (qmail 17016 invoked by uid 107); 13 May 2010 11:45:57 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 13 May 2010 07:45:57 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 13 May 2010 07:45:54 -0400
Content-Disposition: inline
In-Reply-To: <1273741140.2516.15.camel@wpalmer.simply-domain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146990>

On Thu, May 13, 2010 at 09:59:00AM +0100, Will Palmer wrote:

> Here we simply make --patch a synonym for -p, whose mnemonic was "patch"
> all along.

Yeah, makes sense to me. We already have --patch-with-stat and
--patch-with-raw (even though they are just historical), so clearly
--patch is the obvious choice.

> Re-sending, as this seems to have slipped under the radar last time.

Junio is incommunicado for a bit. I don't know how able he'll be to comb
through the list once he gets back, so you may need to an eye out and
resend again in a week or so. :)

-Peff
