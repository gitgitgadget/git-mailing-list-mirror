From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: master has some toys
Date: Thu, 17 Nov 2005 12:51:22 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0511171249550.737@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20051115144223.GA18111@diana.vm.bytemark.co.uk>
 <b0943d9e0511160311k725526d8v@mail.gmail.com> <7vr79g8mys.fsf@assigned-by-dhcp.cox.net>
 <7v7jb83w8m.fsf_-_@assigned-by-dhcp.cox.net>
 <81b0412b0511170029xac34cdbtddf74eb766281b3c@mail.gmail.com>
 <Pine.LNX.4.63.0511171207580.20898@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vsltvwmlr.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 17 12:51:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EciIh-00044e-35
	for gcvg-git@gmane.org; Thu, 17 Nov 2005 12:51:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750762AbVKQLvY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 Nov 2005 06:51:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750764AbVKQLvY
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Nov 2005 06:51:24 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:18615 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1750762AbVKQLvY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Nov 2005 06:51:24 -0500
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 2578013FA1C; Thu, 17 Nov 2005 12:51:23 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 087E09F33C; Thu, 17 Nov 2005 12:51:23 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id DFA4398FA6; Thu, 17 Nov 2005 12:51:22 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id B7BA013FA1C; Thu, 17 Nov 2005 12:51:22 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vsltvwmlr.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12105>

Hi,

On Thu, 17 Nov 2005, Junio C Hamano wrote:

> It appears we'd better have something like this in the main
> Makefile, so people do not have to do it themselves everywhere?

I'd like to wait to have a reaction from other people. I vividly remember 
my eyes falling out of my sockets when somebody reported success on cygwin 
without NO_MMAP. If there is *any* cygwin version which fixes it, we 
should rather make people upgrade, no?

Ciao,
Dscho
