From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Introduce git version --list-features for porcelain use
Date: Thu, 21 Jun 2007 12:58:17 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706211257060.4059@racer.site>
References: <20070621045903.GA14047@spearce.org> <7v1wg55065.fsf@assigned-by-dhcp.pobox.com>
 <20070621061045.GG8477@spearce.org> <7vr6o5zt76.fsf@assigned-by-dhcp.pobox.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 21 13:58:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I1LIu-0001f9-6U
	for gcvg-git@gmane.org; Thu, 21 Jun 2007 13:58:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754076AbXFUL6W (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Jun 2007 07:58:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754041AbXFUL6W
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jun 2007 07:58:22 -0400
Received: from mail.gmx.net ([213.165.64.20]:51113 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753117AbXFUL6W (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jun 2007 07:58:22 -0400
Received: (qmail invoked by alias); 21 Jun 2007 11:58:20 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp042) with SMTP; 21 Jun 2007 13:58:20 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19BDr9eayZBFmOr2W6hwVrmP85tJUymJ/sAtafOtV
	GReMv1B7s2SQUo
X-X-Sender: gene099@racer.site
In-Reply-To: <7vr6o5zt76.fsf@assigned-by-dhcp.pobox.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50616>

Hi,

On Thu, 21 Jun 2007, Junio C Hamano wrote:

> [...] using "git version" to check the version and say "1.5.3 has blame 
> -w" > might be easier to manage [ than list-features maintenance ...]

We do something similar already with curl features. So this sounds 
sensible to me. Shawn?

Ciao,
Dscho
