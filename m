From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-tag: support -F <file> option
Date: Fri, 22 Dec 2006 13:15:03 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612221314310.19693@wbgn013.biozentrum.uni-wuerzburg.de>
References: <emdsi9$ecm$1@sea.gmane.org>
 <Pine.LNX.4.63.0612211512160.19693@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vvek45svl.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Han-Wen Nienhuys <hanwen@xs4all.nl>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 22 13:16:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxjJh-0005ky-2f
	for gcvg-git@gmane.org; Fri, 22 Dec 2006 13:16:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964967AbWLVMPN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Dec 2006 07:15:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965113AbWLVMPN
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Dec 2006 07:15:13 -0500
Received: from mail.gmx.net ([213.165.64.20]:41203 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S964968AbWLVMPF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Dec 2006 07:15:05 -0500
Received: (qmail invoked by alias); 22 Dec 2006 12:15:03 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp045) with SMTP; 22 Dec 2006 13:15:03 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vvek45svl.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35166>

Hi,

On Thu, 21 Dec 2006, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > This imitates the behaviour of git-commit.
> >
> > Noticed by Han-Wen Nienhuys.
> >
> > Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> 
> Ok, but what the **** is "die ...; exit 2" sequence?

;-) I did not even bother reading the code when I copied it.

Ciao,
Dscho
