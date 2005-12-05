From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Clean up compatibility definitions.
Date: Mon, 5 Dec 2005 21:36:05 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0512052135260.5944@wbgn013.biozentrum.uni-wuerzburg.de>
References: <81b0412b0512050519k5ed80035x9eb4907f569e0a4b@mail.gmail.com>
 <81b0412b0512050524w7b632651n93c836fda41a39d@mail.gmail.com>
 <7vfyp7cuii.fsf@assigned-by-dhcp.cox.net> <7voe3vb8fh.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 05 21:36:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EjN4I-0002ae-Dp
	for gcvg-git@gmane.org; Mon, 05 Dec 2005 21:36:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751452AbVLEUgI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Dec 2005 15:36:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751454AbVLEUgH
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Dec 2005 15:36:07 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:64460 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751452AbVLEUgG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Dec 2005 15:36:06 -0500
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 7C5D113F9BD; Mon,  5 Dec 2005 21:36:05 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 628829F55A; Mon,  5 Dec 2005 21:36:05 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 4055D9DBC8; Mon,  5 Dec 2005 21:36:05 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 1005213F9BD; Mon,  5 Dec 2005 21:36:05 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7voe3vb8fh.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13226>

Hi,

On Mon, 5 Dec 2005, Junio C Hamano wrote:

> This attempts to clean up the way various compatibility
> functions are defined and used.

You sure you want that before 1.0?

Ciao,
Dscho
