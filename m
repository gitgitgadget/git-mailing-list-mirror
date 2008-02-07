From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: Re: git-fetch in 1.5.4 fails versus 1.5.3.8
Date: Thu, 7 Feb 2008 15:23:22 +0100
Message-ID: <20080207142322.GC18497@mail-vs.djpig.de>
References: <pan.2008.02.04.18.25.26@progsoc.org> <20080205050741.GA4624@coredump.intra.peff.net> <pan.2008.02.06.21.56.35@progsoc.org> <20080207042332.GA7632@sigill.intra.peff.net> <pan.2008.02.07.10.15.05@progsoc.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Anand Kumria <wildfire@progsoc.org>
X-From: git-owner@vger.kernel.org Thu Feb 07 15:24:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JN7fa-0005Hv-Rd
	for gcvg-git-2@gmane.org; Thu, 07 Feb 2008 15:24:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754648AbYBGOXd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Feb 2008 09:23:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754845AbYBGOXc
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Feb 2008 09:23:32 -0500
Received: from pauli.djpig.de ([78.46.38.139]:34674 "EHLO pauli.djpig.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753164AbYBGOXc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Feb 2008 09:23:32 -0500
X-Greylist: delayed 793 seconds by postgrey-1.27 at vger.kernel.org; Thu, 07 Feb 2008 09:23:32 EST
Received: from localhost (localhost [127.0.0.1])
	by pauli.djpig.de (Postfix) with ESMTP id 173DE90072;
	Thu,  7 Feb 2008 15:23:31 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at pauli.djpig.de
Received: from pauli.djpig.de ([127.0.0.1])
	by localhost (pauli.djpig.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id w+n2t9H3Nunz; Thu,  7 Feb 2008 15:23:23 +0100 (CET)
Received: from mail-vs.djpig.de (mail-vs.djpig.de [78.47.136.189])
	by pauli.djpig.de (Postfix) with ESMTP id 125FA9006C;
	Thu,  7 Feb 2008 15:23:22 +0100 (CET)
Received: from djpig by mail-vs.djpig.de with local (Exim 4.63)
	(envelope-from <djpig@mail-vs.djpig.de>)
	id 1JN7es-0007IG-9n; Thu, 07 Feb 2008 15:23:22 +0100
Content-Disposition: inline
In-Reply-To: <pan.2008.02.07.10.15.05@progsoc.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72948>

On Thu, Feb 07, 2008 at 10:15:02AM +0000, Anand Kumria wrote:
> Gerrit - since I seem to be able to reproduce this fairly easily - would
> it be useful to you to have me do anything to track this down. Or will you
> switch the Debian build to openssl?

Since git has no OpenSSL link exception the resulting binary wouldn't be
distributable AFAIK.

Gruesse,
-- 
Frank Lichtenheld <frank@lichtenheld.de>
www: http://www.djpig.de/
