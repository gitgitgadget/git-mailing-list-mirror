From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] config.txt: interactive.singlekey is used by...
Date: Sun, 1 May 2011 00:51:40 -0400
Message-ID: <20110501045140.GA13387@sigill.intra.peff.net>
References: <1304175241-30550-1-git-send-email-valentin.haenel@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git-List <git@vger.kernel.org>,
	Thomas Rast <trast@student.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>
To: Valentin Haenel <valentin.haenel@gmx.de>
X-From: git-owner@vger.kernel.org Sun May 01 06:51:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QGOdI-0002JW-Vg
	for gcvg-git-2@lo.gmane.org; Sun, 01 May 2011 06:51:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751146Ab1EAEvn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 May 2011 00:51:43 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:44245
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750764Ab1EAEvn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 May 2011 00:51:43 -0400
Received: (qmail 25514 invoked by uid 107); 1 May 2011 04:53:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 01 May 2011 00:53:25 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 01 May 2011 00:51:40 -0400
Content-Disposition: inline
In-Reply-To: <1304175241-30550-1-git-send-email-valentin.haenel@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172528>

On Sat, Apr 30, 2011 at 04:54:01PM +0200, Valentin Haenel wrote:

> Perhaps this incredibly useful setting should also be mentioned in manpages of
> git-{add,reset.stash}?

Yeah, that would probably make sense.

> Are git-{add,reset.stash} the only commands that the setting influences?

git-checkout also has a "-p" mode.

-Peff
