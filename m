From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: recent patch breaks the build ?
Date: Thu, 17 Nov 2005 17:22:13 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0511171721510.17513@wbgn013.biozentrum.uni-wuerzburg.de>
References: <437B6997.8010903@mc.com> <Pine.LNX.4.63.0511171258440.2104@wbgn013.biozentrum.uni-wuerzburg.de>
 <20051117155709.GD3968@reactrix.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andrew Wozniak <awozniak@mc.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 17 17:31:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EcmX0-0005AQ-55
	for gcvg-git@gmane.org; Thu, 17 Nov 2005 17:22:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932380AbVKQQWP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 Nov 2005 11:22:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932392AbVKQQWP
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Nov 2005 11:22:15 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:10184 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932380AbVKQQWO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Nov 2005 11:22:14 -0500
Received: from wrzx34.rz.uni-wuerzburg.de (wrzx34.rz.uni-wuerzburg.de [132.187.3.34])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id D4F3513FBB0; Thu, 17 Nov 2005 17:22:13 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id B4C50B5231; Thu, 17 Nov 2005 17:22:13 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 940BCB5215; Thu, 17 Nov 2005 17:22:13 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 0364213FBB0; Thu, 17 Nov 2005 17:22:13 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Nick Hengeveld <nickh@reactrix.com>
In-Reply-To: <20051117155709.GD3968@reactrix.com>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12130>

Hi,

On Thu, 17 Nov 2005, Nick Hengeveld wrote:

> On Thu, Nov 17, 2005 at 01:00:19PM +0100, Johannes Schindelin wrote:
> 
> > Note that I had no success making http-fetch work without USE_CURL_MULTI. 
> > So maybe you can compile it, but maybe you experience the same problems as 
> > I had.
> 
> http-fetch or http-push?

Oops. IIRC it was when I was playing with http-push.

Sorry,
Dscho
