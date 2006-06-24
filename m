From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/5] Rework diff options
Date: Sat, 24 Jun 2006 02:04:44 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0606240201580.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20060624011538.9bb179e7.tihirvon@gmail.com>
 <Pine.LNX.4.63.0606240024460.29667@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vodwj8n9s.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Timo Hirvonen <tihirvon@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 24 02:06:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ftvdq-0001Ed-Ne
	for gcvg-git@gmane.org; Sat, 24 Jun 2006 02:04:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932730AbWFXAEr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Jun 2006 20:04:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933043AbWFXAEq
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jun 2006 20:04:46 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:31109 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932730AbWFXAEq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jun 2006 20:04:46 -0400
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id 34CFA2874;
	Sat, 24 Jun 2006 02:04:45 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 28F732870;
	Sat, 24 Jun 2006 02:04:45 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id E890121CC;
	Sat, 24 Jun 2006 02:04:44 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vodwj8n9s.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22458>

Hi,

On Fri, 23 Jun 2006, Junio C Hamano wrote:

> I personally feel that the benefit of being able to make sure you 
> covered everything outweighs the size of initial diff.

IMHO the difficulty of finding bugs is proportional to the square of the 
diff size, while the number of people willing to review it is proportional 
to its square root. So, if it is not difficult (which it is not at all in 
this case), I politely ask to cut the patch size down.

Ciao,
Dscho
