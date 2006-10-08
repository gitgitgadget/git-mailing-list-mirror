From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC PATCH] Add WEBDAV timeout to http-fetch.
Date: Sun, 8 Oct 2006 14:03:17 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0610081402430.14200@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20061006212616.GA5175@lumumba.uhasselt.be>
 <20061006220542.GA5890@lumumba.uhasselt.be> <BAYC1-PASMTP08A34A8FB0703E4D2ABAF9AE130@CEZ.ICE>
 <BAYC1-PASMTP11CF83A008B0B3BA5F6B15AE100@CEZ.ICE> <7viriwsa75.fsf@assigned-by-dhcp.cox.net>
 <eg82tq$2uq$1@sea.gmane.org> <Pine.LNX.4.63.0610071930300.14200@wbgn013.biozentrum.uni-wuerzburg.de>
 <20061007223023.GI20017@pasky.or.cz> <Pine.LNX.4.63.0610080034490.14200@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vbqonpfyl.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>,
	Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 08 14:03:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GWXNJ-0000t1-W8
	for gcvg-git@gmane.org; Sun, 08 Oct 2006 14:03:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751117AbWJHMDT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 Oct 2006 08:03:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751118AbWJHMDT
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Oct 2006 08:03:19 -0400
Received: from mail.gmx.de ([213.165.64.20]:42907 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751117AbWJHMDS (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 Oct 2006 08:03:18 -0400
Received: (qmail invoked by alias); 08 Oct 2006 12:03:17 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp026) with SMTP; 08 Oct 2006 14:03:17 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vbqonpfyl.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28534>

Hi,

On Sat, 7 Oct 2006, Junio C Hamano wrote:

> [...] But the repository owner ends up keeping up-to-date as a side 
> effect of keeping info/refs up-to-date anyway (as I do not see a code to 
> read that information over DAV), so there is no point doing this over 
> DAV in practice.

Makes sense to me.

Ciao,
Dscho
