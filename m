From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 6/7] Release pack windows before reporting out of memory.
Date: Sun, 24 Dec 2006 14:10:32 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612241409420.19693@wbgn013.biozentrum.uni-wuerzburg.de>
References: <487c7d0ea81f2f82f330e277e0aea38a66ca7cfe.1166939109.git.spearce@spearce.org>
 <20061224054719.GF8146@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 24 14:10:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GyT7f-0006C0-Bt
	for gcvg-git@gmane.org; Sun, 24 Dec 2006 14:10:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751336AbWLXNKf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Dec 2006 08:10:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751417AbWLXNKf
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Dec 2006 08:10:35 -0500
Received: from mail.gmx.net ([213.165.64.20]:57601 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751336AbWLXNKe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Dec 2006 08:10:34 -0500
Received: (qmail invoked by alias); 24 Dec 2006 13:10:32 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp037) with SMTP; 24 Dec 2006 14:10:32 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: "Shawn O. Pearce" <spearce@spearce.org>
In-Reply-To: <20061224054719.GF8146@spearce.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35356>

Hi,

a very cute idea that having x*alloc() in place you can just pluck in some 
garbage collection. I like it.

Ciao,
Dscho
