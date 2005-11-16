From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Sourceforge doesn't like git cvsimport
Date: Thu, 17 Nov 2005 00:05:46 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0511170003390.9284@wbgn013.biozentrum.uni-wuerzburg.de>
References: <437B7416.8030704@zytor.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Nov 17 00:08:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EcWLh-0000iE-M3
	for gcvg-git@gmane.org; Thu, 17 Nov 2005 00:05:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030569AbVKPXFu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 16 Nov 2005 18:05:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030570AbVKPXFu
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Nov 2005 18:05:50 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:27861 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1030569AbVKPXFu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Nov 2005 18:05:50 -0500
Received: from wrzx34.rz.uni-wuerzburg.de (wrzx34.rz.uni-wuerzburg.de [132.187.3.34])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id E4A5613FAF7; Thu, 17 Nov 2005 00:05:46 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id C286BB520D; Thu, 17 Nov 2005 00:05:46 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 916F8B51FE; Thu, 17 Nov 2005 00:05:46 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 25FEE13FAF7; Thu, 17 Nov 2005 00:05:46 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <437B7416.8030704@zytor.com>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12063>

Hi,

On Wed, 16 Nov 2005, H. Peter Anvin wrote:

> : tazenda 23 ; telnet cvs.sourceforge.net 2401
> Trying 66.35.250.207...
> Connected to cvs.sourceforge.net.
> Escape character is '^]'.
> BEGIN AUTH REQUEST
> /cvsroot/bochs
> anonymous
> 
> END AUTH REQUEST
> cvs [pserver aborted]: descramble: unknown scrambling method
> Connection closed by foreign host.

I track a few projects from sourceforge. In the last two weeks they had 
serious problems, I often could not connect for more than a day. (And yes, 
I mean the anonymous CVS gateway, not the SSH which is only available to 
developers of that particular project.)

Usually I am lucky at 3am (+0200).

Ciao,
Dscho
