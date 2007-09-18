From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Mention that 'push .. master' is in explicit form
 master:refs/heads/master
Date: Tue, 18 Sep 2007 13:01:32 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709181300380.28586@racer.site>
References: <wsuomgyu.fsf@blue.sea.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Jari Aalto <jari.aalto@cante.net>
X-From: git-owner@vger.kernel.org Tue Sep 18 14:02:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXbmb-0001zm-0D
	for gcvg-git-2@gmane.org; Tue, 18 Sep 2007 14:02:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754037AbXIRMCV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2007 08:02:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755509AbXIRMCV
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Sep 2007 08:02:21 -0400
Received: from mail.gmx.net ([213.165.64.20]:56541 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753567AbXIRMCU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2007 08:02:20 -0400
Received: (qmail invoked by alias); 18 Sep 2007 12:02:18 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp057) with SMTP; 18 Sep 2007 14:02:18 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19m9K10MQpmyB4JZA5uWJiztUseenEfHdllGHkQ3/
	l68Nt+5GMVAeI9
X-X-Sender: gene099@racer.site
In-Reply-To: <wsuomgyu.fsf@blue.sea.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58588>

Hi,

On Tue, 18 Sep 2007, Jari Aalto wrote:

> [no meaningful commit message]

Your patch is wrong.  Try "git push origin <some-tag>".  Works like a 
charm, without starting a new branch.

Ciao,
Dscho
