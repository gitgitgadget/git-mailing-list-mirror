From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] shell portability: Use sed instead of non-portable variable
 expansion
Date: Mon, 05 Sep 2011 10:21:49 +0200
Message-ID: <4E64869D.8060601@viscovery.net>
References: <8762l73758.fsf@elisp.net> <4E647442.9000005@viscovery.net> <7v7h5nxxwf.fsf@alter.siamese.dyndns.org> <4E647BD5.8060609@viscovery.net> <7v39gbxwi6.fsf@alter.siamese.dyndns.org> <4E648546.8060303@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Naohiro Aota <naota@elisp.net>,
	git@vger.kernel.org, tarmigan+git@gmail.com
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Mon Sep 05 10:21:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R0URJ-0008HJ-Td
	for gcvg-git-2@lo.gmane.org; Mon, 05 Sep 2011 10:21:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750791Ab1IEIVx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Sep 2011 04:21:53 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:29319 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751469Ab1IEIVv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Sep 2011 04:21:51 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1R0URC-0006gI-0D; Mon, 05 Sep 2011 10:21:50 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id B77421660F;
	Mon,  5 Sep 2011 10:21:49 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.21) Gecko/20110830 Thunderbird/3.1.13
In-Reply-To: <4E648546.8060303@viscovery.net>
X-Spam-Score: 0.1 (/)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180728>

Am 9/5/2011 10:16, schrieb Johannes Sixt:
> The most visible difference is a backslash that is followed by a character
> that is not special:

I should have said: "The difference that I can see immediately is...". I
suspect there are other subtle differences that are not so obvious to me.

-- Hannes
