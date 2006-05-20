From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: synchronizing incremental git changes to cvs
Date: Sun, 21 May 2006 01:05:46 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0605210104470.3148@wbgn013.biozentrum.uni-wuerzburg.de>
References: <87mzdcjqey.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 21 01:05:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FhaW7-0007lx-OL
	for gcvg-git@gmane.org; Sun, 21 May 2006 01:05:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964814AbWETXFt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 20 May 2006 19:05:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964820AbWETXFs
	(ORCPT <rfc822;git-outgoing>); Sat, 20 May 2006 19:05:48 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:12468 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S964814AbWETXFs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 May 2006 19:05:48 -0400
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id 1A2F6C8E;
	Sun, 21 May 2006 01:05:47 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 0EA4EC6B;
	Sun, 21 May 2006 01:05:47 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id E54ACB33;
	Sun, 21 May 2006 01:05:46 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Jim Meyering <jim@meyering.net>
In-Reply-To: <87mzdcjqey.fsf@rho.meyering.net>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20405>

Hi,

On Sun, 21 May 2006, Jim Meyering wrote:

> Why am I interested?  I want to switch the development of GNU coreutils
> from cvs to git.  I would also like to continue making the repository
> available via cvs, for the sake of continuity.  At worst, I can always
> cut the CVS cord, but that's a last resort.

If you only want to make a cvs repository available for tracking the 
project, git-cvsserver is what you want. It is even faster than the 
original cvs...

Ciao,
Dscho
