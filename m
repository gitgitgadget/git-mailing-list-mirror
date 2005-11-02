From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add 'ours' merge strategy.
Date: Wed, 2 Nov 2005 11:35:30 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0511021134100.6501@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7vll071ug5.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 02 11:37:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EXFyD-0005iJ-Q0
	for gcvg-git@gmane.org; Wed, 02 Nov 2005 11:35:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751545AbVKBKfc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 2 Nov 2005 05:35:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751551AbVKBKfc
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Nov 2005 05:35:32 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:24194 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751544AbVKBKfc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Nov 2005 05:35:32 -0500
Received: from wrzx34.rz.uni-wuerzburg.de (wrzx34.rz.uni-wuerzburg.de [132.187.3.34])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 40A7A13EBD3; Wed,  2 Nov 2005 11:35:31 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 24F30B4FBE; Wed,  2 Nov 2005 11:35:31 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 00B15B1690; Wed,  2 Nov 2005 11:35:31 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id D3D3C13EBC0; Wed,  2 Nov 2005 11:35:30 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vll071ug5.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11020>

Hi,

On Tue, 1 Nov 2005, Junio C Hamano wrote:

>  This can be used to terminate an old maintenance branch without
>  leaving people's repositories behind.

How about optionally do something similar when git-rebase'ing? Especially 
"pu"?

Ciao,
Dscho
