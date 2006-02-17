From: Jason Riedy <ejr@EECS.Berkeley.EDU>
Subject: Re: [PATCH 1/5] Fixes for ancient versions of GNU make
Date: Fri, 17 Feb 2006 09:15:27 -0800
Message-ID: <11491.1140196527@lotus.CS.Berkeley.EDU>
References: <Pine.LNX.4.63.0602171522020.24274@wbgn013.biozentrum.uni-wuerzburg.de>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 17 18:15:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FA9Cf-0007hF-Ir
	for gcvg-git@gmane.org; Fri, 17 Feb 2006 18:15:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751566AbWBQRPa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 17 Feb 2006 12:15:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751753AbWBQRPa
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Feb 2006 12:15:30 -0500
Received: from lotus.CS.Berkeley.EDU ([128.32.36.222]:37797 "EHLO
	lotus.CS.Berkeley.EDU") by vger.kernel.org with ESMTP
	id S1751566AbWBQRP3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Feb 2006 12:15:29 -0500
Received: from lotus.CS.Berkeley.EDU (localhost [127.0.0.1])
	by lotus.CS.Berkeley.EDU (8.12.8/8.12.8/3.141592645) with ESMTP id k1HHFRxZ011493;
	Fri, 17 Feb 2006 09:15:27 -0800 (PST)
Received: from lotus.CS.Berkeley.EDU (ejr@localhost)
	by lotus.CS.Berkeley.EDU (8.12.8/8.12.8/Submit) with ESMTP id k1HHFRtQ011492;
	Fri, 17 Feb 2006 09:15:27 -0800 (PST)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-reply-to: <Pine.LNX.4.63.0602171522020.24274@wbgn013.biozentrum.uni-wuerzburg.de> 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16360>

And Johannes Schindelin writes:
 - 
 - Some version of GNU make do not understand $(call), and have 
 - problems to interpret rules like this:

Is building a newer version of GNU make impossible on Irix?
Thankfully, I haven't had to deal with that OS in quite some
time.

Jason
