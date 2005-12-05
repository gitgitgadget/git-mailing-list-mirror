From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] config.c: remove unnecessary header in minimum configuration
 file.
Date: Mon, 5 Dec 2005 23:16:45 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0512052316150.3284@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7v7jawmkpo.fsf@assigned-by-dhcp.cox.net> <7vu0docrqz.fsf@assigned-by-dhcp.cox.net>
 <4394255D.1030009@op5.se> <Pine.LNX.4.63.0512052124400.4026@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vek4rb6vc.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0512052202300.12016@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vzmnf9px8.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 05 23:18:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EjOde-0001Uu-JP
	for gcvg-git@gmane.org; Mon, 05 Dec 2005 23:16:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932419AbVLEWQr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Dec 2005 17:16:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932433AbVLEWQr
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Dec 2005 17:16:47 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:6365 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932419AbVLEWQq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Dec 2005 17:16:46 -0500
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 6722113F9BD; Mon,  5 Dec 2005 23:16:45 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 4B84E9F55C; Mon,  5 Dec 2005 23:16:45 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 32F989DBC8; Mon,  5 Dec 2005 23:16:45 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 0D1D113F9BD; Mon,  5 Dec 2005 23:16:45 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vzmnf9px8.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13242>

Hi,

On Mon, 5 Dec 2005, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > However, reading the code I am not satisfied. If there is no template for 
> > the config file, it does not test the filemode at all.
> 
> I have a feeling that you have not tried the code you are
> arguing against.

Got me right there.

Sorry.

Ciao,
Dscho
