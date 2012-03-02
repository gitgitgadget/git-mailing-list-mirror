From: Jeff King <peff@peff.net>
Subject: Re: [git wiki PATCH 2/3] "Designing a faster index format" project
Date: Fri, 2 Mar 2012 06:08:45 -0500
Message-ID: <20120302110844.GA5748@sigill.intra.peff.net>
References: <57e8b4eb7a98af33982c2f3a763e18f62b1d6d6d.1330686331.git.trast@student.ethz.ch>
 <afdfa68348d8d98f2cb604d9c17dad6cd764066e.1330686331.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Mar 02 12:09:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3QM8-0003f3-4e
	for gcvg-git-2@plane.gmane.org; Fri, 02 Mar 2012 12:09:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932313Ab2CBLIw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Mar 2012 06:08:52 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:35279
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932307Ab2CBLIv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Mar 2012 06:08:51 -0500
Received: (qmail 18815 invoked by uid 107); 2 Mar 2012 11:08:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 02 Mar 2012 06:08:56 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 02 Mar 2012 06:08:45 -0500
Content-Disposition: inline
In-Reply-To: <afdfa68348d8d98f2cb604d9c17dad6cd764066e.1330686331.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192028>

On Fri, Mar 02, 2012 at 12:05:46PM +0100, Thomas Rast wrote:

> ---
>  SoC-2012-Ideas.md |   41 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)

Thanks, I've applied and pushed all three (but the index one is my
favorite).

-Peff
