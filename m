From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Documentation: quote {non-attributes} for asciidoc
Date: Mon, 2 Jul 2007 23:23:54 -0400
Message-ID: <20070703032354.GA4213@coredump.intra.peff.net>
References: <20070702052459.GA2365@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 03 05:23:59 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5Yzf-0008M3-BH
	for gcvg-git@gmane.org; Tue, 03 Jul 2007 05:23:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752965AbXGCDX5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 Jul 2007 23:23:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752802AbXGCDX5
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jul 2007 23:23:57 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4036 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752699AbXGCDX4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jul 2007 23:23:56 -0400
Received: (qmail 25518 invoked from network); 3 Jul 2007 03:24:17 -0000
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by peff.net with (DHE-RSA-AES128-SHA encrypted) SMTP; 3 Jul 2007 03:24:17 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 02 Jul 2007 23:23:54 -0400
Content-Disposition: inline
In-Reply-To: <20070702052459.GA2365@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51445>

On Mon, Jul 02, 2007 at 01:24:59AM -0400, Jeff King wrote:

>  Documentation/git-branch.txt       |    2 +-
>  Documentation/git-checkout.txt     |    2 +-
>  Documentation/git-receive-pack.txt |   10 +++++-----
>  Documentation/git-rev-list.txt     |    4 ++--
>  Documentation/git-stash.txt        |    8 ++++----
>  5 files changed, 13 insertions(+), 13 deletions(-)

I should have noted: this change is on top of next (due to the git-stash
corrections), but I think the rest of it should go into master ASAP, as
it makes some of the documentation very difficult to read. It should be
trivial to split, but let me know if you want me to resend as two
patches.

-Peff
