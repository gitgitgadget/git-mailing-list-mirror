From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 8/8] git-fetch-pack: Support multi_ack extension
Date: Fri, 28 Oct 2005 05:36:32 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0510280535480.1460@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0510280449240.20516@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Fri Oct 28 05:37:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EVL2j-00033k-Dj
	for gcvg-git@gmane.org; Fri, 28 Oct 2005 05:36:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965079AbVJ1Dge (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 27 Oct 2005 23:36:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965080AbVJ1Dge
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Oct 2005 23:36:34 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:25810 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S965079AbVJ1Dge (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Oct 2005 23:36:34 -0400
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 372B513F30D; Fri, 28 Oct 2005 05:36:33 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 17F5D9EFCF; Fri, 28 Oct 2005 05:36:33 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id C8F7185CB1; Fri, 28 Oct 2005 05:36:32 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id A84DE13F30D; Fri, 28 Oct 2005 05:36:32 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
In-Reply-To: <Pine.LNX.4.63.0510280449240.20516@wbgn013.biozentrum.uni-wuerzburg.de>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10752>

Hi,

never mind patch 7 and 8. I succeeded in fscking up again. Will patch 
tomorrow.

Ciao,
Dscho
