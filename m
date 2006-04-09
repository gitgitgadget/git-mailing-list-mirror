From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [ANNOUNCE] git-svnconvert: YASI (Yet Another SVN importer)
Date: Sun, 9 Apr 2006 23:30:23 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0604092325590.29434@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20060409163426.GA22103@nospam.com> <e1bdjq$qf6$1@sea.gmane.org>
 <20060409211505.GA30567@nospam.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 09 23:30:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FShUM-0004MX-FC
	for gcvg-git@gmane.org; Sun, 09 Apr 2006 23:30:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750930AbWDIVa1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 9 Apr 2006 17:30:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750932AbWDIVa1
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Apr 2006 17:30:27 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:19658 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1750930AbWDIVa1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Apr 2006 17:30:27 -0400
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id A03EE1F41;
	Sun,  9 Apr 2006 23:30:23 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 940A81F39;
	Sun,  9 Apr 2006 23:30:23 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id 70A291D31;
	Sun,  9 Apr 2006 23:30:23 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@wingding.demon.nl
In-Reply-To: <20060409211505.GA30567@nospam.com>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18566>

Hi,

On Sun, 9 Apr 2006, Rutger Nijlunsing wrote:

> On Sun, Apr 09, 2006 at 06:43:53PM +0200, Jakub Narebski wrote:
> > 
> > Instead adding dependence on Ruby, eh?
> 
> Take some, lose some ;)
> 
> Seriously, though, a dependancy on a mainstream language like
> Python/Perl/Ruby/.. isn't a problem since a package is available for
> all distributions. However, packages for mainstream languages are
> quite often out-of-date or are not supported at all. Seeing a program
> being dependant on a non-packaged module is enough for a truckload of
> people to not even try it.

I have _never_ seen a setup where Ruby was installed by default. Perl 
always, Python often.

Furthermore, my feeling is that we are in the beginning phase of migration 
from scripting languages (which are good for prototyping) towards plain C. 
So adding yet another scripting language dependency is a little backwards.

Ciao,
Dscho
