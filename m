From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/6] Remove function prototypes from git-send-email.perl
Date: Sun, 3 May 2009 16:27:14 -0400
Message-ID: <20090503202714.GD20468@coredump.intra.peff.net>
References: <1241010743-7020-1-git-send-email-wfp5p@virginia.edu> <1241010743-7020-2-git-send-email-wfp5p@virginia.edu> <1241010743-7020-3-git-send-email-wfp5p@virginia.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com
To: Bill Pemberton <wfp5p@virginia.edu>
X-From: git-owner@vger.kernel.org Sun May 03 22:27:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M0iHS-00047j-H6
	for gcvg-git-2@gmane.org; Sun, 03 May 2009 22:27:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755474AbZECU1P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 May 2009 16:27:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755352AbZECU1P
	(ORCPT <rfc822;git-outgoing>); Sun, 3 May 2009 16:27:15 -0400
Received: from peff.net ([208.65.91.99]:60911 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754190AbZECU1O (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 May 2009 16:27:14 -0400
Received: (qmail 14352 invoked by uid 107); 3 May 2009 20:27:30 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 03 May 2009 16:27:30 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 03 May 2009 16:27:14 -0400
Content-Disposition: inline
In-Reply-To: <1241010743-7020-3-git-send-email-wfp5p@virginia.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118189>

On Wed, Apr 29, 2009 at 09:12:19AM -0400, Bill Pemberton wrote:

> Use of function prototypes is considered bad practice in perl.  The
> ones used here didn't accomplish anything anyhow, so they've been
> removed.
> 
> Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>

I think this one is sensible.

-Peff
