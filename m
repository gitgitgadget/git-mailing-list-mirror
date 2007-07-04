From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH take 2] filter-branch: Avoid an error message in the map
  function.
Date: Wed, 4 Jul 2007 13:51:43 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707041351010.4071@racer.site>
References: <11835356473029-git-send-email-johannes.sixt@telecom.at> 
 <Pine.LNX.4.64.0707041205250.4071@racer.site> <468B8852.CB36968@eudaptics.com>
 <Pine.LNX.4.64.0707041247520.4071@racer.site> <468B8DB1.9A4CF1E6@eudaptics.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Sixt <johannes.sixt@telecom.at>, gitster@pobox.com,
	git@vger.kernel.org
To: Johannes Sixt <J.Sixt@eudaptics.com>
X-From: git-owner@vger.kernel.org Wed Jul 04 14:52:22 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I64LF-0004xA-Lr
	for gcvg-git@gmane.org; Wed, 04 Jul 2007 14:52:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759127AbXGDMvy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Jul 2007 08:51:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759144AbXGDMvx
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jul 2007 08:51:53 -0400
Received: from mail.gmx.net ([213.165.64.20]:58509 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759127AbXGDMvx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jul 2007 08:51:53 -0400
Received: (qmail invoked by alias); 04 Jul 2007 12:51:51 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp023) with SMTP; 04 Jul 2007 14:51:51 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18PsypWMjIPt6K3OEoB9Ii6hAGp7q/uRWcaf9CKqt
	CdSHUANYTe78sP
X-X-Sender: gene099@racer.site
In-Reply-To: <468B8DB1.9A4CF1E6@eudaptics.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51605>

Hi,

On Wed, 4 Jul 2007, Johannes Sixt wrote:

> When the map function didn't find the rewritten commit of the passed in
> original id, it printed the original id, but it still fell through to
> the 'cat', which failed with an error message.
> 
> Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>

Thanked-for-and-Acked-by: Johannes Schindelin <johannes.schindelin@gmx.de>

Ciao,
Dscho
