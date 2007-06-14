From: Sam Vilain <sam@vilain.net>
Subject: Re: [PATCH] Interpret :/<pattern> as a regular expression
Date: Thu, 14 Jun 2007 21:07:40 +1200
Message-ID: <4671055C.4050609@vilain.net>
References: <Pine.LNX.4.64.0706130148080.4059@racer.site> <20070613184109.GG10941@coredump.intra.peff.net> <Pine.LNX.4.64.0706131953370.4059@racer.site> <20070613200011.GA17360@coredump.intra.peff.net> <Pine.LNX.4.64.0706132317240.4059@racer.site> <4670F2BB.5060909@vilain.net> <Pine.LNX.4.64.0706140909360.4059@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jun 14 11:08:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HylJG-0001Cm-Oa
	for gcvg-git@gmane.org; Thu, 14 Jun 2007 11:08:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751016AbXFNJIA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Jun 2007 05:08:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751142AbXFNJIA
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jun 2007 05:08:00 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:49718 "EHLO
	magnus.utsl.gen.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751015AbXFNJIA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jun 2007 05:08:00 -0400
Received: by magnus.utsl.gen.nz (Postfix, from userid 65534)
	id 589A513A4FA; Thu, 14 Jun 2007 21:07:57 +1200 (NZST)
Received: from [192.168.1.5] (203-97-235-49.cable.telstraclear.net [203.97.235.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by magnus.utsl.gen.nz (Postfix) with ESMTP id 841AB13A4F0;
	Thu, 14 Jun 2007 21:07:52 +1200 (NZST)
User-Agent: Thunderbird 1.5.0.4 (X11/20060615)
In-Reply-To: <Pine.LNX.4.64.0706140909360.4059@racer.site>
X-Enigmail-Version: 0.94.0.0
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on 
	mail.magnus.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=0.4 required=5.0 tests=SPF_HELO_FAIL autolearn=no 
	version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50183>

Johannes Schindelin wrote:
>> A strange thing to conclude from your figures, which show pcre as the 
>> fastest out of several libraries that you tested.
>>     
>
> The best of the worse. Yes. An external (!) program was 4x faster than 
> pcre. I don't know how to make it more obvious that pcre sucks.
>   

Oh, your position is obvious enough, but it is correct and supportable
by the available evidence? Why not read past the first paragraph of my
post and reply to that.

Sam.
