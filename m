From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 3/4] {fast-export,transport-helper}: style cleanups
Date: Fri, 17 May 2013 19:14:56 +0200
Message-ID: <vpqwqqxbka7.fsf@grenoble-inp.fr>
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
	<vpqvc6hczq2.fsf@grenoble-inp.fr>
	<CAMP44s2AGWk76Nwk+va-6SBZqj46AHf6d_tm-AeN8jWKR-mEvw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	John Szakmeister <john@szakmeister.net>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 17 19:15:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UdOG1-0000ON-2A
	for gcvg-git-2@plane.gmane.org; Fri, 17 May 2013 19:15:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756232Ab3EQRPs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 May 2013 13:15:48 -0400
Received: from mx1.imag.fr ([129.88.30.5]:51263 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755922Ab3EQRPs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 May 2013 13:15:48 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r4HHEsb0015424
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 17 May 2013 19:14:54 +0200
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1UdOF6-0006mT-LQ; Fri, 17 May 2013 19:14:56 +0200
In-Reply-To: <CAMP44s2AGWk76Nwk+va-6SBZqj46AHf6d_tm-AeN8jWKR-mEvw@mail.gmail.com>
	(Felipe Contreras's message of "Fri, 17 May 2013 12:02:58 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 17 May 2013 19:14:55 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r4HHEsb0015424
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1369415697.83912@PahsMkrcSCCNWCalSaRVOw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224711>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> On Fri, May 17, 2013 at 11:56 AM, Matthieu Moy
> <Matthieu.Moy@grenoble-inp.fr> wrote:
>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>
>>> THERE IS NO STYLE BREAKAGE.
>>
>> Repeating something, and even making it all caps does not make it true.
>
> Tell that to Junio. He is also repeating the same.

Junio explained you carefully how the former code was purposely aligning
stuff and you broke it.

> I actually provided *evidence*. Did you miss it?

Star-emphasis does not make things true either. Again, you're losing
your time, and won't lose mine any further.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
