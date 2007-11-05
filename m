From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] errors: "strict subset" -> "ancestor"
Date: Mon, 5 Nov 2007 16:28:09 -0500
Message-ID: <20071105212808.GB9520@sigill.intra.peff.net>
References: <20071103023944.GA15379@fieldses.org> <A4169B7B-C05B-4CA0-B41B-E1E2D71491B6@zib.de> <ee77f5c20711030014x23ac6206rec81fe5968992147@mail.gmail.com> <E7B0CBAA-BB97-40A0-8CFB-A6F01A047D17@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Symonds <dsymonds@gmail.com>,
	Steffen Prohaska <prohaska@zib.de>,
	"J. Bruce Fields" <bfields@fieldses.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Mon Nov 05 22:28:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ip9Ug-00044n-BH
	for gcvg-git-2@gmane.org; Mon, 05 Nov 2007 22:28:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753574AbXKEV2M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Nov 2007 16:28:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753420AbXKEV2M
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Nov 2007 16:28:12 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4730 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752467AbXKEV2L (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Nov 2007 16:28:11 -0500
Received: (qmail 25336 invoked by uid 111); 5 Nov 2007 21:28:10 -0000
Received: from c-24-125-35-113.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (24.125.35.113)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Mon, 05 Nov 2007 16:28:10 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 05 Nov 2007 16:28:09 -0500
Content-Disposition: inline
In-Reply-To: <E7B0CBAA-BB97-40A0-8CFB-A6F01A047D17@wincent.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63559>

On Mon, Nov 05, 2007 at 02:06:35PM +0100, Wincent Colaiuta wrote:

> Kind of: it aligns "error:" with "local":
>
> 	error: remote 'refs/heads/master' is not an ancestor of
> 	 local 'refs/heads/master'.

FYI, in the thread 'more terse push output', there is discussion of
eliminating this message entirely. So I wanted to point readers of this
thread in that direction.

-Peff
