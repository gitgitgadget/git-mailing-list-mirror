From: Jeff King <peff@peff.net>
Subject: Re: SVN -> Git *but* with special changes
Date: Sun, 8 Jan 2012 00:10:51 -0500
Message-ID: <20120108051051.GA10129@sigill.intra.peff.net>
References: <1317227849979-6840904.post@n2.nabble.com>
 <20110928190445.GC1482@sigill.intra.peff.net>
 <1325999031923-7163706.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Abscissa <bus_nabble_git@semitwist.com>
X-From: git-owner@vger.kernel.org Sun Jan 08 06:11:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rjl2O-0006Ir-1G
	for gcvg-git-2@lo.gmane.org; Sun, 08 Jan 2012 06:11:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751113Ab2AHFKy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Jan 2012 00:10:54 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:60205
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750775Ab2AHFKy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jan 2012 00:10:54 -0500
Received: (qmail 21512 invoked by uid 107); 8 Jan 2012 05:17:46 -0000
Received: from sigill-wired.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.8)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 08 Jan 2012 00:17:46 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 08 Jan 2012 00:10:51 -0500
Content-Disposition: inline
In-Reply-To: <1325999031923-7163706.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188092>

On Sat, Jan 07, 2012 at 09:03:51PM -0800, Abscissa wrote:

> However, I suspect that script may not be my problem at all: If I do this:
> 
> git svn help | grep preserve
> 
> I get absolutely nothing. There doesn't seem to be a
> "--preserve-empty-dirs".

What version of git are you using? That option was added in git 1.7.7.

-Peff
