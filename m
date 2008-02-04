From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] [v8] safecrlf: Add mechanism to warn about irreversible
 crlf conversions
Date: Mon, 4 Feb 2008 15:02:55 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802041502290.7372@racer.site>
References: <86F2B863-6FE8-407E-B535-3F49782DA5F9@zib.de> <12021001351967-git-send-email-prohaska@zib.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Mon Feb 04 16:04:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JM2re-0000p6-Cr
	for gcvg-git-2@gmane.org; Mon, 04 Feb 2008 16:04:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752020AbYBDPDe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2008 10:03:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752014AbYBDPDe
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Feb 2008 10:03:34 -0500
Received: from mail.gmx.net ([213.165.64.20]:40027 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751995AbYBDPDd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2008 10:03:33 -0500
Received: (qmail invoked by alias); 04 Feb 2008 15:03:31 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp009) with SMTP; 04 Feb 2008 16:03:31 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX184kBJZPog4uDXWzZcTyF2hFxQKYo5bYlvEhK3pS/
	6uSR/LK+p4f9AP
X-X-Sender: gene099@racer.site
In-Reply-To: <12021001351967-git-send-email-prohaska@zib.de>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72513>

Hi,

On Mon, 4 Feb 2008, Steffen Prohaska wrote:

>  - refactored to lines max 84 chars long.

Why 84?  I think the standard is still 80.

Ciao,
Dscho
