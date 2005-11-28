From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: use binmode(STDOUT) in git-status
Date: Mon, 28 Nov 2005 17:56:58 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0511281756001.11697@wbgn013.biozentrum.uni-wuerzburg.de>
References: <81b0412b0511272334w393434e7lad3e3b102e6c3e9e@mail.gmail.com>
 <438B2859.6060109@zytor.com> <Pine.LNX.4.63.0511281700100.11362@wbgn013.biozentrum.uni-wuerzburg.de>
 <438B2B90.9010500@zytor.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Nov 28 17:59:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EgmJN-0000RG-7x
	for gcvg-git@gmane.org; Mon, 28 Nov 2005 17:57:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751303AbVK1Q5A (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 28 Nov 2005 11:57:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751304AbVK1Q5A
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Nov 2005 11:57:00 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:59042 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751303AbVK1Q5A (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Nov 2005 11:57:00 -0500
Received: from wrzx34.rz.uni-wuerzburg.de (wrzx34.rz.uni-wuerzburg.de [132.187.3.34])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 49F6013EE23; Mon, 28 Nov 2005 17:56:59 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 28858B5364; Mon, 28 Nov 2005 17:56:59 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 0832DB52B7; Mon, 28 Nov 2005 17:56:59 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id B2B5013EE23; Mon, 28 Nov 2005 17:56:58 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <438B2B90.9010500@zytor.com>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12895>

Hi,

On Mon, 28 Nov 2005, H. Peter Anvin wrote:

> if you're running Cygwin, wouldn't Cygwin's Perl make a lot more sense?

I thought so, too, but I guess there's a reason that Activision's perl was 
used.

Hth,
Dscho
