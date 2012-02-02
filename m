From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] i18n: po for zh_cn
Date: Thu, 02 Feb 2012 10:49:54 -0800
Message-ID: <7vvcnpvzn1.fsf@alter.siamese.dyndns.org>
References: <1328111436-58925-1-git-send-email-worldhello.net@gmail.com>
 <7vr4ye15kr.fsf@alter.siamese.dyndns.org>
 <CACsJy8BPTuS+u8Grx0ojhdX-5+Vn6=DuojSWO0or7fJE1dbAEQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jiang Xin <worldhello.net@gmail.com>,
	Git List <git@vger.kernel.org>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 02 19:50:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rt1jW-0001Rg-Lj
	for gcvg-git-2@plane.gmane.org; Thu, 02 Feb 2012 19:50:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754338Ab2BBSt6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Feb 2012 13:49:58 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50481 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753218Ab2BBSt5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Feb 2012 13:49:57 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8159B6109;
	Thu,  2 Feb 2012 13:49:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=/NbRSh0Fc1jQ
	AppjXCSj5myttMw=; b=MJOeU8XGSvnl8TeUqySRnv0xbwPj4FRnxcf15TDfB39I
	B756pNoaeKVY4BhEMa7pb7lbYjjtG566wh3W49SF7Uce7sLu3bjHdOxRNohNhwlR
	TpEHUzg31SeisEEoU9dm0NiCAkbxs9onTOEdYWvSpU7RaPKbdt6V5f/XFbRfhuI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=c3yXlB
	4RboI1lZ8uk0zCpH951vqVeYRI/6jb8LBGyh1LFfBGhts2bDr+nc9MOfy0NaBK3F
	yrWD5zuGecny8C5DZLswkGCvLdvJG2KDfwnK9HctxRFovLIfCBU5KTwcvLoX3nc7
	jl/ukGjP5PUtZFL5l3pyJhS8a3oAOawK6afDg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 795796108;
	Thu,  2 Feb 2012 13:49:56 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0F7956107; Thu,  2 Feb 2012
 13:49:55 -0500 (EST)
In-Reply-To: <CACsJy8BPTuS+u8Grx0ojhdX-5+Vn6=DuojSWO0or7fJE1dbAEQ@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Thu, 2 Feb 2012 20:29:09 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B31248C0-4DCE-11E1-A055-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189669>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> On Thu, Feb 2, 2012 at 6:45 AM, Junio C Hamano <gitster@pobox.com> wr=
ote:
>> Jiang Xin <worldhello.net@gmail.com> writes:
>>
>>> Git can speak Chinese now.
>>>
>>> Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
>>> ---
>>> =C2=A0po/zh_cn.po | 3568 ++++++++++++++++++++++++++++++++++++++++++=
+++++++++++++++++
>>> =C2=A01 =E4=B8=AA=E6=96=87=E4=BB=B6=E8=A2=AB=E4=BF=AE=E6=94=B9, 356=
8 =E5=A4=84=E6=B7=BB=E5=8A=A0(+), 0 =E5=A4=84=E5=88=A0=E9=99=A4(-)
>>> =C2=A0create mode 100644 po/zh_cn.po
>>
>> I do not mind Chinese in the patch text (i.e. below), but I would ha=
ve
>> preferred the above not to be in Chinese, which I do not read---I ca=
n
>> guess what =E6=96=87=E4=BB=B6, =E6=B7=BB=E5=8A=A0 and =E5=88=A0=E9=99=
=A4 are, and I can also guess that =E4=B8=AA and =E5=A4=84
>> are units of counting, but nevertheless...
>
> Such a stat line would be wonderful in an all-Chinese environment
> though.

Yes, but the git mailing list is not all-Chinese environment. I was mer=
ely
asking that the future submissions will be prepared with something like=
 a
one-shot "LC_ALL=3DC git format-patch ..."; it wasn't a suggestion not =
to i18n
the summary bit.
