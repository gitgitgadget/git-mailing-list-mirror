From: Thomas Glanzmann <thomas@glanzmann.de>
Subject: Re: GIT Packages for Debian Etch
Date: Tue, 19 Jun 2007 00:03:56 +0200
Message-ID: <20070618220356.GI16393@cip.informatik.uni-erlangen.de>
References: <20070618212524.GC16393@cip.informatik.uni-erlangen.de> <20070618212741.GA5938@artemis.internal.dc7.debconf.org> <20070618214852.GA13538@alinoe.com> <20070618215610.GG16393@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Carlo Wood <carlo@alinoe.com>, LKML <linux-kernel@vger.kernel.org>,
	GIT <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 19 00:04:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I0PKM-0006LG-N3
	for gcvg-git@gmane.org; Tue, 19 Jun 2007 00:04:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763137AbXFRWD7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Jun 2007 18:03:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762816AbXFRWD6
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Jun 2007 18:03:58 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:44344 "EHLO
	faui03.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1761431AbXFRWD5 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Jun 2007 18:03:57 -0400
Received: by faui03.informatik.uni-erlangen.de (Postfix, from userid 31401)
	id DDF843F3E2; Tue, 19 Jun 2007 00:03:56 +0200 (CEST)
Mail-Followup-To: Thomas Glanzmann <thomas@glanzmann.de>,
	Carlo Wood <carlo@alinoe.com>, LKML <linux-kernel@vger.kernel.org>,
	GIT <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20070618215610.GG16393@cip.informatik.uni-erlangen.de>
User-Agent: Mutt/1.5.15 (2007-05-02)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50421>

Hello,

* Thomas Glanzmann <thomas@glanzmann.de> [070618 23:56]:
> > It seems that this is only for etch (and sarge).  I run a mixed
> > Lenny/sid machine here. It doesn't necessarily work when I start to
> > install things for etch. Certainly not once testing upgrades its libc.
> > Or?

> true.

I guess not so true. Because debian had always compatibility libs. So I
guess when they bump the libc revision on sid, they provide a compat
library at the same time so that you're able to run the old binaries.
But don't nail me down on this one. But for the mean time you should be
good with the packages I provided in the previous e-mail for sure.

        Thomas
