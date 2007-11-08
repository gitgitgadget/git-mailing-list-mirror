From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 0/3] builtin-commit fixes
Date: Thu, 8 Nov 2007 12:14:59 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711081213580.4362@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, krh@redhat.com, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Nov 08 13:15:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iq6I8-0007dI-88
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 13:15:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758867AbXKHMPI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2007 07:15:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758651AbXKHMPI
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 07:15:08 -0500
Received: from mail.gmx.net ([213.165.64.20]:52838 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758534AbXKHMPH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2007 07:15:07 -0500
Received: (qmail invoked by alias); 08 Nov 2007 12:15:05 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp031) with SMTP; 08 Nov 2007 13:15:05 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+Wj/5H/DKW2wB794UxOhhaFoexBPZLuB3ngg/LcS
	GWZP/jCQAFC8ya
X-X-Sender: gene099@racer.site
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64004>

Hi,

The following three commits are on top of kh/commit. With these 3 patches, 
the test suite passes.

Ciao,
Dscho
