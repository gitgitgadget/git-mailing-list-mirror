From: Jon Loeliger <jdl@freescale.com>
Subject: Re: git binary size...
Date: Fri, 20 Jan 2006 12:00:09 -0600
Message-ID: <1137780009.17872.229.camel@cashmere.sps.mot.com>
References: <Pine.LNX.4.64.0601111021450.5073@g5.osdl.org>
	 <43C558FB.3030102@op5.se> <Pine.LNX.4.64.0601111134560.5073@g5.osdl.org>
	 <2cd57c900601120215pdb5da27l@mail.gmail.com> <43C65E70.7090702@op5.se>
	 <Pine.LNX.4.64.0601121013030.3535@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Jan 20 19:00:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F00Yb-0004Ee-Ed
	for gcvg-git@gmane.org; Fri, 20 Jan 2006 19:00:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751128AbWATSAN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Jan 2006 13:00:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751127AbWATSAN
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jan 2006 13:00:13 -0500
Received: from az33egw02.freescale.net ([192.88.158.103]:51705 "EHLO
	az33egw02.freescale.net") by vger.kernel.org with ESMTP
	id S1751126AbWATSAL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jan 2006 13:00:11 -0500
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id k0KICESe002776
	for <git@vger.kernel.org>; Fri, 20 Jan 2006 11:12:14 -0700 (MST)
Received: from [10.82.19.2] (cashmere.am.freescale.net [10.82.19.2])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id k0KI8PXY017637
	for <git@vger.kernel.org>; Fri, 20 Jan 2006 12:08:26 -0600 (CST)
To: Git List <git@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0601121013030.3535@g5.osdl.org>
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.ydl.1) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14970>

On Thu, 2006-01-12 at 12:13, Linus Torvalds wrote:

> More importantly, autoconf is a worse hack than _any_ of the config hacks 
> we do currently.
> 
> Repeat after me: "autoconf is crap"

Autoconf is also extraordinarily painful.

If there is actually enough configuration stuff needed,
would there be interest in a Kconfig-like mechanism?
I could spare time that into existence, perhaps...?

jdl
