From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: suggestion: store the URL somewhere in .git/
Date: Mon, 22 Aug 2005 22:18:06 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0508222217310.695@wgmdd8.biozentrum.uni-wuerzburg.de>
References: <430A30C8.3080908@linuxmachines.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 22 22:21:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E7IkI-0007ok-VL
	for gcvg-git@gmane.org; Mon, 22 Aug 2005 22:18:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751001AbVHVUSL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 22 Aug 2005 16:18:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751008AbVHVUSK
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Aug 2005 16:18:10 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:40870 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751001AbVHVUSJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Aug 2005 16:18:09 -0400
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 9F307139442; Mon, 22 Aug 2005 22:18:06 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 84C379A10F; Mon, 22 Aug 2005 22:18:06 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 748289A0E2; Mon, 22 Aug 2005 22:18:06 +0200 (CEST)
Received: from wgmdd8.biozentrum.uni-wuerzburg.de (wrzx67.rz.uni-wuerzburg.de [132.187.3.67])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 1F248139442; Mon, 22 Aug 2005 22:18:06 +0200 (CEST)
X-X-Sender: gene099@wgmdd8.biozentrum.uni-wuerzburg.de
To: Jeff Carr <jcarr@linuxmachines.com>
In-Reply-To: <430A30C8.3080908@linuxmachines.com>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi,

On Mon, 22 Aug 2005, Jeff Carr wrote:

> It would be nice if the URL could be stored somewhere in .git/ This
> makes it a lot easier to update repositories because you don't always
> have to go and track down where you got it in the first place.

This is why your original target (when you clone) is stored as "origin".

Hth,
Dscho
