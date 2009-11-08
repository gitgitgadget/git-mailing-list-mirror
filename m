From: Maximilien Noal <noal.maximilien@gmail.com>
Subject: Re: gitk : french translation
Date: Mon, 09 Nov 2009 00:15:45 +0100
Message-ID: <4AF75121.70301@gmail.com>
References: <9f50533b0911060605p6ad28ad9neac3620a1809c3db@mail.gmail.com> <b0c32d010911061016t2208af0er8d7fe88508c30f10@mail.gmail.com> <9f50533b0911061259w54b57fcdo2c0b21e95dbbdc54@mail.gmail.com> <20091107025439.GC13724@vidovic> <9f50533b0911080955l606ea87aw4edd7b0bc926a25f@mail.gmail.com> <20091108214130.GA12931@vidovic> <4AF7502A.9020903@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Emmanuel Trillaud <etrillaud@gmail.com>,
	Thomas Moulard <thomas.moulard@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
X-From: git-owner@vger.kernel.org Mon Nov 09 00:16:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7GzL-0002It-BG
	for gcvg-git-2@lo.gmane.org; Mon, 09 Nov 2009 00:16:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751457AbZKHXPx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Nov 2009 18:15:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751125AbZKHXPw
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Nov 2009 18:15:52 -0500
Received: from mail-ew0-f207.google.com ([209.85.219.207]:59111 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751116AbZKHXPw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Nov 2009 18:15:52 -0500
Received: by ewy3 with SMTP id 3so2652894ewy.37
        for <git@vger.kernel.org>; Sun, 08 Nov 2009 15:15:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=BteVN5OE1H8nZRsxgmwU5n+Cc8LKZ59BN4Itf16QuLg=;
        b=Azw3I75Y8upFb5OH7Jd1MKpfpmocI7Xy8tn3T7+vlwMU6l8STs3lmOn7yUhwKbX0JI
         cALk2bV/mStjfRxTMiPFIOqzzKFbojm2YSjLq2ys8kkLMFA4cCwoO/u1oMAqt6hW2SZB
         TuCwJiH6qnq//DVjd/AsGcfBfpabOlNcYpq38=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=PiOgkR7cgSS9JTR1glU4x/xe5oADpv8UrCsXaBzdJGXpZHZRQtCuT62RXZVkRbnmPM
         q09IGYB5CNx7u4elD3tVnr/6J3aEwPStfrQ7ssSEQKu7slIIkg9yl2Z3gvEjkuaLBXBr
         Q6zfMG87gk4v5DR/MLrTltiBjlCg+uqLts+vA=
Received: by 10.213.23.199 with SMTP id s7mr8094890ebb.80.1257722156436;
        Sun, 08 Nov 2009 15:15:56 -0800 (PST)
Received: from ?192.168.1.20? (ABordeaux-257-1-59-234.w90-45.abo.wanadoo.fr [90.45.202.234])
        by mx.google.com with ESMTPS id 5sm4608216eyf.39.2009.11.08.15.15.46
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 08 Nov 2009 15:15:54 -0800 (PST)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <4AF7502A.9020903@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132430>

Maximilien Noal a =E9crit :
> Nicolas Sebrecht wrote :
>>>> I disagree here. Words like "diff", "commit", "patch", etc should =
be
>>>> kept as is. Translation of those terms make things harder for the=20
>>>> users.
>>> I agree with you when those terms refers to _commands_ names, but t=
he
>>> main goal of a
>>> translation is to _translate_ and we have to make the best effort t=
o
>>> use french word if they _exist_
>>
>> I don't think so. Here is _why_: the user-frienliness of a translate=
d
>> software comes from "how hard is it to connect a word with the
>> underlying concept".
>>
>> IOW, we want to have good words to refer to the _concepts_. In the
>> computer science world (and more _specially_ for a SCM), those conce=
pts
>> are much more well-known with the english terms. Keeping english wor=
ds
>> help users to directly understand what it is about, without making t=
he
>> users have to search for "what the fucking translators are refering =
to
>> here?".
> Why not put the translation first, then the english word between () ?
> At least for English words above that are not used by French devs "as=
=20
> is" (not like "diff") ?
>=20
> That way, newbies to SCMs' concepts get the idea, and old SCM users=20
> don't have to translate back.
>=20
> But if it isn't done _everywhere_ (and not used anywhere for words we=
=20
> don't want to translate because there's no need or no good translatio=
n,=20
> like "diff" for the first case, and "patch" for the second one), it w=
ill=20
> make the situation worse.
>=20
> Just my two cents.
I had in mind a man page when I wrote this, not gitk! Oh well.. Instead=
=20
of "French Translated Word (<English Word>)" idea, may be the tooltip=20
text (the text that pops up on a mouse over a control) can be used when=
=20
there is no pixel space left in the UI for the extra (<English Word>) t=
ext.
