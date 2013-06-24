From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH/RFC 3/4] git-mw: Adding git-mw.perl script
Date: Mon, 24 Jun 2013 16:26:21 +0200
Message-ID: <vpqsj07vb3m.fsf@anie.imag.fr>
References: <1371118039-18925-1-git-send-email-benoit.person@ensimag.fr>
	<1371118039-18925-4-git-send-email-benoit.person@ensimag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Celestin Matte <celestin.matte@ensimag.fr>,
	Jeff King <peff@peff.net>
To: benoit.person@ensimag.fr
X-From: git-owner@vger.kernel.org Mon Jun 24 16:26:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ur7j3-0004UF-GR
	for gcvg-git-2@plane.gmane.org; Mon, 24 Jun 2013 16:26:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751204Ab3FXO0c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Jun 2013 10:26:32 -0400
Received: from mx2.imag.fr ([129.88.30.17]:43395 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750875Ab3FXO0c (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jun 2013 10:26:32 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r5OEQKY5015668
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 24 Jun 2013 16:26:20 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Ur7io-0005ZO-1K; Mon, 24 Jun 2013 16:26:22 +0200
In-Reply-To: <1371118039-18925-4-git-send-email-benoit.person@ensimag.fr>
	(benoit person's message of "Thu, 13 Jun 2013 12:07:18 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 24 Jun 2013 16:26:21 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228817>

benoit.person@ensimag.fr writes:

> diff --git a/contrib/mw-to-git/git-mw.perl b/contrib/mw-to-git/git-mw.perl
> new file mode 100644
> index 0000000..a2f0aa1
> --- /dev/null
> +++ b/contrib/mw-to-git/git-mw.perl

*.perl scripts are usually executable in Git's tree (although it's
usually better to run the non-*.perl version).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
