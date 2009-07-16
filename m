From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH v5] Re: git-am: allow e-mail file(s) as input
Date: Thu, 16 Jul 2009 10:12:26 +0200
Message-ID: <4A5EE0EA.5000008@viscovery.net>
References: <7v7hy9bb8k.fsf@alter.siamese.dyndns.org> <eb6317e39369adc8d2594c35ee351b49aaadcc24.1247721562.git.nicolas.s.dev@gmx.fr> <4A5ED22B.6050101@gmail.com> <7v8wip9jjw.fsf@alter.siamese.dyndns.org> <20090716075055.GI12971@vidovic>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Stephen Boyd <bebarino@gmail.com>, git@vger.kernel.org
To: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
X-From: git-owner@vger.kernel.org Thu Jul 16 10:12:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MRM58-00045a-IB
	for gcvg-git-2@gmane.org; Thu, 16 Jul 2009 10:12:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753587AbZGPIMc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jul 2009 04:12:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753473AbZGPIMc
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Jul 2009 04:12:32 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:23340 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753319AbZGPIMb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jul 2009 04:12:31 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1MRM4p-0004gt-BP; Thu, 16 Jul 2009 10:12:27 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 0081F9F88; Thu, 16 Jul 2009 10:12:26 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <20090716075055.GI12971@vidovic>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123386>

Nicolas Sebrecht schrieb:
> The 16/07/09, Junio C Hamano wrote:
>>                                         introduces [[:blank::]] where
>> space and tab inside [] is perfectly adequate, and we know the latter is
>> understood by everybody's sed.
> 
> But is harder to read in editors.

Tough luck. [[:blank:]] is a *portability* obstacle.

-- Hannes
