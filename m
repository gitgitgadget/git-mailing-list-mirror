From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH v2] user-manual: add advanced topic "bisecting merges"
Date: Thu, 08 Nov 2007 08:19:53 +0100
Message-ID: <4732B899.6000908@viscovery.net>
References: <20071104112302.GA2119@ins.uni-bonn.de> <11944722214046-git-send-email-prohaska@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, Ralf.Wildenhues@gmx.de, tsuna@lrde.epita.fr,
	git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Thu Nov 08 08:20:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iq1gU-0004Ly-Kq
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 08:20:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754879AbXKHHT6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2007 02:19:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754403AbXKHHT6
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 02:19:58 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:51080 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751552AbXKHHT5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2007 02:19:57 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Iq1fi-0000mC-2N; Thu, 08 Nov 2007 08:19:26 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id AD6F96B7; Thu,  8 Nov 2007 08:19:53 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <11944722214046-git-send-email-prohaska@zib.de>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63941>

Steffen Prohaska schrieb:
> +If you linearize the history by rebasing the lower branch on
> +top of the upper, instead of merging, the bug becomes much easier to
> +find and understand.  Your history would instead be:

At this point I'm missing the words

	The solution is ...

I.e.:

The solution is to linearize the history by rebasing the lower branch on
top of the upper, instead of merging. Now the bug becomes much easier to
find and understand.  Your history would instead be:

-- Hannes
