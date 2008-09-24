From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH] remove vim syntax highlighting in favor of upstream
Date: Wed, 24 Sep 2008 15:59:52 -0400
Message-ID: <20080924195952.GA17534@coredump.intra.peff.net>
References: <1222269726-15632-1-git-send-email-szeder@ira.uka.de> <20080924155745.GA3908@coredump.intra.peff.net> <20080924170154.GA6816@neumann> <20080924175315.GA10337@coredump.intra.peff.net> <20080924195658.GB6816@neumann>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: vim@tpope.info, "Shawn O. Pearce" <spearce@spearce.org>,
	git@vger.kernel.org
To: SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Wed Sep 24 22:01:13 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KiaXo-0006f1-3S
	for gcvg-git-2@gmane.org; Wed, 24 Sep 2008 22:01:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752000AbYIXT7z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 24 Sep 2008 15:59:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751995AbYIXT7z
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Sep 2008 15:59:55 -0400
Received: from peff.net ([208.65.91.99]:2988 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751436AbYIXT7y (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Sep 2008 15:59:54 -0400
Received: (qmail 23711 invoked by uid 111); 24 Sep 2008 19:59:53 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 24 Sep 2008 15:59:53 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 24 Sep 2008 15:59:52 -0400
Content-Disposition: inline
In-Reply-To: <20080924195658.GB6816@neumann>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96687>

On Wed, Sep 24, 2008 at 09:56:58PM +0200, SZEDER G=C3=A1bor wrote:

> vim 7.2 provides support not only for commit messages but also for
> other git-related filetypes.  I think it would be good to mention
> them, too, therefore I extended your patch with them.

I think that is a sensible change.

-Peff
