From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] git-commit --amend: respect grafted parents.
Date: Wed, 26 Sep 2007 16:29:43 +0200
Message-ID: <46FA6CD7.1020709@viscovery.net>
References: <11908086961933-git-send-email-johannes.sixt@telecom.at> <Pine.LNX.4.64.0709261322150.28395@racer.site> <46FA5604.101@viscovery.net> <Pine.LNX.4.64.0709261501190.28395@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <johannes.sixt@telecom.at>, gitster@pobox.com,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Sep 26 16:33:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IaXxE-0003XS-TF
	for gcvg-git-2@gmane.org; Wed, 26 Sep 2007 16:33:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761970AbXIZO3u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Sep 2007 10:29:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761762AbXIZO3t
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Sep 2007 10:29:49 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:65451 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762056AbXIZO3s (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Sep 2007 10:29:48 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1IaXtY-0007VR-AZ; Wed, 26 Sep 2007 16:29:44 +0200
Received: from [192.168.1.42] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 124A254D; Wed, 26 Sep 2007 16:29:44 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <Pine.LNX.4.64.0709261501190.28395@racer.site>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59233>

Johannes Schindelin schrieb:
> The reason why I insist on not putting this into --amend is that I think 
> this is not really an amend, but actively a rewrite of the merge commit.  

You have a point here. I'm convinced. Scrap the patch.

-- Hannes
