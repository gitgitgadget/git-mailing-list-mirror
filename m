From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Is anybody actually using git-cherry.sh?
Date: Fri, 23 Jun 2006 22:43:26 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0606232242500.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0606231818140.29667@wbgn013.biozentrum.uni-wuerzburg.de>
 <20060623180658.GA24022@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 23 22:43:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FtsV2-0008AN-1o
	for gcvg-git@gmane.org; Fri, 23 Jun 2006 22:43:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752042AbWFWUn2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Jun 2006 16:43:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752045AbWFWUn2
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jun 2006 16:43:28 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:9965 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1752042AbWFWUn1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jun 2006 16:43:27 -0400
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id A08D52AE1;
	Fri, 23 Jun 2006 22:43:26 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 94B532483;
	Fri, 23 Jun 2006 22:43:26 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id 798891CBD;
	Fri, 23 Jun 2006 22:43:26 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Jeff King <peff@peff.net>
In-Reply-To: <20060623180658.GA24022@coredump.intra.peff.net>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22438>

Hi Peff,

On Fri, 23 Jun 2006, Jeff King wrote:

> It looks like patch-id does a flush whenever a sha1 is found at the 
> beginning of a line; diff-tree lines simply have the 'diff-tree ' part 
> ignored.

Ah! Everything makes sense now. Thanks!

Ciao,
Dscho
