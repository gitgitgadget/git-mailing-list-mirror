From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add a new lstat and fstat implementation based on Win32
 API
Date: Mon, 3 Sep 2007 17:56:10 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709031755290.28586@racer.site>
References: <46DACD93.9000509@trolltech.com> <46DACE0D.5070501@trolltech.com>
 <46DBBC1E.4010407@eudaptics.com> <46DBFA2A.7050003@trolltech.com>
 <Pine.LNX.4.64.0709031428080.28586@racer.site> <46DC1186.2010008@trolltech.com>
 <Pine.LNX.4.64.0709031538320.28586@racer.site> <46DC34A9.8020308@trolltech.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Sixt <j.sixt@eudaptics.com>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Sixt <johannes.sixt@telecom.at>
To: Marius Storm-Olsen <marius@trolltech.com>
X-From: git-owner@vger.kernel.org Mon Sep 03 18:56:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISFDu-00016k-Lb
	for gcvg-git@gmane.org; Mon, 03 Sep 2007 18:56:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752959AbXICQ4W (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Sep 2007 12:56:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752898AbXICQ4W
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Sep 2007 12:56:22 -0400
Received: from mail.gmx.net ([213.165.64.20]:58552 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751861AbXICQ4V (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Sep 2007 12:56:21 -0400
Received: (qmail invoked by alias); 03 Sep 2007 16:56:20 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp035) with SMTP; 03 Sep 2007 18:56:20 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18zdcpXI0MzIR3QhNzEjQg7fxMf5yXoLZefjIUzAE
	7jNOYI15cmEBsJ
X-X-Sender: gene099@racer.site
In-Reply-To: <46DC34A9.8020308@trolltech.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57496>

Hi,

On Mon, 3 Sep 2007, Marius Storm-Olsen wrote:

> I'll use the 4msysgit.git repo from now on. I assume it'll be ok if I 
> +push to the teststat branch?

I should think so.

Ciao,
Dscho
