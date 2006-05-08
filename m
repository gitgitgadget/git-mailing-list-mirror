From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Implementing branch attributes in git config
Date: Tue, 9 May 2006 01:44:31 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0605090142280.5778@wbgn013.biozentrum.uni-wuerzburg.de>
References: <1147037659.25090.25.camel@dv> <Pine.LNX.4.64.0605071629080.3718@g5.osdl.org>
 <1147048587.17371.13.camel@dv> <Pine.LNX.4.64.0605071740550.3718@g5.osdl.org>
 <7vfyjli9vf.fsf@assigned-by-dhcp.cox.net> <BAYC1-PASMTP0334B471C6908E4E40BFD2AEA80@CEZ.ICE>
 <7vbqu9i6zl.fsf@assigned-by-dhcp.cox.net> <BAYC1-PASMTP110777A694DAF1D7623895AEA80@CEZ.ICE>
 <Pine.LNX.4.64.0605081905240.6713@iabervon.org> <BAYC1-PASMTP0453E2D70B10C6D116167EAEA80@CEZ.ICE>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 09 01:44:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FdFP3-0007C5-VD
	for gcvg-git@gmane.org; Tue, 09 May 2006 01:44:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750855AbWEHXod (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 8 May 2006 19:44:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750891AbWEHXod
	(ORCPT <rfc822;git-outgoing>); Mon, 8 May 2006 19:44:33 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:22189 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1750855AbWEHXod (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 May 2006 19:44:33 -0400
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id 0B7B41D4C;
	Tue,  9 May 2006 01:44:32 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id F409A1D4A;
	Tue,  9 May 2006 01:44:31 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id D6ACC1426;
	Tue,  9 May 2006 01:44:31 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: sean <seanlkml@sympatico.ca>
In-Reply-To: <BAYC1-PASMTP0453E2D70B10C6D116167EAEA80@CEZ.ICE>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19783>

Hi,

On Mon, 8 May 2006, sean wrote:

> There's no good reason for git to break with traditional and common 
> practice in this case.

It is well established common practice that ini files (and everything in 
config resembles an ini file) have case insensitive section headers as 
well as keys.

Ciao,
Dscho
