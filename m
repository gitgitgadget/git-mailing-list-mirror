From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Eliminate Scalar::Util usage from private-Error.pm
Date: Wed, 26 Jul 2006 04:03:32 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0607260402460.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0607251809340.29667@wbgn013.biozentrum.uni-wuerzburg.de>
 <20060726010358.20964.80443.stgit@machine>
 <Pine.LNX.4.63.0607260356480.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 26 04:03:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G5YkM-0001DM-IH
	for gcvg-git@gmane.org; Wed, 26 Jul 2006 04:03:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030355AbWGZCDe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 25 Jul 2006 22:03:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030358AbWGZCDe
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Jul 2006 22:03:34 -0400
Received: from mail.gmx.de ([213.165.64.21]:12008 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1030355AbWGZCDe (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Jul 2006 22:03:34 -0400
Received: (qmail invoked by alias); 26 Jul 2006 02:03:32 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp041) with SMTP; 26 Jul 2006 04:03:32 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <Pine.LNX.4.63.0607260356480.29667@wbgn013.biozentrum.uni-wuerzburg.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24198>

Hi,

On Wed, 26 Jul 2006, Johannes Schindelin wrote:

> - private_Error.pm is not used. I had to rename it for Error.pm to be
>   picked up.

Never mind. After I finally got the GITPERLLIB thing right, it did pick 
Error.pm up.

Ciao,
Dscho
