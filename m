From: Jeff King <peff@peff.net>
Subject: Re: [kernel.org users] [RFD] On deprecating "git-foo" for builtins
Date: Wed, 27 Aug 2008 17:22:17 -0400
Message-ID: <20080827212217.GA3554@sigill.intra.peff.net>
References: <20080826164526.GM26610@one.firstfloor.org> <20080826171012.GO10360@machine.or.cz> <20080826171255.GI26523@spearce.org> <20080826171623.GE5318@coredump.intra.peff.net> <20080826210631.GC3812@1wt.eu> <48B5B7F3.4080803@pobox.com> <20080827202707.GA25233@coredump.intra.peff.net> <48B5BB35.8090606@pobox.com> <20080827210555.GF18340@parisc-linux.org> <20080827211326.GI11734@cs181140183.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Matthew Wilcox <matthew@wil.cx>, Jeff Garzik <jgarzik@pobox.com>,
	Kristian H??gsberg <krh@redhat.com>,
	Matthias Kestenholz <mk@spinlock.ch>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	users@kernel.org, Andi Kleen <andi@firstfloor.org>,
	Petr Baudis <pasky@suse.cz>,
	Junio C Hamano <gitster@pobox.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Willy Tarreau <w@1wt.eu>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Adrian Bunk <bunk@kernel.org>
X-From: git-owner@vger.kernel.org Wed Aug 27 23:23:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYSU9-0001vG-Pn
	for gcvg-git-2@gmane.org; Wed, 27 Aug 2008 23:23:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752106AbYH0VWV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2008 17:22:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752095AbYH0VWV
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Aug 2008 17:22:21 -0400
Received: from peff.net ([208.65.91.99]:2964 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752064AbYH0VWU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2008 17:22:20 -0400
Received: (qmail 16807 invoked by uid 111); 27 Aug 2008 21:22:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Wed, 27 Aug 2008 17:22:19 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 27 Aug 2008 17:22:17 -0400
Content-Disposition: inline
In-Reply-To: <20080827211326.GI11734@cs181140183.pp.htv.fi>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93955>

On Thu, Aug 28, 2008 at 12:13:26AM +0300, Adrian Bunk wrote:

> BTW: I'd love to get a --pretty=noline

How about --pretty=format: ?

-Peff
