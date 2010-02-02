From: Markus Elfring <Markus.Elfring@web.de>
Subject: Re: Completion of error handling
Date: Tue, 02 Feb 2010 22:26:53 +0100
Message-ID: <4B68989D.80906@web.de>
References: <4B68249F.6070004@web.de> <alpine.LFD.2.00.1002021324290.1681@xanadu.home> 	<4B6873AC.4030303@web.de> <alpine.LFD.2.00.1002021424550.1681@xanadu.home> 	<4B688042.8090400@web.de> <32541b131002021149g6ffe703erd9e25621e4305a52@mail.gmail.com> 	<4B6886CE.9040602@web.de> <32541b131002021225k19ef94b2me8ef40cd502b85d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Nicolas Pitre <nico@fluxnic.net>, git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 02 22:27:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcQH1-0007XO-Eg
	for gcvg-git-2@lo.gmane.org; Tue, 02 Feb 2010 22:27:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756630Ab0BBV06 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Feb 2010 16:26:58 -0500
Received: from fmmailgate02.web.de ([217.72.192.227]:38593 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756013Ab0BBV05 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Feb 2010 16:26:57 -0500
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate02.web.de (Postfix) with ESMTP id 2E52314CFA214;
	Tue,  2 Feb 2010 22:26:56 +0100 (CET)
Received: from [78.49.150.133] (helo=[192.168.1.202])
	by smtp05.web.de with asmtp (WEB.DE 4.110 #314)
	id 1NcQGu-0007R5-00; Tue, 02 Feb 2010 22:26:56 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.1.5) Gecko/20091130 SUSE/3.0.0-1.1.1 Thunderbird/3.0
In-Reply-To: <32541b131002021225k19ef94b2me8ef40cd502b85d@mail.gmail.com>
X-Sender: Markus.Elfring@web.de
X-Provags-ID: V01U2FsdGVkX1+dyo/f4wG/pFk5Zhv3Rc6WsWxODY96QM/bT433
	0aLz4rYHlEyoU6oIq3kHeHgb83pj64hiWaIm9Fy6593UMYkLwf
	hv8x3Zm0puouwCfKKbtg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138759>


>
> ...then it will be easy to get people to accept your patches to fix
> the error handling.
>   

You do not need to make assumptions about error situations. Please check
all error codes.
Otherwise, it might not be noticed if anything unexpected went wrong.

Regards,
Markus
