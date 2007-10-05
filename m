From: Jeff King <peff@peff.net>
Subject: Re: Many gits are offline this week
Date: Fri, 5 Oct 2007 14:33:33 -0400
Message-ID: <20071005183333.GF13757@coredump.intra.peff.net>
References: <20071005010448.GQ2137@spearce.org> <863awq5p1y.fsf@blue.stonehenge.com> <4d8e3fd30710050214j135260cn842ee7396a3d63c7@mail.gmail.com> <86tzp54sez.fsf@blue.stonehenge.com> <37fcd2780710050741x1760a585yeaa9023a8d8cdccf@mail.gmail.com> <20071005162029.GA18522@old.davidb.org> <37fcd2780710051019l37b3dde2p57f24fef27b62bf6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Randal L. Schwartz" <merlyn@stonehenge.com>, git@vger.kernel.org
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 05 20:34:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Idrzt-0005lY-80
	for gcvg-git-2@gmane.org; Fri, 05 Oct 2007 20:34:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758289AbXJESdi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Oct 2007 14:33:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754011AbXJESdi
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Oct 2007 14:33:38 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2329 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753593AbXJESdh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Oct 2007 14:33:37 -0400
Received: (qmail 3925 invoked by uid 111); 5 Oct 2007 18:33:34 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Fri, 05 Oct 2007 14:33:34 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 05 Oct 2007 14:33:33 -0400
Content-Disposition: inline
In-Reply-To: <37fcd2780710051019l37b3dde2p57f24fef27b62bf6@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60122>

On Fri, Oct 05, 2007 at 09:19:02PM +0400, Dmitry Potapov wrote:

> > "git-commit -a" also detects files that have been deleted, whereas
> > "git-add" does not.
> I just tried "git-add -u ." and it *does* detect deleted files.

IIRC, this was a fix by Junio recently, but I can't seem to find the
commit.

-Peff
