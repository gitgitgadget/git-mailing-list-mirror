From: Markus Elfring <Markus.Elfring@web.de>
Subject: Re: Completion of error handling
Date: Tue, 02 Feb 2010 22:55:03 +0100
Message-ID: <4B689F37.1030701@web.de>
References: <4B68249F.6070004@web.de> <alpine.LFD.2.00.1002021324290.1681@xanadu.home> 	<4B6873AC.4030303@web.de> <alpine.LFD.2.00.1002021424550.1681@xanadu.home> 	<4B688042.8090400@web.de> <32541b131002021149g6ffe703erd9e25621e4305a52@mail.gmail.com> 	<4B6886CE.9040602@web.de> <32541b131002021225k19ef94b2me8ef40cd502b85d@mail.gmail.com> 	<4B68989D.80906@web.de> <32541b131002021327u29e666b8ia5c6aab25fb55688@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Nicolas Pitre <nico@fluxnic.net>, git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 02 22:55:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcQiJ-00018Q-Rs
	for gcvg-git-2@lo.gmane.org; Tue, 02 Feb 2010 22:55:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756760Ab0BBVzJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Feb 2010 16:55:09 -0500
Received: from fmmailgate01.web.de ([217.72.192.221]:34093 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755435Ab0BBVzH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Feb 2010 16:55:07 -0500
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate01.web.de (Postfix) with ESMTP id 64511145FD9A4;
	Tue,  2 Feb 2010 22:55:06 +0100 (CET)
Received: from [78.49.150.133] (helo=[192.168.1.202])
	by smtp07.web.de with asmtp (WEB.DE 4.110 #314)
	id 1NcQiA-0004lE-00; Tue, 02 Feb 2010 22:55:06 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.1.5) Gecko/20091130 SUSE/3.0.0-1.1.1 Thunderbird/3.0
In-Reply-To: <32541b131002021327u29e666b8ia5c6aab25fb55688@mail.gmail.com>
X-Sender: Markus.Elfring@web.de
X-Provags-ID: V01U2FsdGVkX19eDdhwtkFu6BO3pPfOTCBKFJCSLg05+etkietD
	7CevOX9SgHk9RsZcyU1GG2DR6zRUrDlSzfyCnUndck0fIgSJ6C
	aqMQ7dsFP4BpbgoKahuA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138762>


>
> If you never notice, then that's a good thing, right? :)
>   

Well, this depends on the kind of potential damage that will come from
the ignorance of function return values.
It might hurt more when corresponding effects can not be ignorable any
more because they became so obvious.

Regards,
Markus
