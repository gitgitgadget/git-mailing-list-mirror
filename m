From: Jeff King <peff@peff.net>
Subject: Re: [BUGS] test failure in t4014-format-patch.sh with master
Date: Thu, 17 Apr 2008 12:27:00 -0400
Message-ID: <20080417162700.GB18318@sigill.intra.peff.net>
References: <87od88eslq.dlv@maison.homelinux.org> <alpine.LFD.1.00.0804170806430.2879@woody.linux-foundation.org> <20080417153421.GA13117@atjola.homenet> <alpine.LFD.1.00.0804170841270.2879@woody.linux-foundation.org> <20080417162421.GA18318@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?QmrDtnJu?= Steinbrink <B.Steinbrink@gmx.de>,
	Remi Vanicat <vanicat@debian.org>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Apr 17 18:55:12 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JmWxe-0004ff-V0
	for gcvg-git-2@gmane.org; Thu, 17 Apr 2008 18:27:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932332AbYDQQ1B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Apr 2008 12:27:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932313AbYDQQ1B
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Apr 2008 12:27:01 -0400
Received: from [208.65.91.99] ([208.65.91.99]:3163 "EHLO peff.net"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S932212AbYDQQ1A (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Apr 2008 12:27:00 -0400
Received: (qmail 24745 invoked by uid 111); 17 Apr 2008 16:26:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 17 Apr 2008 12:26:59 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 17 Apr 2008 12:27:00 -0400
Content-Disposition: inline
In-Reply-To: <20080417162421.GA18318@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79801>

On Thu, Apr 17, 2008 at 12:24:22PM -0400, Jeff King wrote:

> As Bjorn mentioned, it's POSIX.  Junio and I already hunted down quite a
> few of these, so I think we are OK in general, and this is just a new
> one that got introduced.

Oops, I meant to mention this thread:

  http://article.gmane.org/gmane.comp.version-control.git/48419

-Peff
