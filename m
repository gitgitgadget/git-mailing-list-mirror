From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Implementing branch attributes in git config
Date: Wed, 10 May 2006 13:07:34 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0605101305560.6240@wbgn013.biozentrum.uni-wuerzburg.de>
References: <1147037659.25090.25.camel@dv> <e3p5om$djs$1@sea.gmane.org> 
 <Pine.LNX.4.63.0605091321350.7652@wbgn013.biozentrum.uni-wuerzburg.de> 
 <7vzmhr3wje.fsf@assigned-by-dhcp.cox.net>  <Pine.LNX.4.64.0605091215340.3718@g5.osdl.org>
  <BAYC1-PASMTP02C02EAC2F64AC00BB5801AEA90@CEZ.ICE> 
 <BAYC1-PASMTP04D623089E043F1C792A37AEA90@CEZ.ICE>  <Pine.LNX.4.64.0605091543100.3718@g5.osdl.org>
  <BAYC1-PASMTP037EBB0237B35C5F92FB0BAEAE0@CEZ.ICE> 
 <Pine.LNX.4.64.0605091854380.3718@g5.osdl.org>
 <46a038f90605100019q3b44b87kf49e456668f2e249@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 10 13:07:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FdmXb-00046d-Cr
	for gcvg-git@gmane.org; Wed, 10 May 2006 13:07:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964901AbWEJLHg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 10 May 2006 07:07:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964921AbWEJLHg
	(ORCPT <rfc822;git-outgoing>); Wed, 10 May 2006 07:07:36 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:37266 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S964901AbWEJLHf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 May 2006 07:07:35 -0400
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id 5A770CA6;
	Wed, 10 May 2006 13:07:34 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 4DED8C66;
	Wed, 10 May 2006 13:07:34 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id 3134CA89;
	Wed, 10 May 2006 13:07:34 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90605100019q3b44b87kf49e456668f2e249@mail.gmail.com>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19882>

Hi,

On Wed, 10 May 2006, Martin Langhoff wrote:

> So... call me old-styled... but I'm happy with one-file-per-remote.
> Was it broken to start with?

Depends on how you look at it. A bunch of files is okay for quick-n-dirty, 
where you do not care about locking or consistency or extensibility.

Ciao,
Dscho
