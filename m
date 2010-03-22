From: Deskin Miller <deskinm@umich.edu>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH=5D_=2Emailmap=3A_Entries_for_Alex_Benn=C3=A9e=2C_Desk?=
	=?UTF-8?Q?in_Miller=2C_Vitaly_=22=5FVi=22_Shukela?=
Date: Mon, 22 Mar 2010 17:15:36 +0000
Message-ID: <86d4c5e01003221015m62f5eff4s9cfd8ec55d5c181c@mail.gmail.com>
References: <cd13e44f33c1f6bc9ec11903c3041199c9c464ee.1268996321.git.git@drmicha.warpmail.net>
	 <fabb9a1e1003201047g5b73350ch9e7f1a2533125808@mail.gmail.com>
Reply-To: deskinm@umich.edu
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	=?UTF-8?B?QWxleCBCZW5uw6ll?= <kernel-hacker@bennee.com>,
	"Vitaly \"_Vi\" Shukela" <public_vi@tut.by>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 22 18:23:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NtlLx-0002K2-Hb
	for gcvg-git-2@lo.gmane.org; Mon, 22 Mar 2010 18:23:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755206Ab0CVRXo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 22 Mar 2010 13:23:44 -0400
Received: from mail-qy0-f182.google.com ([209.85.221.182]:48017 "EHLO
	mail-qy0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754827Ab0CVRXn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Mar 2010 13:23:43 -0400
Received: by qyk12 with SMTP id 12so2740334qyk.5
        for <git@vger.kernel.org>; Mon, 22 Mar 2010 10:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:reply-to:received
         :in-reply-to:references:date:x-google-sender-auth:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=C0tKVmUWH+xYBfhPS7WCeLCCa4jsl52tW4By0nmEjSY=;
        b=S5vPBlvCElgP9G2FCD0ogPb/Va2TsG4zm1rJCy85JBGWgoWuSBjZAe6L0Gz53TrAKJ
         98JNu/4Swrqj+dU7MMKD9fv/XhjH6udRbfQb3ZkM18wpdcIiguSaozXX7NQJ7voZV0wL
         dvemcjvlA1u6DgCpLqXBGbKLIXYDY/lVy6aG0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:reply-to:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=WvkWSazdgs7U2Gvw9DjuaBzfg9BIIef0Xv0H+5gsreHLD9iOqH9+HVD6XAQNW94bjU
         xh8LFfiYsUIhFDbys9pWBJJsGBeq7+eNgjHUf1MG7Odo2/y+YYpL+2Dsr/JGe9ADVZXu
         SFRSIn+qugzQdYBP7TzeTV+qRExbqsgqoklzA=
Received: by 10.229.232.149 with SMTP id ju21mr1819845qcb.87.1269278136148; 
	Mon, 22 Mar 2010 10:15:36 -0700 (PDT)
In-Reply-To: <fabb9a1e1003201047g5b73350ch9e7f1a2533125808@mail.gmail.com>
X-Google-Sender-Auth: d6412f400d23e764
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142952>

On Sat, Mar 20, 2010 at 17:47, Sverre Rabbelier <srabbelier@gmail.com> =
wrote:
> Heya,
>
> [+those who are affected by this]
>
> On Fri, Mar 19, 2010 at 12:02, Michael J Gruber
> <git@drmicha.warpmail.net> wrote:
>> With the current .mailmap, git shortlog shows the following for thes=
e:
>>
>> =C2=A0 =C2=A011 =C2=A0Deskin Miller
>> =C2=A0 =C2=A0 3 =C2=A0Vitaly \"_Vi\" Shukela
>> =C2=A0 =C2=A0 1 =C2=A0Alex Bennee
>> =C2=A0 =C2=A0 1 =C2=A0Alex Benn=C3=A9e
>> =C2=A0 =C2=A0 1 =C2=A0Deskin Miler
>> =C2=A0 =C2=A0 1 =C2=A0Vitaly _Vi Shukela
>>
>> Add (e-mail based qualified) entries to .mailmap to get:
>>
>> =C2=A0 =C2=A012 =C2=A0Deskin Miller
>> =C2=A0 =C2=A0 4 =C2=A0Vitaly "_Vi" Shukela
>> =C2=A0 =C2=A0 2 =C2=A0Alex Benn=C3=A9e
>>
>> The Shukela spelling is based on the version used consistently in th=
e s-o-b
>> lines of all his patches.
>>
>> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
>> ---
>> Sparked by the recent discussion on uuid etc. I did a few (manual) c=
hecks.
>> There seem to be 4 remaining "problematic" cases (Elrond, jidanni,
>> Kirill, Twiinz) but 3 are unique, and I don't think we strictly requ=
ire
>> full names. Kirill may be one of several other Kirills.
>>
>> http://repo.or.cz/w/git/mjg.git/commit/cd13e44f33c1f6bc9ec11903c3041=
199c9c464ee
>>
>> (branch typo-fixes) in case of encoding problems
>>
>> =C2=A0.mailmap | =C2=A0 =C2=A03 +++
>> =C2=A01 files changed, 3 insertions(+), 0 deletions(-)
>>
>> diff --git a/.mailmap b/.mailmap
>> index 975e675..c507309 100644
>> --- a/.mailmap
>> +++ b/.mailmap
>> @@ -5,6 +5,7 @@
>> =C2=A0# same person appearing not to be so.
>> =C2=A0#
>>
>> +Alex Benn=C3=A9e <kernel-hacker@bennee.com>
>> =C2=A0Alexander Gavrilov <angavrilov@gmail.com>
>> =C2=A0Aneesh Kumar K.V <aneesh.kumar@gmail.com>
>> =C2=A0Brian M. Carlson <sandals@crustytoothpaste.ath.cx>
>> @@ -15,6 +16,7 @@ Daniel Barkalow <barkalow@iabervon.org>
>> =C2=A0David D. Kilzer <ddkilzer@kilzer.net>
>> =C2=A0David K=C3=A5gedal <davidk@lysator.liu.se>
>> =C2=A0David S. Miller <davem@davemloft.net>
>> +Deskin Miller <deskinm@umich.edu>
>> =C2=A0Dirk S=C3=BCsserott <newsletter@dirk.my1.cc>
>> =C2=A0Fredrik Kuivinen <freku045@student.liu.se>
>> =C2=A0H. Peter Anvin <hpa@bonde.sc.orionmulti.com>
>> @@ -59,6 +61,7 @@ Uwe Kleine-K=C3=B6nig <ukleinek@informatik.uni-fre=
iburg.de>
>> =C2=A0Uwe Kleine-K=C3=B6nig <uzeisberger@io.fsforth.de>
>> =C2=A0Uwe Kleine-K=C3=B6nig <zeisberg@informatik.uni-freiburg.de>
>> =C2=A0Ville Skytt=C3=A4 <scop@xemacs.org>
>> +Vitaly "_Vi" Shukela <public_vi@tut.by>
>> =C2=A0William Pursell <bill.pursell@gmail.com>
>> =C2=A0YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>
>> =C2=A0anonymous <linux@horizon.com>
>> --
>> 1.7.0.2.358.g30511
>

Looks good to me; FWIW I had been screwing around with filter-branch
on some commits I later submitted, and forgot to correct the
misspelling of my name.

Thanks,
Deskin Miller
