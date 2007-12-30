From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Optimize prefixcmp()
Date: Sun, 30 Dec 2007 16:54:00 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0712301653360.14355@wbgn129.biozentrum.uni-wuerzburg.de>
References: <e5bfff550712291001q5f246ceah6700b98308fb96f1@mail.gmail.com> 
 <Pine.LNX.4.64.0712292019450.14355@wbgn129.biozentrum.uni-wuerzburg.de> 
 <e5bfff550712291239y5648b923y8d332d9c40a8c97b@mail.gmail.com> 
 <Pine.LNX.4.64.0712292307210.14355@wbgn129.biozentrum.uni-wuerzburg.de>
 <e5bfff550712300502p543680b9jbeb9469a5a970f0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 30 16:54:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J90Uf-0007xH-Pt
	for gcvg-git-2@gmane.org; Sun, 30 Dec 2007 16:54:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756211AbXL3PyE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Dec 2007 10:54:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756204AbXL3PyE
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Dec 2007 10:54:04 -0500
Received: from mail.gmx.net ([213.165.64.20]:44119 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756171AbXL3PyC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Dec 2007 10:54:02 -0500
Received: (qmail invoked by alias); 30 Dec 2007 15:54:00 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO wrzx67.rz.uni-wuerzburg.de) [132.187.25.128]
  by mail.gmx.net (mp035) with SMTP; 30 Dec 2007 16:54:00 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+7dVhs1+O7bWsoiE3WVP28BgndrC/ccTFvFkH18q
	+PvgxsFmLfjnq3
X-X-Sender: gene099@wbgn129.biozentrum.uni-wuerzburg.de
In-Reply-To: <e5bfff550712300502p543680b9jbeb9469a5a970f0@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69369>

Hi,

On Sun, 30 Dec 2007, Marco Costalba wrote:

> Initial patch by Johannes Schindelin.

Not true ;-)

Ciao,
Dscho
