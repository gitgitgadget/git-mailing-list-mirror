From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] Make builtin-rerere use of strbuf nicer and more
 efficient.
Date: Mon, 24 Sep 2007 11:38:15 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709241136320.28395@racer.site>
References: <1190625904-22808-1-git-send-email-madcoder@debian.org>
 <1190625904-22808-2-git-send-email-madcoder@debian.org>
 <1190625904-22808-3-git-send-email-madcoder@debian.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Mon Sep 24 12:39:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IZlLZ-0004k5-M2
	for gcvg-git-2@gmane.org; Mon, 24 Sep 2007 12:39:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755203AbXIXKjS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Sep 2007 06:39:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753359AbXIXKjS
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Sep 2007 06:39:18 -0400
Received: from mail.gmx.net ([213.165.64.20]:37831 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752413AbXIXKjR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Sep 2007 06:39:17 -0400
Received: (qmail invoked by alias); 24 Sep 2007 10:39:16 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp045) with SMTP; 24 Sep 2007 12:39:16 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18j98kGw1wj0+s9aLnsf1Vsc89EsL5de/vWBhJiB+
	QcT2p1qYWaWHod
X-X-Sender: gene099@racer.site
In-Reply-To: <1190625904-22808-3-git-send-email-madcoder@debian.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59035>

Hi,

both patches appear to be obviously correct to me.  (However, I was lazy 
enough not to compile and test, but I'd not expect any breakage there, 
given your previous patch serieses.  ;-)

Ciao,
Dscho
