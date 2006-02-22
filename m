From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] fmt-merge-msg: avoid open "-|" list form for Perl 5.6
Date: Wed, 22 Feb 2006 20:44:49 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0602221914590.4362@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0602201934270.28957@wbgn013.biozentrum.uni-wuerzburg.de>
  <20060220191011.GA18085@hand.yhbt.net>  <7vr75xbs8w.fsf_-_@assigned-by-dhcp.cox.net>
  <81b0412b0602210930w5c1a71aage12bad2079dd515a@mail.gmail.com> 
 <43FB79E2.1040307@vilain.net> <20060221215742.GA5948@steel.home> 
 <43FB9656.8050308@vilain.net> <81b0412b0602220835p4c4243edm145ee827eb706121@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Sam Vilain <sam@vilain.net>, Junio C Hamano <junkio@cox.net>,
	Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 22 20:45:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FBzuw-0003pX-R8
	for gcvg-git@gmane.org; Wed, 22 Feb 2006 20:44:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964824AbWBVTow (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Feb 2006 14:44:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964826AbWBVTow
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Feb 2006 14:44:52 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:54735 "EHLO
	mailrelay.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S964824AbWBVTov (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Feb 2006 14:44:51 -0500
Received: from virusscan.mail (mail03.mail [172.25.1.102])
	by mailrelay.mail (Postfix) with ESMTP id 5BD411110;
	Wed, 22 Feb 2006 20:44:50 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 4DAE71165;
	Wed, 22 Feb 2006 20:44:50 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id EDF0F1110;
	Wed, 22 Feb 2006 20:44:49 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Alex Riesen <raa.lkml@gmail.com>
In-Reply-To: <81b0412b0602220835p4c4243edm145ee827eb706121@mail.gmail.com>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16611>

Hi,

On Wed, 22 Feb 2006, Alex Riesen wrote:

> IPC::Open{2,3} seem to be installed on every system I have access to.

I can confirm that the platforms I usually work on also provide it 
(Linux, Linux, old IRIX, old macosx, MinGW32).

Ciao,
Dscho
