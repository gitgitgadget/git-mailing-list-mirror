From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] docs: explain diff.*.binary option
Date: Sun, 09 Jan 2011 21:31:12 +0100
Message-ID: <vpq7hedsttb.fsf@bauges.imag.fr>
References: <vpqy670brcb.fsf@bauges.imag.fr>
	<20110105051807.GB5884@sigill.intra.peff.net>
	<vpqr5clsy8g.fsf@bauges.imag.fr>
	<20110109201003.GA4406@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Jan 09 21:32:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pc1wg-0003QB-1L
	for gcvg-git-2@lo.gmane.org; Sun, 09 Jan 2011 21:32:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751964Ab1AIUb0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jan 2011 15:31:26 -0500
Received: from mx2.imag.fr ([129.88.30.17]:44672 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750835Ab1AIUbZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jan 2011 15:31:25 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id p09KVAef032492
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 9 Jan 2011 21:31:10 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Pc1uy-00014D-Ci; Sun, 09 Jan 2011 21:31:12 +0100
In-Reply-To: <20110109201003.GA4406@sigill.intra.peff.net> (Jeff King's message of "Sun\, 9 Jan 2011 15\:10\:04 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Sun, 09 Jan 2011 21:31:10 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: p09KVAef032492
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1295209873.96246@0WIGvfh6E8k3ekAL9PsdWw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164862>

Jeff King <peff@peff.net> writes:

> This was added long ago as part of the userdiff refactoring
> for textconv, as internally it made the code simpler and
> cleaner. However, there was never a concrete use case for
> actually using the config variable.
>
> Now that Matthieu Moy has provided such a use case, it's
> easy to explain it using his example.
>
> Signed-off-by: Jeff King <peff@peff.net>

Acked-by: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>

Thanks,

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
