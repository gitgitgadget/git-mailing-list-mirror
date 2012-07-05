From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v4] git-remote-mediawiki: import "File:" attachments
Date: Thu, 05 Jul 2012 09:42:50 +0200
Message-ID: <vpqtxxmejr9.fsf@bauges.imag.fr>
References: <1340806889-23081-1-git-send-email-Matthieu.Moy@imag.fr>
	<1341406416-1251-1-git-send-email-Matthieu.Moy@imag.fr>
	<7vk3yisnhe.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Pavel Volek <Pavel.Volek@ensimag.imag.fr>,
	NGUYEN Kim Thuat <Kim-Thuat.Nguyen@ensimag.imag.fr>,
	ROUCHER IGLESIAS Javier <roucherj@ensimag.imag.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 05 09:43:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SmgiN-0003fS-0p
	for gcvg-git-2@plane.gmane.org; Thu, 05 Jul 2012 09:43:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754848Ab2GEHm6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jul 2012 03:42:58 -0400
Received: from mx2.imag.fr ([129.88.30.17]:56364 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754404Ab2GEHm5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jul 2012 03:42:57 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q657ff29012357
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 5 Jul 2012 09:41:41 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1SmgiA-0006tf-VV; Thu, 05 Jul 2012 09:42:51 +0200
In-Reply-To: <7vk3yisnhe.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Wed, 04 Jul 2012 23:58:37 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 05 Jul 2012 09:41:41 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q657ff29012357
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1342078902.79232@EeuwY5DZnI3Ql0VSp5ztTA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201037>

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@imag.fr> writes:
>
>> This is meant to replace commit 6a9e55b0fc5df40 in branch
>> mm/mediawiki-file-attachments in pu.
>
> Bad timing for our mails to cross; it is already on 'next'.
>
> Would the following be a good "incremental update" on top of the
> named commit?

Yes, that is perfect.

Thanks,

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
