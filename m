From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: MinGW port usable
Date: Tue, 30 Jan 2007 11:08:24 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701301107470.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <200701292320.43888.johannes.sixt@telecom.at> 
 <Pine.LNX.4.64.0701291438580.3611@woody.linux-foundation.org>
 <46d6db660701291508m4362eedchd4050e61f4989a92@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Christian MICHON <christian.michon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 30 11:08:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HBpuf-0001h9-Br
	for gcvg-git@gmane.org; Tue, 30 Jan 2007 11:08:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965375AbXA3KI0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 30 Jan 2007 05:08:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965394AbXA3KI0
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Jan 2007 05:08:26 -0500
Received: from mail.gmx.net ([213.165.64.20]:45033 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965375AbXA3KIZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jan 2007 05:08:25 -0500
Received: (qmail invoked by alias); 30 Jan 2007 10:08:24 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp018) with SMTP; 30 Jan 2007 11:08:24 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <46d6db660701291508m4362eedchd4050e61f4989a92@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38146>

Hi,

On Tue, 30 Jan 2007, Christian MICHON wrote:

> git-unpack and git-repack was slow as hell, though. Maybe this is the 
> part to be improved. Mostly bad I/Os...

How do you want to improve bad I/O on Windows?

Ciao,
Dscho
