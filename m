From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 3/3] api-credentials.txt: add "see also" section
Date: Mon, 04 Jun 2012 13:31:30 +0200
Message-ID: <vpq1ulvuxd9.fsf@bauges.imag.fr>
References: <1338739804-32167-1-git-send-email-Matthieu.Moy@imag.fr>
	<1338739804-32167-4-git-send-email-Matthieu.Moy@imag.fr>
	<7vsjecvxmc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 04 13:31:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SbVVc-0008Lq-Ns
	for gcvg-git-2@plane.gmane.org; Mon, 04 Jun 2012 13:31:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752758Ab2FDLbg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Jun 2012 07:31:36 -0400
Received: from mx2.imag.fr ([129.88.30.17]:47388 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752618Ab2FDLbf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jun 2012 07:31:35 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q54BMomn023053
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 4 Jun 2012 13:22:50 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1SbVVT-00060b-1Z; Mon, 04 Jun 2012 13:31:31 +0200
In-Reply-To: <7vsjecvxmc.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Sun, 03 Jun 2012 15:28:27 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 04 Jun 2012 13:22:51 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q54BMomn023053
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1339413771.34621@74Tpimzw5NynK7b5UQ1sow
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199126>

Junio C Hamano <gitster@pobox.com> writes:

> Thanks.  All looked good.
>
> This is the first one that refers to "../something" with "linkgit:";
> do they format sensibly?

On my machine (Debian stable), the HTML formatting is correct (and BTW,
the other instance of linkgit in technical, "(see
linkgit:gitattributes[5])" is broken). One can see the .. in the link,
but at least the target of the link is OK. I didn't worry too much about
formatting since this is a technical documentation.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
