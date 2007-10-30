From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [GIT-GUI PATCH 0/3] po2msg fixes
Date: Tue, 30 Oct 2007 11:24:12 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0710301122300.4362@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: stimming@tuhh.de, spearce@spearce.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 30 12:25:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ImpDX-00088N-Bu
	for gcvg-git-2@gmane.org; Tue, 30 Oct 2007 12:25:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752300AbXJ3LYx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2007 07:24:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751549AbXJ3LYx
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Oct 2007 07:24:53 -0400
Received: from mail.gmx.net ([213.165.64.20]:51184 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752300AbXJ3LYw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2007 07:24:52 -0400
Received: (qmail invoked by alias); 30 Oct 2007 11:24:50 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp045) with SMTP; 30 Oct 2007 12:24:50 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18v9P0myR8vrE4u25gr5u2Xjc59jQj6UaWrRU7exT
	1fGUPeF8ILRMpu
X-X-Sender: gene099@racer.site
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi,

this series of 3 patches fixes the following:

- fuzzy translations are ignored
- empty translations are ignored
- the --statistics option is implemented

Ciao,
Dscho
