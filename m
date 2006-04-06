From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Fixes to parsecvs
Date: Thu, 6 Apr 2006 17:26:14 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0604061723410.23681@wbgn013.biozentrum.uni-wuerzburg.de>
References: <1144305392.2303.240.camel@neko.keithp.com>  <20060406120812.GO13324@lug-owl.de>
 <1144334896.2303.259.camel@neko.keithp.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 06 17:26:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FRWNL-0002vo-TK
	for gcvg-git@gmane.org; Thu, 06 Apr 2006 17:26:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932177AbWDFP0V (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Apr 2006 11:26:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932183AbWDFP0V
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Apr 2006 11:26:21 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:59046 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932177AbWDFP0U (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Apr 2006 11:26:20 -0400
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id 56952C66;
	Thu,  6 Apr 2006 17:26:17 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 4ADE6C65;
	Thu,  6 Apr 2006 17:26:17 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id 2B8C9BFB;
	Thu,  6 Apr 2006 17:26:14 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Keith Packard <keithp@keithp.com>
In-Reply-To: <1144334896.2303.259.camel@neko.keithp.com>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18472>

Hi,

On Thu, 6 Apr 2006, Keith Packard wrote:

> On Thu, 2006-04-06 at 14:08 +0200, Jan-Benedict Glaw wrote:
> 
> > But it seems it now starts to really consume memory:
> 
> The question is whether it needs to be more efficient so that people can 
> constantly convert repositories or whether moving the repository to a 
> sufficiently large machine for the one-time conversion is 'good enough'.

Keep in mind that there are many more valid uses for tracking a CVS 
repository than to import it once.

Ciao,
Dscho
