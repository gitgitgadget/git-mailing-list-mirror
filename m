From: =?UTF-8?B?WmJpZ25pZXcgSsSZZHJ6ZWpld3NraS1Tem1law==?= 
	<zbyszek@in.waw.pl>
Subject: Re: [PATCH 1/2] Save terminal width before setting up pager and export
 term_columns()
Date: Tue, 14 Feb 2012 12:53:58 +0100
Message-ID: <4F3A4B56.50909@in.waw.pl>
References: <7vsjigl79j.fsf@alter.siamese.dyndns.org> <1329055953-29632-1-git-send-email-zbyszek@in.waw.pl> <CACsJy8Da=JMF7B9hW+WXzRXQFiGJxh0S7HYFg9+uweZ=pMOmTQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 14 12:54:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RxGxb-0007gz-6t
	for gcvg-git-2@plane.gmane.org; Tue, 14 Feb 2012 12:54:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760088Ab2BNLyI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Feb 2012 06:54:08 -0500
Received: from kawka.in.waw.pl ([178.63.212.103]:52581 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751619Ab2BNLyH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Feb 2012 06:54:07 -0500
Received: from [193.0.104.42]
	by kawka.in.waw.pl with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <zbyszek@in.waw.pl>)
	id 1RxGxR-0008Jl-HJ; Tue, 14 Feb 2012 12:54:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:8.0) Gecko/20120104 Icedove/8.0
In-Reply-To: <CACsJy8Da=JMF7B9hW+WXzRXQFiGJxh0S7HYFg9+uweZ=pMOmTQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190716>

On 02/14/2012 12:44 PM, Nguyen Thai Ngoc Duy wrote:
> 2012/2/12 Zbigniew J=C4=99drzejewski-Szmek<zbyszek@in.waw.pl>:
>> This replaces cb0850f (Save terminal width before setting up pager -
>> 2012-02-04) from Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy and my pr=
evious patch to export
>> term_columns().
>>
>> This is directly on top of v1.7.9 as requested.
>>
>> I removed Signed-off-by from Nguy=E1=BB=85n and Junio because the pa=
tch is
>> substantially changed.
>
> No problems. I will rebase my series on top of this patch (its final
> version, that is).
Hi, I think that Junio's will be the final version. I have no objection=
s=20
to it.

Zbyszek
