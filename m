From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Move commit reencoding parameter parsing to revision.c
Date: Sun, 31 Dec 2006 02:10:58 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612310210330.25709@wbgn013.biozentrum.uni-wuerzburg.de>
References: <e5bfff550612300956mef4691fqf607fad173c571da@mail.gmail.com>
 <Pine.LNX.4.63.0612301955340.19693@wbgn013.biozentrum.uni-wuerzburg.de>
 <7v3b6xjfrr.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Marco Costalba <mcostalba@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 31 02:11:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H0pE9-0004oS-44
	for gcvg-git@gmane.org; Sun, 31 Dec 2006 02:11:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932255AbWLaBLB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Dec 2006 20:11:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932521AbWLaBLB
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Dec 2006 20:11:01 -0500
Received: from mail.gmx.net ([213.165.64.20]:44168 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932255AbWLaBLA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Dec 2006 20:11:00 -0500
Received: (qmail invoked by alias); 31 Dec 2006 01:10:58 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp054) with SMTP; 31 Dec 2006 02:10:58 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v3b6xjfrr.fsf_-_@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35639>

Hi,

this patch makes a lot of sense IMHO.

Ciao,
Dscho
