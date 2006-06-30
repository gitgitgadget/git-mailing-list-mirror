From: Michal Ludvig <michal@logix.cz>
Subject: Re: Creating diff from 2.6.16 from cryptodev-2.6 git tree
Date: Fri, 30 Jun 2006 17:45:17 +1200
Message-ID: <44A4BA6D.5010006@logix.cz>
References: <44A47BE0.9060504@logix.cz> <20060630013627.GA27527@gondor.apana.org.au> <Pine.LNX.4.64.0606291904250.12404@g5.osdl.org> <20060630023228.GA28850@gondor.apana.org.au> <Pine.LNX.4.64.0606291943010.12404@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
	linux-crypto@vger.kernel.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 30 07:45:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FwBoq-00069S-1w
	for gcvg-git@gmane.org; Fri, 30 Jun 2006 07:45:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751126AbWF3Fp2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Jun 2006 01:45:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751131AbWF3Fp2
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jun 2006 01:45:28 -0400
Received: from maxipes.logix.cz ([217.11.251.249]:55172 "EHLO maxipes.logix.cz")
	by vger.kernel.org with ESMTP id S1751125AbWF3Fp0 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Jun 2006 01:45:26 -0400
Received: from [192.168.159.18] (unknown [192.168.159.18])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by maxipes.logix.cz (Postfix) with ESMTP id AF43EBCC3C;
	Fri, 30 Jun 2006 07:45:22 +0200 (CEST)
User-Agent: Thunderbird 1.5.0.4 (X11/20060527)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606291943010.12404@g5.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22958>

Linus Torvalds wrote:

> 	git log -p --full-diff v2.6.16.. crypto/

Can I somehow get the result in a reverse order, i.e. oldest commits first?

As it is the patch conflicts on files that were changed multiple times
since 2.6.16 :-(

Will see if patchutils can help me somehow...

Michal
