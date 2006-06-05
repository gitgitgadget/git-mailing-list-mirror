From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git: handle aliases defined in $GIT_DIR/config
Date: Mon, 5 Jun 2006 19:02:56 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0606051902210.20820@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0606042047160.1598@wbgn013.biozentrum.uni-wuerzburg.de>
 <7v3bekacts.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0606051847480.18604@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 05 19:03:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FnITl-0001Vv-0i
	for gcvg-git@gmane.org; Mon, 05 Jun 2006 19:03:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751226AbWFERC6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Jun 2006 13:02:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751227AbWFERC6
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Jun 2006 13:02:58 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:44002 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751226AbWFERC5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Jun 2006 13:02:57 -0400
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id 9AA0B1DBD;
	Mon,  5 Jun 2006 19:02:56 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 8ECA31DB5;
	Mon,  5 Jun 2006 19:02:56 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id 71ADF1D59;
	Mon,  5 Jun 2006 19:02:56 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <Pine.LNX.4.63.0606051847480.18604@wbgn013.biozentrum.uni-wuerzburg.de>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21322>

Hi,

sorry, I did not test with the subdir=... stuff I copied from Pasky's 
patch. It breaks things for me. Looking into it...

Ciao,
Dscho
