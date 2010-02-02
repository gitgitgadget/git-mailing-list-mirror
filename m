From: Markus Elfring <Markus.Elfring@web.de>
Subject: Re: Completion of error handling
Date: Tue, 02 Feb 2010 21:10:54 +0100
Message-ID: <4B6886CE.9040602@web.de>
References: <4B68249F.6070004@web.de> <alpine.LFD.2.00.1002021324290.1681@xanadu.home> 	<4B6873AC.4030303@web.de> <alpine.LFD.2.00.1002021424550.1681@xanadu.home> 	<4B688042.8090400@web.de> <32541b131002021149g6ffe703erd9e25621e4305a52@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Nicolas Pitre <nico@fluxnic.net>, git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 02 21:15:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcP9n-0000FV-NH
	for gcvg-git-2@lo.gmane.org; Tue, 02 Feb 2010 21:15:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753595Ab0BBUP0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Feb 2010 15:15:26 -0500
Received: from fmmailgate01.web.de ([217.72.192.221]:52762 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752924Ab0BBUPZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Feb 2010 15:15:25 -0500
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate01.web.de (Postfix) with ESMTP id 1B5A6145FCD27;
	Tue,  2 Feb 2010 21:15:24 +0100 (CET)
Received: from [78.49.150.133] (helo=[192.168.1.202])
	by smtp05.web.de with asmtp (WEB.DE 4.110 #314)
	id 1NcP5M-0007Mm-00; Tue, 02 Feb 2010 21:10:56 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.1.5) Gecko/20091130 SUSE/3.0.0-1.1.1 Thunderbird/3.0
In-Reply-To: <32541b131002021149g6ffe703erd9e25621e4305a52@mail.gmail.com>
X-Provags-ID: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138749>


>
> This isn't an opinion; because it's open source, you can actually look
> at the source code and find out that many system calls don't do memory
> allocation at all.
>   

I agree to your view because you distinguish between the available
software implementations here.
Are you also interested to complete error detection and corresponding
exception handling?

Regards,
Markus
