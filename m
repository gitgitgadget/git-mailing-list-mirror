From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add Python version checks to the Makefile to automatically
 set WITH_OWN_SUBPROCESS_PY
Date: Mon, 21 Nov 2005 09:26:17 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0511210925570.27634@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20051120.202032.37639519.davem@davemloft.net>
 <11325498823557-git-send-email-ryan@michonline.com>
 <20051120.213129.88244378.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: ryan@michonline.com, git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Mon Nov 21 09:27:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ee70N-0003GM-QP
	for gcvg-git@gmane.org; Mon, 21 Nov 2005 09:26:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932206AbVKUI0Y (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 Nov 2005 03:26:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932212AbVKUI0X
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Nov 2005 03:26:23 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:16845 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932206AbVKUI0X (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Nov 2005 03:26:23 -0500
Received: from wrzx34.rz.uni-wuerzburg.de (wrzx34.rz.uni-wuerzburg.de [132.187.3.34])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 162421403A8; Mon, 21 Nov 2005 09:26:20 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 97295B528B; Mon, 21 Nov 2005 09:26:19 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 80793B528F; Mon, 21 Nov 2005 09:26:18 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 06E6C1403AD; Mon, 21 Nov 2005 09:26:18 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20051120.213129.88244378.davem@davemloft.net>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12429>

Hi,

On Sun, 20 Nov 2005, David S. Miller wrote:

> From: Ryan Anderson <ryan@michonline.com>
> Date: Mon, 21 Nov 2005 00:11:22 -0500
> 
> > Also rearrange some path settings in the Makefile in the process.
> > 
> > Signed-off-by: Ryan Anderson <ryan@michonline.com>
> 
> Looks good from here.

Not from here... I don't have it ;-) Care to share?

Ciao,
Dscho
