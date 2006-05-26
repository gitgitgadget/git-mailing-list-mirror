From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: t8001-annotate.sh fails on Mac OS X
Date: Fri, 26 May 2006 15:36:14 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0605261534270.27610@wbgn013.biozentrum.uni-wuerzburg.de>
References: <f3d7535d0605251653m15db34f3j46403f4ed0c4c69f@mail.gmail.com>
 <20060526011153.GA27720@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Stefan Pfetzing <stefan.pfetzing@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 26 15:36:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FjcUF-0006Jg-4x
	for gcvg-git@gmane.org; Fri, 26 May 2006 15:36:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750737AbWEZNgQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 May 2006 09:36:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750738AbWEZNgQ
	(ORCPT <rfc822;git-outgoing>); Fri, 26 May 2006 09:36:16 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:47594 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1750737AbWEZNgP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 May 2006 09:36:15 -0400
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id 700151FBE;
	Fri, 26 May 2006 15:36:14 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 640AF12DA;
	Fri, 26 May 2006 15:36:14 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id 466B2135E;
	Fri, 26 May 2006 15:36:14 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Shawn Pearce <spearce@spearce.org>
In-Reply-To: <20060526011153.GA27720@spearce.org>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20811>

Hi,

On Thu, 25 May 2006, Shawn Pearce wrote:

> Stefan Pfetzing <stefan.pfetzing@gmail.com> wrote:
> > 
> > for some reason I could not yet figure out, t8001-annotate.sh fails at test 
> > 18.
> 
> I've been seeing the same failed test case for a long time now on
> my own Mac OS X system.

... which is sort of funny, because I don't see it on my system. Running 
an iBook G3 with Mac OS X 10.2.8. "make test" runs through, and no, AFAICT 
I do not have any local modifications which could be responsible for that.

Ciao,
Dscho
