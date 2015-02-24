From: Anthony Ramine <n.oxyde@gmail.com>
Subject: Re: Copyright on wildmatch.c
Date: Tue, 24 Feb 2015 14:35:00 +0100
Message-ID: <1E0E3F90-07A7-4CDE-AA13-66448DC0404B@gmail.com>
References: <CAMDzUtyitrK__iE9ykfTuP+Ooq0FwMPp_NVgBfBGbSV52+OPoQ@mail.gmail.com> <CAMDzUtymj21ckMrA87q1TATeWuH6kS_TBrsJ_jVjfeH50CaniA@mail.gmail.com> <CACsJy8Do77QSKSERPE26bKJ0gANB0XmPVBLwb1QKAW4qe0ouAQ@mail.gmail.com> <CAMDzUtz_BhW_tuQLy+AiNY7hz_HXCmHOtUNDgMBc=Taeon_Dwg@mail.gmail.com> <CACsJy8APLtweaf-q8+nCzJC-8J_vNZp-Y=AtNkX4NPuYr1jb=Q@mail.gmail.com> <CAMDzUtxf0gF=JDgEk9EU3W2VWuP-Qy8-Kz-fTx_Y16UeFRGiYA@mail.gmail.com> <CAMDzUtw8ySWwHvx4G+0R=L5JpxKqeFFNQ8Rb6bo5FRGwArzJcA@mail.gmail.com> <CAMDzUtzPxrtwdJN7cRmaMC_Sezmr9zSge=K_pc1OztEA8FVc=g@mail.gmail.com> <CAMDzUtyWF6oRV7-h45P8x=tWOK2kwdg2ELhR+ugjZLWTbF_feQ@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Guilherme <guibufolo@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 24 14:35:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YQFdm-00036p-Vt
	for gcvg-git-2@plane.gmane.org; Tue, 24 Feb 2015 14:35:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752308AbbBXNfF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Feb 2015 08:35:05 -0500
Received: from mail-we0-f182.google.com ([74.125.82.182]:33537 "EHLO
	mail-we0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752028AbbBXNfD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Feb 2015 08:35:03 -0500
Received: by wevk48 with SMTP id k48so25233019wev.0
        for <git@vger.kernel.org>; Tue, 24 Feb 2015 05:35:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=1DxgrWarsucXVg2ONRmlVtpBBNqIvHXdmMs4SpE7FFQ=;
        b=osMSEitOl58ychHOy8wNGektImpBddn9r8KitxqQIXOyJa8ANCpzkNzIgbEe3kniFn
         MxmjM8hTsbVw6B76EhFaayBUt6PmSaiGFyCsEOUUHQoNrTrUBkTDxSgvpVRaGruKy6rT
         DzzsoouWabPuqlLzOONuRvXzgwYrl9LeuDRxjpQdsbjDs9DVpmF0SoYnCPzfqlisxvr3
         Htbbv0/gbA0xwIAcW8koox1Vxx5tH8mDfMSP8ZwM99U+OHfScZxoaHHPnSIYev1IWo+h
         WD8Ugtw0XtUSP95d4Wzf7x1Rf+O3OeLdGO/UyTBhrsRBRGhEJWXH1VHnN7sKp+oJaXAP
         3hmA==
X-Received: by 10.194.157.68 with SMTP id wk4mr32887272wjb.123.1424784902080;
        Tue, 24 Feb 2015 05:35:02 -0800 (PST)
Received: from [192.168.118.153] ([178.20.48.86])
        by mx.google.com with ESMTPSA id d10sm60278176wjn.45.2015.02.24.05.35.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 24 Feb 2015 05:35:01 -0800 (PST)
In-Reply-To: <CAMDzUtyWF6oRV7-h45P8x=tWOK2kwdg2ELhR+ugjZLWTbF_feQ@mail.gmail.com>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264328>

I agree to relicense my contributions on wildmatch.c under the Apache l=
icense.

Le 24 f=E9vr. 2015 =E0 13:54, Guilherme <guibufolo@gmail.com> a =E9crit=
 :

> This is CC to Anthony Ramine.
>=20
> On Tue, Feb 24, 2015 at 1:34 PM, Guilherme <guibufolo@gmail.com> wrot=
e:
>> This is just an email to all the people i have written in private
>> about relicensing the files in need in TSS so they can reply to this
>> email and it be recorded in the mailing list.
>>=20
>> The files are part of ctypes.c hex.c git-compat-util.h.
>>=20
>> On Tue, Feb 24, 2015 at 1:22 PM, Guilherme <guibufolo@gmail.com> wro=
te:
>>> Hello,
>>>=20
>>> I'm writing to you in regards to the files ctypes.c
>>> which you have modified part of in the git project.
>>>=20
>>> I'm currently working on integrating gitignore pattern matching int=
o
>>> the_sivler_searcher(http://github.com/ggreer/the_silver_searcher). =
PR
>>> https://github.com/ggreer/the_silver_searcher/pull/614
>>>=20
>>> For that i needed wildmatch.c and it's dependencies. That is parts =
of
>>> ctypes.c lines 8 to 31.
>>>=20
>>> Unfortunately TSS is Apache licensed wheras git is GPL, those licen=
ses
>>> are incompatible and thus i ask if you agree that your portion if t=
he
>>> code is also licensed under Apache2 for the use in TSS.
>>>=20
>>> You can follow the discussion under
>>> http://article.gmane.org/gmane.comp.version-control.git/264312
>>>=20
>>> Thank you very much,
>>> Bufolo
