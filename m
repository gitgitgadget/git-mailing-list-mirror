From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Makefile: enable THREADED_DELTA_SEARCH on SunOS
Date: Tue, 6 Oct 2009 22:42:21 -0400
Message-ID: <20091007024221.GA10442@coredump.intra.peff.net>
References: <mMewRoxOZmBOCPocSz21A5zYKJozFCOnBBMfDefojFl0CJbciZjKAX7fE8hBoRYahowcn4j9VisPKCj9cOHGaw@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: gitster@pobox.com, git@vger.kernel.org,
	Brandon Casey <drafnel@gmail.com>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Wed Oct 07 04:46:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MvMXl-0002n9-Lq
	for gcvg-git-2@lo.gmane.org; Wed, 07 Oct 2009 04:46:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752263AbZJGCnG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Oct 2009 22:43:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752009AbZJGCnC
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Oct 2009 22:43:02 -0400
Received: from peff.net ([208.65.91.99]:49841 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750845AbZJGCm7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Oct 2009 22:42:59 -0400
Received: (qmail 29189 invoked by uid 107); 7 Oct 2009 02:45:50 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 06 Oct 2009 22:45:50 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 06 Oct 2009 22:42:21 -0400
Content-Disposition: inline
In-Reply-To: <mMewRoxOZmBOCPocSz21A5zYKJozFCOnBBMfDefojFl0CJbciZjKAX7fE8hBoRYahowcn4j9VisPKCj9cOHGaw@cipher.nrlssc.navy.mil>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129637>

On Tue, Oct 06, 2009 at 08:02:22PM -0500, Brandon Casey wrote:

> Any objections?  I've been compiling with THREADED_DELTA_SEARCH since I've
> been compiling on Solaris with no problems.

No complaint here. It seems to build and run fine on my pretty vanilla
Solaris 8 setup.

-Peff
