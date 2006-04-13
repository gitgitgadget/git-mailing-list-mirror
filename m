From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] diff-options: add --stat
Date: Thu, 13 Apr 2006 03:15:51 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0604130308150.11360@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0604130301240.28688@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Thu Apr 13 03:16:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FTqRA-0005Aa-46
	for gcvg-git@gmane.org; Thu, 13 Apr 2006 03:15:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932413AbWDMBPx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 12 Apr 2006 21:15:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932414AbWDMBPx
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Apr 2006 21:15:53 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:51387 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932413AbWDMBPw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Apr 2006 21:15:52 -0400
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id A90AD2001;
	Thu, 13 Apr 2006 03:15:51 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 9D7A41FFF;
	Thu, 13 Apr 2006 03:15:51 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id 81B861E8B;
	Thu, 13 Apr 2006 03:15:51 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
In-Reply-To: <Pine.LNX.4.63.0604130301240.28688@wbgn013.biozentrum.uni-wuerzburg.de>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18644>

Hi,

I just realized that something is wrong with this patch: the first file 
of the patchset seems to be ignored. I'll fix it tomorrow.

Ciao,
Dscho
