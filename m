From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 1/2] t2200: check that "add -u" limits itself to subdirectory
Date: Wed, 13 Mar 2013 09:52:51 +0100
Message-ID: <vpq8v5rel5o.fsf@grenoble-inp.fr>
References: <20130313040845.GA5057@sigill.intra.peff.net>
	<20130313041022.GA5378@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 13 09:53:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UFhRM-0002Ad-Le
	for gcvg-git-2@plane.gmane.org; Wed, 13 Mar 2013 09:53:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755495Ab3CMIxL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Mar 2013 04:53:11 -0400
Received: from mx1.imag.fr ([129.88.30.5]:57655 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755429Ab3CMIxJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Mar 2013 04:53:09 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r2D8qoFo014530
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 13 Mar 2013 09:52:50 +0100
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1UFhQZ-0004Pv-Bn; Wed, 13 Mar 2013 09:52:51 +0100
In-Reply-To: <20130313041022.GA5378@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 13 Mar 2013 00:10:22 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 13 Mar 2013 09:52:51 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r2D8qoFo014530
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1363769572.44624@65OdmBri5AkxzEwEzbfdxA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218040>

Jeff King <peff@peff.net> writes:

> This behavior is due to change in the future, but let's test
> it anyway.

Thanks. This should be merged regardless of PATCH 2/2 I think.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
