From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Support custom build options in config.mak
Date: Tue, 11 Oct 2005 13:08:22 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0510111307410.20527@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0510110948170.19774@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vr7astr27.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 11 13:09:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EPHzf-0000im-FZ
	for gcvg-git@gmane.org; Tue, 11 Oct 2005 13:08:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751449AbVJKLIY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 11 Oct 2005 07:08:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751450AbVJKLIY
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Oct 2005 07:08:24 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:4764 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751449AbVJKLIX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Oct 2005 07:08:23 -0400
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id C332213EB9D; Tue, 11 Oct 2005 13:08:22 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id A6E4E9E4A9; Tue, 11 Oct 2005 13:08:22 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 9394F9E48F; Tue, 11 Oct 2005 13:08:22 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 6FD4913EB48; Tue, 11 Oct 2005 13:08:22 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vr7astr27.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9962>

Hi,

On Tue, 11 Oct 2005, Junio C Hamano wrote:

> With this patch, you can store the configuration options like
> NO_CURL=YesPlease or NO_OPENSSL=YesPlease into a file named
> Make, and I typically do this:
> 
> [...]

:-)
