From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] diff-options: add --stat
Date: Thu, 13 Apr 2006 08:59:47 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0604130859080.13529@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0604130301240.28688@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vy7ya13e3.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 13 08:59:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FTvnz-0002Ra-So
	for gcvg-git@gmane.org; Thu, 13 Apr 2006 08:59:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964807AbWDMG7t (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 13 Apr 2006 02:59:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964808AbWDMG7t
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Apr 2006 02:59:49 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:5010 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S964807AbWDMG7s (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Apr 2006 02:59:48 -0400
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id 6FEE62032;
	Thu, 13 Apr 2006 08:59:47 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 6366A2035;
	Thu, 13 Apr 2006 08:59:47 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id 479C82023;
	Thu, 13 Apr 2006 08:59:47 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vy7ya13e3.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18654>

Hi,

On Wed, 12 Apr 2006, Junio C Hamano wrote:

> By the way, I've been wondering if anybody uses the
> GIT_EXTERNAL_DIFF interface.  Does anybody miss it if we did so?

Yes. I use it regularly with a patched wdiff (word-by-word diff).

Ciao,
Dscho
