From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 6/8] Docs: Arranged config options in man page
Date: Sat, 27 Sep 2008 23:15:51 -0400
Message-ID: <20080928031550.GA15696@sigill.intra.peff.net>
References: <1222564196-84202-1-git-send-email-mfwitten@mit.edu> <1222564196-84202-2-git-send-email-mfwitten@mit.edu> <1222564196-84202-3-git-send-email-mfwitten@mit.edu> <1222564196-84202-4-git-send-email-mfwitten@mit.edu> <1222564196-84202-5-git-send-email-mfwitten@mit.edu> <1222564196-84202-6-git-send-email-mfwitten@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: gitster@pobox.com, git@vger.kernel.org
To: Michael Witten <mfwitten@MIT.EDU>
X-From: git-owner@vger.kernel.org Sun Sep 28 05:17:06 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KjmmP-0005Sm-Dh
	for gcvg-git-2@gmane.org; Sun, 28 Sep 2008 05:17:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752439AbYI1DPy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Sep 2008 23:15:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752395AbYI1DPy
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Sep 2008 23:15:54 -0400
Received: from peff.net ([208.65.91.99]:1905 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752372AbYI1DPx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Sep 2008 23:15:53 -0400
Received: (qmail 2957 invoked by uid 111); 28 Sep 2008 03:15:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Sat, 27 Sep 2008 23:15:52 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 27 Sep 2008 23:15:51 -0400
Content-Disposition: inline
In-Reply-To: <1222564196-84202-6-git-send-email-mfwitten@mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96938>

On Sat, Sep 27, 2008 at 08:09:54PM -0500, Michael Witten wrote:

> Signed-off-by: Michael Witten <mfwitten@mit.edu>
> ---

Arranged in what way?  I assume alphabetized, but please make it clear
in the commit message.

Also, Junio is out of touch for a few weeks, so it probably makes sense
to send your patches to Shawn Pearce <spearce@spearce.org> in the
interim.

Also also, micronit: we usually use the imperative to describe patch
changes (i.e., "arrange" instead of "arranged").

-Peff
