From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 1/2] Allow git-apply to fix up the line counts
Date: Thu, 05 Jun 2008 17:07:15 +0200
Message-ID: <48480123.7030903@viscovery.net>
References: <alpine.DEB.1.00.0806051115570.21190@racer> <4847CCD9.6000305@viscovery.net> <alpine.DEB.1.00.0806051403370.21190@racer> <4847EBC3.8060509@viscovery.net> <alpine.DEB.1.00.0806051441560.21190@racer> <4847F49F.8090004@viscovery.net> <alpine.DEB.1.00.0806051548140.21190@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jun 05 17:08:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4H4X-00023M-B8
	for gcvg-git-2@gmane.org; Thu, 05 Jun 2008 17:08:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754886AbYFEPHT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2008 11:07:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754361AbYFEPHT
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jun 2008 11:07:19 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:20319 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753129AbYFEPHS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2008 11:07:18 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1K4H3b-0007VT-Ld; Thu, 05 Jun 2008 17:07:16 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 698A66B7; Thu,  5 Jun 2008 17:07:15 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <alpine.DEB.1.00.0806051548140.21190@racer>
X-Enigmail-Version: 0.95.5
X-Spam-Score: 0.2 (/)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_80=2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83939>

Johannes Schindelin schrieb:
> So how about --ignore-hunk-headers?  I think this is much more 
> descriptive, and catches your complaint, IMHO.

Yes, that's good as well. :-)

-- Hannes
