From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What's cooking in git.git (topics)
Date: Fri, 29 Dec 2006 18:55:56 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612291853210.19693@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7vtzzfp86x.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 29 18:56:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1H0LxZ-0003gK-NY
	for gcvg-git@gmane.org; Fri, 29 Dec 2006 18:56:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965073AbWL2Rz7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Dec 2006 12:55:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965074AbWL2Rz7
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Dec 2006 12:55:59 -0500
Received: from mail.gmx.net ([213.165.64.20]:43001 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965073AbWL2Rz6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Dec 2006 12:55:58 -0500
Received: (qmail invoked by alias); 29 Dec 2006 17:55:56 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp038) with SMTP; 29 Dec 2006 18:55:56 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vtzzfp86x.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35598>

Hi,

On Thu, 28 Dec 2006, Junio C Hamano wrote:

> * jc/3way (Wed Nov 29 18:53:13 2006 -0800) 1 commit
>  + git-merge: preserve and merge local changes when doing fast
>    forward

I'd like this, but behind a command line switch. And in addition to saying 
"cannot merge, blabla needs update", git could spit out "if you want to 
risk a 3way merge, go ahead and add the --preserve-local flag to 
git-merge".

Comments?

Ciao,
Dscho
