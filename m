From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: quick bare clones taking longer?
Date: Thu, 10 May 2007 10:55:28 +0200
Message-ID: <vpq4pmlys5b.fsf@bauges.imag.fr>
References: <7virb1sm6h.fsf@assigned-by-dhcp.cox.net>
	<20070509.150256.59469756.davem@davemloft.net>
	<7v3b25siwk.fsf@assigned-by-dhcp.cox.net>
	<20070509.162301.48802460.davem@davemloft.net>
	<7vy7jxr35a.fsf@assigned-by-dhcp.cox.net>
	<7vd519r10c.fsf@assigned-by-dhcp.cox.net>
	<vpqtzul3xzm.fsf@bauges.imag.fr>
	<7vejlpkruy.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 10 10:55:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hm4R7-00055u-Cy
	for gcvg-git@gmane.org; Thu, 10 May 2007 10:55:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756139AbXEJIzk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 May 2007 04:55:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756158AbXEJIzk
	(ORCPT <rfc822;git-outgoing>); Thu, 10 May 2007 04:55:40 -0400
Received: from imag.imag.fr ([129.88.30.1]:65531 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756139AbXEJIzj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 May 2007 04:55:39 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id l4A8tSiQ009005
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 10 May 2007 10:55:28 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1Hm4Qq-0006jO-9m; Thu, 10 May 2007 10:55:28 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1Hm4Qq-00030m-7U; Thu, 10 May 2007 10:55:28 +0200
Mail-Followup-To: git@vger.kernel.org
In-Reply-To: <7vejlpkruy.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's message of "Thu\, 10 May 2007 01\:25\:25 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.97 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Thu, 10 May 2007 10:55:28 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46850>

Junio C Hamano <junkio@cox.net> writes:

> Is that a serious question?

It is. I have to admit that my knowledge about POSIX kind of things on
windows approaches zero, but a hardcoded /bin/something path sounds
suspicious to me.

Nothing more, nothing less in my question.

-- 
Matthieu
