From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Implementing branch attributes in git config
Date: Mon, 8 May 2006 03:45:47 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0605080344480.14008@wbgn013.biozentrum.uni-wuerzburg.de>
References: <1147037659.25090.25.camel@dv> <Pine.LNX.4.64.0605071629080.3718@g5.osdl.org>
 <1147048587.17371.13.camel@dv> <Pine.LNX.4.64.0605071740550.3718@g5.osdl.org>
 <7vfyjli9vf.fsf@assigned-by-dhcp.cox.net> <BAYC1-PASMTP0334B471C6908E4E40BFD2AEA80@CEZ.ICE>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 08 03:45:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fcuot-0007Lx-5O
	for gcvg-git@gmane.org; Mon, 08 May 2006 03:45:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932250AbWEHBpu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 7 May 2006 21:45:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932251AbWEHBpu
	(ORCPT <rfc822;git-outgoing>); Sun, 7 May 2006 21:45:50 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:42716 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932250AbWEHBpu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 May 2006 21:45:50 -0400
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id 1D5B2225B;
	Mon,  8 May 2006 03:45:49 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 11CA61244;
	Mon,  8 May 2006 03:45:49 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id D84CCCE3;
	Mon,  8 May 2006 03:45:48 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: sean <seanlkml@sympatico.ca>
In-Reply-To: <BAYC1-PASMTP0334B471C6908E4E40BFD2AEA80@CEZ.ICE>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19746>

Hi,

On Sun, 7 May 2006, sean wrote:

> Not worth it.  Branch names should be alnums and imho should be
> case sensitive too.

Why should they be case sensitive? So you have a branch "origin" and 
another named "Origin" and get totally confused?

Ciao,
Dscho
