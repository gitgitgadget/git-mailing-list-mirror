From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] gitk: fix 'can't read "notflag"'
Date: Thu, 04 Dec 2008 16:59:21 +0100
Message-ID: <4937FE59.2030906@viscovery.net>
References: <gh5q1t$qjn$1@ger.gmane.org> <alpine.DEB.1.00.0812041532160.7045@racer> <alpine.DEB.1.00.0812041609150.7045@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Paul Mackerras <paulus@samba.org>,
	Alejandro Riveira <ariveira@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Dec 04 17:00:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L8GdB-0005bM-C1
	for gcvg-git-2@gmane.org; Thu, 04 Dec 2008 17:00:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751646AbYLDP70 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Dec 2008 10:59:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751695AbYLDP70
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Dec 2008 10:59:26 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:19229 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751646AbYLDP7Z (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Dec 2008 10:59:25 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1L8Gbp-0000a5-Nb; Thu, 04 Dec 2008 16:59:21 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 7E4C54FB; Thu,  4 Dec 2008 16:59:21 +0100 (CET)
User-Agent: Thunderbird 2.0.0.18 (Windows/20081105)
In-Reply-To: <alpine.DEB.1.00.0812041609150.7045@racer>
X-Spam-Score: -1.4 (-)
X-Spam-Report: Spam detection software, running on the system "lilzmailsa01.liwest.at", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Johannes Schindelin schrieb: > On Thu, 4 Dec 2008, Johannes
	Schindelin wrote: > >> diff --git a/gitk-git/gitk b/gitk-git/gitk > > D'oh.
	Please apply with -p2. No; pull -s subtree before you write this patch ;)
	It's already fixed in upstream gitk. [...] 
	Content analysis details:   (-1.4 points, 7.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-1.4 ALL_TRUSTED            Passed through trusted hosts only via SMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102344>

Johannes Schindelin schrieb:
> On Thu, 4 Dec 2008, Johannes Schindelin wrote:
> 
>> diff --git a/gitk-git/gitk b/gitk-git/gitk
> 
> D'oh.  Please apply with -p2.

No; pull -s subtree before you write this patch ;) It's already fixed in
upstream gitk.

-- Hannes
