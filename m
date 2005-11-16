From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/3] C implementation of the 'git' program, take two.
Date: Wed, 16 Nov 2005 03:18:05 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0511160316510.14820@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20051115233125.3153B5BF76@nox.op5.se> <Pine.LNX.4.64.0511151603510.11232@g5.osdl.org>
 <437A8067.9050308@op5.se> <Pine.LNX.4.64.0511151751520.13959@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andreas Ericsson <ae@op5.se>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 16 03:18:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EcCss-0000ZY-D5
	for gcvg-git@gmane.org; Wed, 16 Nov 2005 03:18:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965182AbVKPCSI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 Nov 2005 21:18:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965183AbVKPCSI
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Nov 2005 21:18:08 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:30352 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S965182AbVKPCSG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Nov 2005 21:18:06 -0500
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 8762A13F256; Wed, 16 Nov 2005 03:18:05 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 69C3B9F309; Wed, 16 Nov 2005 03:18:05 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 55C469F1EA; Wed, 16 Nov 2005 03:18:05 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 3190313F256; Wed, 16 Nov 2005 03:18:05 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0511151751520.13959@g5.osdl.org>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11990>

Hi,

On Tue, 15 Nov 2005, Linus Torvalds wrote:

> Then, you just prepend it to the PATH, with a : in between (and if the 
> pathname has a ":" in it, tough, there's nothing we can do about it).

You mean like "c:/cygwin/git"? Yes, I know, the default is 
"/cygdrive/c/cygwin/git", but there are people out there with ":" in their 
pathname.

Ciao,
Dscho
