From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Fix a strchrnul() related build error
Date: Mon, 12 Nov 2007 21:27:06 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711122126370.4362@racer.site>
References: <1194901282-2468-1-git-send-email-Emilian.Medve@Freescale.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: gitster@pobox.com, ae@op5.se, git@vger.kernel.org
To: Emil Medve <Emilian.Medve@Freescale.com>
X-From: git-owner@vger.kernel.org Mon Nov 12 22:27:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Irgok-0003vp-OF
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 22:27:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753096AbXKLV1X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2007 16:27:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753060AbXKLV1W
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 16:27:22 -0500
Received: from mail.gmx.net ([213.165.64.20]:41749 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752929AbXKLV1V (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2007 16:27:21 -0500
Received: (qmail invoked by alias); 12 Nov 2007 21:27:20 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp012) with SMTP; 12 Nov 2007 22:27:20 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19U4zgJd7hU/xHbfG18JinXfFv2+zS4SvmW8PhSLj
	H3tQh+mCtdnOra
X-X-Sender: gene099@racer.site
In-Reply-To: <1194901282-2468-1-git-send-email-Emilian.Medve@Freescale.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64711>

Hi,

didn't Johannes Sixt provide a (slightly nicer) patch earlier today?

Ciao,
Dscho
