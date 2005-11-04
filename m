From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: little conundrum
Date: Fri, 4 Nov 2005 01:41:56 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0511040141100.6044@wbgn013.biozentrum.uni-wuerzburg.de>
References: <200511031741.20496.alan@chandlerfamily.org.uk>
 <Pine.LNX.4.63.0511031845410.3435@wbgn013.biozentrum.uni-wuerzburg.de>
 <200511032202.18900.alan@chandlerfamily.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 04 01:43:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EXpeu-0005ps-EI
	for gcvg-git@gmane.org; Fri, 04 Nov 2005 01:42:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161008AbVKDAl6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 3 Nov 2005 19:41:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161002AbVKDAl6
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Nov 2005 19:41:58 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:43744 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1161008AbVKDAl5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Nov 2005 19:41:57 -0500
Received: from wrzx34.rz.uni-wuerzburg.de (wrzx34.rz.uni-wuerzburg.de [132.187.3.34])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 87FDD13F169; Fri,  4 Nov 2005 01:41:56 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 6AFA4B4FF0; Fri,  4 Nov 2005 01:41:56 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 4A48759CA8; Fri,  4 Nov 2005 01:41:56 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 1CB9E13F169; Fri,  4 Nov 2005 01:41:56 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Alan Chandler <alan@chandlerfamily.org.uk>
In-Reply-To: <200511032202.18900.alan@chandlerfamily.org.uk>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11112>

Hi,

On Thu, 3 Nov 2005, Alan Chandler wrote:

> Also untested, but what about removing the files from the index that 
> aren't in the working directory?

IIRC "git-commit -a" includes "git-update-index --remove".

Hth,
Dscho
