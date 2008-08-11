From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: [PATCH] Update french translation
Date: Tue, 12 Aug 2008 00:04:13 +0200
Message-ID: <vpqwsinjjj6.fsf@bauges.imag.fr>
References: <1218465592-2446-1-git-send-email-alexandre.bourget@savoirfairelinux.com>
	<1218465592-2446-2-git-send-email-alexandre.bourget@savoirfairelinux.com>
	<vpqr68vuzoo.fsf@bauges.imag.fr>
	<1218489461.11353.135.camel@alexandre-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: alexandre.bourget@savoirfairelinux.com
X-From: git-owner@vger.kernel.org Tue Aug 12 00:07:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSfYR-00055i-5k
	for gcvg-git-2@gmane.org; Tue, 12 Aug 2008 00:07:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756371AbYHKWGu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 11 Aug 2008 18:06:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756104AbYHKWGt
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Aug 2008 18:06:49 -0400
Received: from imag.imag.fr ([129.88.30.1]:43280 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755470AbYHKWGs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Aug 2008 18:06:48 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id m7BM4Jrg013175
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 12 Aug 2008 00:04:19 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1KSfUr-0008TI-Gm; Tue, 12 Aug 2008 00:04:13 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1KSfUr-0005ch-EQ; Tue, 12 Aug 2008 00:04:13 +0200
In-Reply-To: <1218489461.11353.135.camel@alexandre-desktop> (Alexandre Bourget's message of "Mon\, 11 Aug 2008 17\:17\:41 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Tue, 12 Aug 2008 00:04:19 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92008>

Alexandre Bourget <alexandre.bourget@savoirfairelinux.com> writes:

> Le lundi 11 ao=FBt 2008 =E0 21:19 +0200, Matthieu Moy a =E9crit :
>> General remark: you should split your patch into
>>=20
>> * Some word substitution on the one side (s/r=E9f=E9rentiel/d=E9pos/=
g,
>>   s/fonte/police/g, ...)
>>=20
>> * Some manual rephrasing.
>
> This is funny requirement, especially when I see what you've let in a=
s a
> "french" translation :) I doubt=20

??

Your patch is deadly long, and 90% of it is just about changing the
translation of 3 words (police, d=E9pos and index). Really, my review
would have been _much_ more efficient with a clean patch serie.

BTW, the requirement of splitting a patch to small and related changes
is indeed not at all uncommon here.

> http://www.granddictionnaire.com reveals us that "supporter" is a
> computer-related term that means just what we need here, and it's bee=
n
> reviewed by the "Office de la langue fran=E7aise" in 2002.

Interesting. Still, this is all about Canadian-french, not
=46rance-french. According to
http://atilf.atilf.fr/dendien/scripts/tlfiv5/visusel.exe?13;s=3D3509465=
295;r=3D1;nat=3D;sol=3D2
this is indeed both anglicism and "canadianism" ;-).

Well, anyway, that's just nitpick, your translation is at least good
in the sense that everybody understands it.

>> >  #: lib/choose_rev.tcl:531
>> >  msgid "Updated"
>> > -msgstr "Misa =E0 jour"
>> > +msgstr "=C0 jour (updated)"
>>=20
>> If you go for "index=E9" elsewhere, you should s/updated/index=E9/ h=
ere
>> also.
>
> Have you looked at the context ?

No, and you're rigth. Sorry for the noise.

--=20
Matthieu
