From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 4/4] command-list: mention git-credential-* helpers
Date: Thu, 09 Aug 2012 10:02:38 +0200
Message-ID: <vpq7gt8biht.fsf@bauges.imag.fr>
References: <20120808183132.GA24550@sigill.intra.peff.net>
	<20120808183449.GD24574@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Aug 09 10:03:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SzNi5-00008f-Gv
	for gcvg-git-2@plane.gmane.org; Thu, 09 Aug 2012 10:03:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755973Ab2HIIDE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Aug 2012 04:03:04 -0400
Received: from mx2.imag.fr ([129.88.30.17]:50970 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755366Ab2HIIDA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Aug 2012 04:03:00 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q797xUaK022200
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 9 Aug 2012 09:59:30 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1SzNhX-0004fE-Ue; Thu, 09 Aug 2012 10:02:40 +0200
In-Reply-To: <20120808183449.GD24574@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 8 Aug 2012 14:34:49 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 09 Aug 2012 09:59:36 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q797xUaK022200
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1345103978.61989@CDghJ8BHAhSBOZgqlaXfkg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203154>

Jeff King <peff@peff.net> writes:

> These commands were never added to the command-list. Adding
> them makes "make check-docs" run without complaint.
> While we're at it, let's capitalize the first letter of
> their one-line summaries to match the rest of the git
> manpages.

You may want to squash my patch in this one, since they really do the
same thing.

In any case, thanks for taking care of this, the patches sound good.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
