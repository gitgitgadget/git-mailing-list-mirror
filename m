From: Michal Ludvig <michal@logix.cz>
Subject: Re: Creating diff from 2.6.16 from cryptodev-2.6 git tree
Date: Fri, 30 Jun 2006 15:05:56 +1200
Message-ID: <44A49514.2050103@logix.cz>
References: <44A47BE0.9060504@logix.cz> <20060630013627.GA27527@gondor.apana.org.au> <Pine.LNX.4.64.0606291904250.12404@g5.osdl.org> <20060630023228.GA28850@gondor.apana.org.au> <Pine.LNX.4.64.0606291943010.12404@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
	linux-crypto@vger.kernel.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 30 05:06:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fw9Kc-0003BF-Dv
	for gcvg-git@gmane.org; Fri, 30 Jun 2006 05:06:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964935AbWF3DGH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Jun 2006 23:06:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964940AbWF3DGG
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jun 2006 23:06:06 -0400
Received: from maxipes.logix.cz ([217.11.251.249]:18925 "EHLO maxipes.logix.cz")
	by vger.kernel.org with ESMTP id S964935AbWF3DGF (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Jun 2006 23:06:05 -0400
Received: from [192.168.159.18] (unknown [192.168.159.18])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by maxipes.logix.cz (Postfix) with ESMTP id 22C57BCC30;
	Fri, 30 Jun 2006 05:06:01 +0200 (CEST)
User-Agent: Thunderbird 1.5.0.4 (X11/20060527)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606291943010.12404@g5.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22950>

Linus Torvalds wrote:

> Note that this is why
> 
> 	git log -p --full-diff v2.6.16.. crypto/
> 
> is so great. It will show everything that touched that subdirectory, along 
> with the incidentals. I think that in this case, that's exactly what 
> Michal wants.

Exactly!

I just want to have the latest greatest CryptoAPI on 2.6.16, it's that
simple ;-)

Thanks both for a quick response

Michal
