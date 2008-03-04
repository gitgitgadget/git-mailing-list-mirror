From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 3/3] Teach git-fetch to exploit server side automatic
 tag following
Date: Tue, 4 Mar 2008 15:12:52 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0803041512040.22527@racer.site>
References: <20080304032740.GC16462@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Mar 04 16:14:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWYqe-00043r-Ql
	for gcvg-git-2@gmane.org; Tue, 04 Mar 2008 16:14:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763155AbYCDPNm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2008 10:13:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763329AbYCDPNm
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Mar 2008 10:13:42 -0500
Received: from mail.gmx.net ([213.165.64.20]:48598 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1763909AbYCDPNk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2008 10:13:40 -0500
Received: (qmail invoked by alias); 04 Mar 2008 15:13:38 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp011) with SMTP; 04 Mar 2008 16:13:38 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+Vptpi6QqVnunaT5axOVa5XEFqr2+RXZ/YOkkhJ7
	odcvAir3lFtY7n
X-X-Sender: gene099@racer.site
In-Reply-To: <20080304032740.GC16462@spearce.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76098>

Hi,

just two comments from me for this patch series:

- it's a beaut, and

- should followtags not be the default?

Ciao,
Dscho

