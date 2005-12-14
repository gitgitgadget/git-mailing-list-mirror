From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: RE: new file leaked onto release branch
Date: Thu, 15 Dec 2005 00:34:45 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0512150034120.8992@wbgn013.biozentrum.uni-wuerzburg.de>
References: <F7DC2337C7631D4386A2DF6E8FB22B30056B8748@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 15 00:36:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Emg96-0000X3-9P
	for gcvg-git@gmane.org; Thu, 15 Dec 2005 00:34:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965066AbVLNXet (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Dec 2005 18:34:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965086AbVLNXet
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Dec 2005 18:34:49 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:54926 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S965066AbVLNXes (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Dec 2005 18:34:48 -0500
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id A162313FC43; Thu, 15 Dec 2005 00:34:45 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 8A4AA9DDE1; Thu, 15 Dec 2005 00:34:45 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 78FAF9DDDC; Thu, 15 Dec 2005 00:34:45 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 15E8813FC43; Thu, 15 Dec 2005 00:34:45 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: "Brown, Len" <len.brown@intel.com>
In-Reply-To: <F7DC2337C7631D4386A2DF6E8FB22B30056B8748@hdsmsx401.amr.corp.intel.com>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13657>

Hi,

On Wed, 14 Dec 2005, Brown, Len wrote:

> >BTW, are 5165, 3410, 5452, 5571... topic branch names?
> 
> yes, the are bugzilla ids

So, it could have been

	git pull . 5165

which mistakes 5165 for a short SHA1?

Hth,
Dscho
