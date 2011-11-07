From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH v2] pull: introduce a pull.rebase option to enable --rebase
Date: Mon, 7 Nov 2011 19:48:51 +0100
Message-ID: <CACBZZX7igeXcuss2k3bPHrMP0U2JmbLAT-uQ0TvzZokofLqrJA@mail.gmail.com>
References: <7v8vnt7kvd.fsf@alter.siamese.dyndns.org> <1320573010-12296-1-git-send-email-avarab@gmail.com>
 <4EB6E5AD.7060605@kdbg.org> <CACBZZX5Lq7vunx-QnsrufQVWJ6xYPoMXnv+tMwhOC3XbrZO11A@mail.gmail.com>
 <7v39dz3ms7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
	Eric Herman <eric@freesa.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Fernando Vezzosi <buccia@repnz.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 07 19:49:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNUFy-0002HG-U3
	for gcvg-git-2@lo.gmane.org; Mon, 07 Nov 2011 19:49:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751602Ab1KGStO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 Nov 2011 13:49:14 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:53351 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750957Ab1KGStN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Nov 2011 13:49:13 -0500
Received: by bke11 with SMTP id 11so3891236bke.19
        for <git@vger.kernel.org>; Mon, 07 Nov 2011 10:49:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=usYWLWUglVZFk71mljzC8pkEs8cG/proa4nU5HAPmTs=;
        b=pHEgJXxKnoVEGXGzS5WYkowJmY2wkLWkbEXX6+BesEILPk6Aqv214x7AnuEjOBpd1l
         EdbCo94JqYYC0cPFqsLrk8j04rO+gDyg8OkNxNozxYFf97sTjKCNRHC3tfaxYFC0fg+F
         ShxyXJRRu0Cn4NlsVyWhjnWhTffFcKExIcnwE=
Received: by 10.205.117.20 with SMTP id fk20mr494764bkc.58.1320691752121; Mon,
 07 Nov 2011 10:49:12 -0800 (PST)
Received: by 10.204.118.67 with HTTP; Mon, 7 Nov 2011 10:48:51 -0800 (PST)
In-Reply-To: <7v39dz3ms7.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185012>

On Mon, Nov 7, 2011 at 17:44, Junio C Hamano <gitster@pobox.com> wrote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> On Sun, Nov 6, 2011 at 20:53, Johannes Sixt <j6t@kdbg.org> wrote:
>>> When you continue an indented item in a separate paragraph, then yo=
u
>>> must not use an empty line, but have line with '+' and un-indented
>>> continuation paragraphs. See examples in this file.
>>
>> Thanks for spotting that.
>>
>> Junio: Should I spam you with another patch or is something you'd
>> prefer to just fix up?
>
> It is about the same amount of work for me; I've just dedented the tw=
o
> paragraphs that start with "*NOTE*:" and replaced the blank lines bef=
ore
> them with a single "+". Is that what you wanted to resend, or is ther=
e
> anything else?

That should cover it, thanks!
