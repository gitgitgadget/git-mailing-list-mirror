From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 10/10] clone: accept config options on the command line
Date: Fri, 10 Jun 2011 00:34:06 +0200
Message-ID: <vpqtyby8wip.fsf@bauges.imag.fr>
References: <20110609155001.GA14969@sigill.intra.peff.net>
	<20110609155740.GJ25507@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Claire Fousse <claire.fousse@ensimag.imag.fr>, git@vger.kernel.org,
	Sylvain Boulme <Sylvain.Boulme@imag.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jun 10 00:34:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUnnz-0008VM-LR
	for gcvg-git-2@lo.gmane.org; Fri, 10 Jun 2011 00:34:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756921Ab1FIWeU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jun 2011 18:34:20 -0400
Received: from mx2.imag.fr ([129.88.30.17]:57669 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755385Ab1FIWeS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jun 2011 18:34:18 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id p59MY3T5023150
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 10 Jun 2011 00:34:03 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1QUnni-0006NO-JJ; Fri, 10 Jun 2011 00:34:06 +0200
In-Reply-To: <20110609155740.GJ25507@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 9 Jun 2011 11:57:40 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 10 Jun 2011 00:34:03 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: p59MY3T5023150
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1308263643.97218@XUzgKxiT+Ystx7SfNZdNoA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175583>

Jeff King <peff@peff.net> writes:

> Yay, the actual patch. Even if we don't end up using this for transport
> helpers, I think it's a sane thing to allow (e.g., see the final test
> below).

Ack.

I reviewed quickly the serie, which seems OK. Nice work, amazing serie
of patches to end up with this trivial one ;-).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
