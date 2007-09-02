From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add a new lstat implementation based on Win32 API, and
 make stat use that implementation too.
Date: Mon, 3 Sep 2007 00:02:10 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709030001030.28586@racer.site>
References: <46DACD93.9000509@trolltech.com> <200709022228.00733.robin.rosenberg.lists@dewire.com>
 <Pine.LNX.4.64.0709022133190.28586@racer.site> <200709022342.42733.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Marius Storm-Olsen <marius@trolltech.com>,
	Johannes Sixt <johannes.sixt@telecom.at>, git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Mon Sep 03 01:02:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRySz-0001Kk-Jh
	for gcvg-git@gmane.org; Mon, 03 Sep 2007 01:02:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932102AbXIBXCY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Sep 2007 19:02:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752741AbXIBXCY
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Sep 2007 19:02:24 -0400
Received: from mail.gmx.net ([213.165.64.20]:60497 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752327AbXIBXCX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Sep 2007 19:02:23 -0400
Received: (qmail invoked by alias); 02 Sep 2007 23:02:21 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp036) with SMTP; 03 Sep 2007 01:02:21 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19L71sdwOZL/8SHfyYLebXGmTxajLPEDxp433/iYv
	71wecYMXH5bwIs
X-X-Sender: gene099@racer.site
In-Reply-To: <200709022342.42733.robin.rosenberg.lists@dewire.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57400>

Hi,

On Sun, 2 Sep 2007, Robin Rosenberg wrote:

> You actually need admin privileges too, but I don't know any windows 
> developer who hasn't got that.

Like almost every developer in the corporate world?

Fact is: this support of symlinks is ridiculous.  Why not just admit it?

Ciao,
Dscho
