From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git wrapper: basic fixes.
Date: Wed, 16 Nov 2005 09:22:36 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0511160921520.16172@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20051116002318.A46C55BF97@nox.op5.se> <437AAB48.7090904@zytor.com>
 <437AD82B.1050404@op5.se> <7vfypxawok.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andreas Ericsson <ae@op5.se>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 16 09:23:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EcIYz-0005fL-ED
	for gcvg-git@gmane.org; Wed, 16 Nov 2005 09:22:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030217AbVKPIWi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 16 Nov 2005 03:22:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030223AbVKPIWi
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Nov 2005 03:22:38 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:28631 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1030217AbVKPIWi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Nov 2005 03:22:38 -0500
Received: from wrzx34.rz.uni-wuerzburg.de (wrzx34.rz.uni-wuerzburg.de [132.187.3.34])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 2C19A13F98E; Wed, 16 Nov 2005 09:22:37 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 10082B51F9; Wed, 16 Nov 2005 09:22:37 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id E601959124; Wed, 16 Nov 2005 09:22:36 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id CBCB613F98E; Wed, 16 Nov 2005 09:22:36 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vfypxawok.fsf_-_@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12012>

Hi,

On Tue, 15 Nov 2005, Junio C Hamano wrote:

>  - Lose use of glob(); read from exec_path and do sorting
>    ourselves -- it is not that much more work.

Clearly a better fix than my patch.

Ciao,
Dscho
