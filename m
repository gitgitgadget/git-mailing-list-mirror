From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/4] Fix diff regression for submodules not checked out
Date: Sat, 3 May 2008 13:36:49 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0805031335380.30431@racer>
References: <46dff0320804300856w941d948rbcc1cee06f1b41a9@mail.gmail.com> <1209735336-4690-1-git-send-email-pkufranky@gmail.com> <1209735336-4690-2-git-send-email-pkufranky@gmail.com> <1209735336-4690-3-git-send-email-pkufranky@gmail.com>
 <1209735336-4690-4-git-send-email-pkufranky@gmail.com> <7vfxt0wdkq.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Ping Yin <pkufranky@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 03 14:38:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JsH0F-000755-0p
	for gcvg-git-2@gmane.org; Sat, 03 May 2008 14:38:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753939AbYECMg4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 May 2008 08:36:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752742AbYECMg4
	(ORCPT <rfc822;git-outgoing>); Sat, 3 May 2008 08:36:56 -0400
Received: from mail.gmx.net ([213.165.64.20]:58964 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752689AbYECMgz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 May 2008 08:36:55 -0400
Received: (qmail invoked by alias); 03 May 2008 12:36:53 -0000
Received: from dslb-088-067-214-063.pools.arcor-ip.net (EHLO dslb-088-067-214-063.pools.arcor-ip.net) [88.67.214.63]
  by mail.gmx.net (mp004) with SMTP; 03 May 2008 14:36:53 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1888IM1SKc8FNQK0iLBC8rHcOm3eWXL02qNYi245U
	AEIKtxVrmfmQrW
X-X-Sender: gene099@racer
In-Reply-To: <7vfxt0wdkq.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81074>

Hi,

On Fri, 2 May 2008, Junio C Hamano wrote:

> By the way, "inexistent" is a word, but somehow it sounds quite awkward.

In the same vein, I had to think about "stagable" for some time.  I think 
the correct term is "stageable", but then, I am not sure if there is no 
better word anyway.

Ciao,
Dscho
