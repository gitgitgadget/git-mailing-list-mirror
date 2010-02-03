From: Markus Elfring <Markus.Elfring@web.de>
Subject: Re: Fix signal handler
Date: Wed, 03 Feb 2010 17:04:12 +0100
Message-ID: <4B699E7C.1030007@web.de>
References: <4B684F5F.7020409@web.de> <20100202205849.GA14385@sigill.intra.peff.net> <4B689CC5.3000400@web.de> <20100202223208.GB18781@sigill.intra.peff.net> <4B694DEE.5030207@web.de> <20100203102915.GA25486@coredump.intra.peff.net> <4B696447.10803@web.de> <20100203151709.GA28477@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 03 17:04:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NchiH-0003Tx-DZ
	for gcvg-git-2@lo.gmane.org; Wed, 03 Feb 2010 17:04:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932476Ab0BCQEQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Feb 2010 11:04:16 -0500
Received: from fmmailgate02.web.de ([217.72.192.227]:58194 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932434Ab0BCQEP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2010 11:04:15 -0500
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate02.web.de (Postfix) with ESMTP id 372C214D04455;
	Wed,  3 Feb 2010 17:04:14 +0100 (CET)
Received: from [78.54.162.123] (helo=[192.168.1.202])
	by smtp06.web.de with asmtp (WEB.DE 4.110 #314)
	id 1NchiA-0004AL-00; Wed, 03 Feb 2010 17:04:14 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.1.5) Gecko/20091130 SUSE/3.0.0-1.1.1 Thunderbird/3.0
In-Reply-To: <20100203151709.GA28477@coredump.intra.peff.net>
X-Sender: Markus.Elfring@web.de
X-Provags-ID: V01U2FsdGVkX1+R1fWp6XZxY4cFsg8/BbjTuXS1iGRKm7nem7mT
	CUajwQKIAlziOYXjADH5/bp+m0uTS9lhcOIOgjDmYTqTcyKBrh
	eDKw1KlDs1GWN9FCNTag==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138844>


>
> If your patch is not too intrusive, and especially if you can demonstrate
> that it is a problem on a real-world system, then I think your patch would
> be considered for inclusion upstream.
>   

I have got the feeling that my corresponding update suggestion (in
source code form) would become intrusive to some degree. If I do not get
an indication that issues from word-tearing in signal handlers is a
mentionable problem here, I assume that your acceptance is low for
potential fixes from every software developer (including me).

Regards,
Markus
