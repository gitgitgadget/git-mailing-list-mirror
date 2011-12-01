From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] compat/getpass.c: Fix a sparse "symbol not declared"
 warning
Date: Thu, 1 Dec 2011 13:19:57 -0500
Message-ID: <20111201181957.GA29456@sigill.intra.peff.net>
References: <4ED69803.6070508@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Thu Dec 01 19:20:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RWBEv-0000gr-M2
	for gcvg-git-2@lo.gmane.org; Thu, 01 Dec 2011 19:20:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756042Ab1LASUB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Dec 2011 13:20:01 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:59206
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755672Ab1LASUB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Dec 2011 13:20:01 -0500
Received: (qmail 18673 invoked by uid 107); 1 Dec 2011 18:26:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 01 Dec 2011 13:26:35 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 01 Dec 2011 13:19:57 -0500
Content-Disposition: inline
In-Reply-To: <4ED69803.6070508@ramsay1.demon.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186181>

On Wed, Nov 30, 2011 at 08:54:27PM +0000, Ramsay Jones wrote:

> When you next re-roll your most recent credentials/getpass series, could
> you please squash this patch in. (This patch was against pu @ 1cc922af,
> but I guess you need to apply a similar patch to commit 8eca119c "stub out
> getpass_echo function", 27-11-2011 instead)

Sure, makes sense. Thanks.

-Peff
