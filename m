From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What's in git.git
Date: Thu, 9 Feb 2006 10:58:13 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0602091055540.24701@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7vslqtf2p1.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 09 10:58:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F78ZE-0002yG-RR
	for gcvg-git@gmane.org; Thu, 09 Feb 2006 10:58:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422649AbWBIJ6R (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Feb 2006 04:58:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422647AbWBIJ6R
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Feb 2006 04:58:17 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:5840 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1422649AbWBIJ6Q (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Feb 2006 04:58:16 -0500
Received: from virusscan.mail (amavis1.rz.uni-wuerzburg.de [132.187.3.48])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id ABD5514650D; Thu,  9 Feb 2006 10:58:13 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 9CB2AA1B;
	Thu,  9 Feb 2006 10:58:13 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 76B911411EC; Thu,  9 Feb 2006 10:58:13 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vslqtf2p1.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15800>

Hi,

On Wed, 8 Feb 2006, Junio C Hamano wrote:

> So I have created another branch, "next".

I never quite understood why you not just publish your topic branches. 
IMHO what you intend to put into "next" should be put into "master" 
anyway: everyone interested in git development should try the new features 
as early as possible. If there is a "whacky" feature, you can put it into 
"whacky/archexport" or something along the lines.

Ciao,
Dscho
