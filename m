From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 3/4] {fast-export,transport-helper}: style cleanups
Date: Fri, 17 May 2013 18:56:05 +0200
Message-ID: <vpqvc6hczq2.fsf@grenoble-inp.fr>
References: <1368062218-22440-1-git-send-email-felipe.contreras@gmail.com>
	<1368062218-22440-4-git-send-email-felipe.contreras@gmail.com>
	<CAEBDL5XZhEo14WKiz2m3KFRX+NsTFhmcz3adSti33RATMd897w@mail.gmail.com>
	<7v7gj77nt9.fsf@alter.siamese.dyndns.org>
	<CAMP44s1HDp+ojGK0UhKHF=1iDu5_E9Z0VrK-JtMked1mtH_2gQ@mail.gmail.com>
	<CAMP44s3J8YpULYenDoYhyRJXSXL3b8-vpMbW2c4LcjK43Xidng@mail.gmail.com>
	<7vwqqy7v8g.fsf@alter.siamese.dyndns.org>
	<CAMP44s17aD_ryeGWQazTcJ3nrhe6C9TLhKHhrUnys=Yj_ATa0A@mail.gmail.com>
	<7vzjvu6faq.fsf@alter.siamese.dyndns.org>
	<CAMP44s3c1vdCn43S=nSzfj=znZ9L_7jH9-+EOY0+SZNnSBTVbw@mail.gmail.com>
	<7vfvxm6biv.fsf@alter.siamese.dyndns.org>
	<CAMP44s2QcFStPtE8cSbH7jWvUOUVRSgGNYNVoDN6exRdW6xNYA@mail.gmail.com>
	<7vobc91squ.fsf@alter.siamese.dyndns.org>
	<CAMP44s0o7tgUrz4xQh3H62+=625ppAOMFskOL70Nrx-O5uwaYw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	John Szakmeister <john@szakmeister.net>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 17 18:57:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UdNy5-0000rE-Ii
	for gcvg-git-2@plane.gmane.org; Fri, 17 May 2013 18:57:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756277Ab3EQQ5R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 May 2013 12:57:17 -0400
Received: from mx1.imag.fr ([129.88.30.5]:43168 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756255Ab3EQQ5Q (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 May 2013 12:57:16 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r4HGu4SU010376
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 17 May 2013 18:56:04 +0200
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1UdNws-0006Oy-3L; Fri, 17 May 2013 18:56:06 +0200
In-Reply-To: <CAMP44s0o7tgUrz4xQh3H62+=625ppAOMFskOL70Nrx-O5uwaYw@mail.gmail.com>
	(Felipe Contreras's message of "Fri, 17 May 2013 11:35:48 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 17 May 2013 18:56:04 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r4HGu4SU010376
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1369414568.34969@LlUpSM1Wu8hcZvMn+ot9Eg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224703>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> THERE IS NO STYLE BREAKAGE.

Repeating something, and even making it all caps does not make it true.

You are wasting your time and everybody else's in this thread and many
others. You seem to reject the very concept of code review. The Git
community likes very much code review. I do not forsee a change in the
taste for code review and iterations to make the code as clean as it can
be in the Git community. And I'd hate to see it change because some
contributors are too stubborn to send a reroll when someone else points
out something in the patch.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
