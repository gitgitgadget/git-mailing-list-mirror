From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: qgit-0.3
Date: Sat, 04 Jun 2005 08:37:22 +1000
Message-ID: <1117838242.31082.165.camel@gaston>
References: <20050601111949.90043.qmail@web26303.mail.ukl.yahoo.com>
	 <1117770909.31082.121.camel@gaston>  <42A04AAA.4080205@gorzow.mm.pl>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 04 00:36:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DeKl9-0003IE-SG
	for gcvg-git@gmane.org; Sat, 04 Jun 2005 00:35:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261154AbVFCWic (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Jun 2005 18:38:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261155AbVFCWic
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Jun 2005 18:38:32 -0400
Received: from gate.crashing.org ([63.228.1.57]:34526 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261154AbVFCWi2 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Jun 2005 18:38:28 -0400
Received: from gaston (localhost [127.0.0.1])
	by gate.crashing.org (8.12.8/8.12.8) with ESMTP id j53MUGZn031614;
	Fri, 3 Jun 2005 17:30:17 -0500
To: Radoslaw Szkodzinski <astralstorm@gorzow.mm.pl>
In-Reply-To: <42A04AAA.4080205@gorzow.mm.pl>
X-Mailer: Evolution 2.2.2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, 2005-06-03 at 14:18 +0200, Radoslaw Szkodzinski wrote:

> It is buildable, but you need to install your own scons in the correct
> paths, e.g.
> on Gentoo:
> 
> emerge scons
> And then build it by hand with:
> ./configure
> scons
> 
> Then you get bin/qgit which is ready to run and/or copy.

Not on debian. Doesn't work with the disto's scons, says it can't find
qt (and libqt3-dev is installed)

Ben.

