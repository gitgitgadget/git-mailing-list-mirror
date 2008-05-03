From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] I don't known anyone who understands what it means when
 they do a merge and see "file.txt: needs update".  "file.txt: has changes"
 is much clearer.
Date: Sat, 3 May 2008 15:09:42 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0805031509170.30431@racer>
References: <1209798522-13618-1-git-send-email-timcharper@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Tim Harper <timcharper@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 03 16:10:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JsIRb-000269-V8
	for gcvg-git-2@gmane.org; Sat, 03 May 2008 16:10:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755534AbYECOJo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 May 2008 10:09:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755524AbYECOJo
	(ORCPT <rfc822;git-outgoing>); Sat, 3 May 2008 10:09:44 -0400
Received: from mail.gmx.net ([213.165.64.20]:34448 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754218AbYECOJn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 May 2008 10:09:43 -0400
Received: (qmail invoked by alias); 03 May 2008 14:09:42 -0000
Received: from dslb-088-067-214-063.pools.arcor-ip.net (EHLO dslb-088-067-214-063.pools.arcor-ip.net) [88.67.214.63]
  by mail.gmx.net (mp057) with SMTP; 03 May 2008 16:09:42 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+C94BkvcSCQ2mFtrsb5294IElJAcJy4eFw6pHB5s
	Wfc1UQRidNeDOZ
X-X-Sender: gene099@racer
In-Reply-To: <1209798522-13618-1-git-send-email-timcharper@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81090>

Hi,

the subject is a nice joke ;-)


On Sat, 3 May 2008, Tim Harper wrote:

> -			printf("%s: needs update\n", ce->name);
> +			printf("%s: has changes\n", ce->name);

How about "local changes"?

Ciao,
Dscho
