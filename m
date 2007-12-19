From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] Catch and handle git-commit failures in git-rebase
 --interactive
Date: Wed, 19 Dec 2007 12:21:21 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0712191220520.23902@racer.site>
References: <20071219064500.GB8915@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Dec 19 13:22:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4xw4-0008Ol-EB
	for gcvg-git-2@gmane.org; Wed, 19 Dec 2007 13:22:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753103AbXLSMVl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Dec 2007 07:21:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753025AbXLSMVl
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Dec 2007 07:21:41 -0500
Received: from mail.gmx.net ([213.165.64.20]:37469 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752682AbXLSMVk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Dec 2007 07:21:40 -0500
Received: (qmail invoked by alias); 19 Dec 2007 12:21:37 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp058) with SMTP; 19 Dec 2007 13:21:37 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/Aq4dEpLPAC7PP3tQyEmaA6N75QNED7pe8dOlkuK
	923M6zdiogzgu7
X-X-Sender: gene099@racer.site
In-Reply-To: <20071219064500.GB8915@spearce.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68902>

Hi,

On Wed, 19 Dec 2007, Shawn O. Pearce wrote:

>  This has also bitten me a few times. :-\

Sorry to hear that.  Both patches look sensible to me.

Ciao,
Dscho
