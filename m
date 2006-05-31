From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Update documentation for git-format-patch
Date: Wed, 31 May 2006 17:00:50 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0605311700240.20016@wbgn013.biozentrum.uni-wuerzburg.de>
References: <93c3eada0605310332p19241861g466e1516a2aaf0df@mail.gmail.com>
 <93c3eada0605310411r712dab8au9b1c7d8ecb595a66@mail.gmail.com>
 <20060531112803.GB3877@spinlock.ch> <20060531141408.G366d89c7@leonov.stosberg.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Matthias Kestenholz <lists@spinlock.ch>, geoff@austrics.com.au,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 31 17:01:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FlSBu-0002Sz-CQ
	for gcvg-git@gmane.org; Wed, 31 May 2006 17:00:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965050AbWEaPAz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 31 May 2006 11:00:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965053AbWEaPAz
	(ORCPT <rfc822;git-outgoing>); Wed, 31 May 2006 11:00:55 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:29126 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S965050AbWEaPAy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 May 2006 11:00:54 -0400
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id 88493E9C;
	Wed, 31 May 2006 17:00:53 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 7A75DE9B;
	Wed, 31 May 2006 17:00:53 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id 97B91E96;
	Wed, 31 May 2006 17:00:50 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Dennis Stosberg <dennis@stosberg.net>
In-Reply-To: <20060531141408.G366d89c7@leonov.stosberg.net>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21067>

Hi,

On Wed, 31 May 2006, Dennis Stosberg wrote:

> Is there any "patch" program at all that understands git's rename
> patches?

Why, yes: git-apply!

Ciao,
Dscho
