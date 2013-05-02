From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v4 2/3] Show items of interactive git-clean in columns
Date: Thu, 02 May 2013 17:03:25 +0200
Message-ID: <vpqppx9fmpu.fsf@grenoble-inp.fr>
References: <6e795640952cad0eb25cb0db4243b2712f11e957.1367500374.git.worldhello.net@gmail.com>
	<vpq38u6n397.fsf@grenoble-inp.fr>
	<3b80db3d2e8f31b1d9373406cce3cbdee2094a29.1367500374.git.worldhello.net@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Thomas Rast <trast@inf.ethz.ch>, Git List <git@vger.kernel.org>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 02 17:03:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXv2p-0003Qf-N2
	for gcvg-git-2@plane.gmane.org; Thu, 02 May 2013 17:03:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755512Ab3EBPDf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 May 2013 11:03:35 -0400
Received: from mx2.imag.fr ([129.88.30.17]:59049 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753159Ab3EBPDf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 May 2013 11:03:35 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r42F3N7I031403
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 2 May 2013 17:03:23 +0200
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1UXv2b-0007YM-EY; Thu, 02 May 2013 17:03:25 +0200
In-Reply-To: <3b80db3d2e8f31b1d9373406cce3cbdee2094a29.1367500374.git.worldhello.net@gmail.com>
	(Jiang Xin's message of "Thu, 2 May 2013 21:15:03 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 02 May 2013 17:03:24 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r42F3N7I031403
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1368111805.08829@1Btu+RGjcIHqFcuh20oRcQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223211>

Jiang Xin <worldhello.net@gmail.com> writes:

> Signed-off-by: Jiang Xin <worldhello.net@gmail.com>

This lacks a proper commit message (why is this a good thing?), and
documentation (you introduce column.clean) but the code sounds good
(that's a very quick look from me, not a "review" sorry).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
