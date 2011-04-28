From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: 'gittutorial(7)' translation
Date: Thu, 28 Apr 2011 13:47:56 +0200
Message-ID: <BANLkTimDqYVM6qcJfedvj3LeQsJ58piM=g@mail.gmail.com>
References: <4DAD97A0.2050207@gmail.com>
	<BANLkTin+5v2_ZkumNr0XtRoP1p4yAMTgQg@mail.gmail.com>
	<4DB92F61.3090202@gmail.com>
	<BANLkTi=2je_B-G4exQQCcRyfukpJEDPL1Q@mail.gmail.com>
	<20110428104737.GB9063@jakstys.lt>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: =?UTF-8?Q?Motiejus_Jak=C5=A1tys?= <desired.mta@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 28 13:48:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFPhU-0006R5-Ct
	for gcvg-git-2@lo.gmane.org; Thu, 28 Apr 2011 13:48:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751541Ab1D1Lr6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 Apr 2011 07:47:58 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:40890 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751270Ab1D1Lr5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Apr 2011 07:47:57 -0400
Received: by mail-bw0-f46.google.com with SMTP id 15so2211944bwz.19
        for <git@vger.kernel.org>; Thu, 28 Apr 2011 04:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:content-type:content-transfer-encoding;
        bh=XErro1nL9aSU+D8rRZ/68Yjegz/pziFDv5h5NmGsmxI=;
        b=ZQHL8+KHA2sk6+tVpgsGRk2Cn6eOGh/VMIljIc+otgSV6tUQUJsVvsivYVGnXcMq/P
         wUMZ6j6MJDWW1TJLT2+l3NAzoZC8jG/1GIFcLBRWD3p6POU7uS+qFHBilYF530xbnSLF
         JUnhvhjqoZ4hdvDVlEv9zzcFB2XzF5rw96K3E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=l3h7aFY5hELH54lIxkTBW8AHGgSr3AKEUvQl2E/4NGx0KSLCNthYMoNd619USd31UI
         oL/5hglgo6b/qVrbi8iLq4XluDJRFm6lSr4yhQIy5bw8Xa2s3YT7aF1Mt4kdLbEpvCx/
         A57qatAR8yKuYcHJFbOlj9eSNCr4ewr8R4NK0=
Received: by 10.204.75.23 with SMTP id w23mr3342653bkj.200.1303991276361; Thu,
 28 Apr 2011 04:47:56 -0700 (PDT)
Received: by 10.204.101.132 with HTTP; Thu, 28 Apr 2011 04:47:56 -0700 (PDT)
In-Reply-To: <20110428104737.GB9063@jakstys.lt>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172353>

On Thu, Apr 28, 2011 at 12:47, Motiejus Jak=C5=A1tys <desired.mta@gmail=
=2Ecom> wrote:
> On Thu, Apr 28, 2011 at 11:59:15AM +0200, =C3=86var Arnfj=C3=B6r=C3=B0=
 Bjarmason wrote:
>> On Thu, Apr 28, 2011 at 11:12, Bohdan Zograf <bozograf@gmail.com> wr=
ote:
>> > 19.04.2011 21:19, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason =D0=BF=D0=
=B8=D1=88=D0=B5=D1=82:
>> >>
>> >> On Tue, Apr 19, 2011 at 16:09, MR<by.marcis@gmail.com> =C2=A0wrot=
e:
>> > Posted my Belorussian translation on
>> > http://webhostingrating.com/libs/gittutorial. If you don't mind ca=
n you
>> > publish a tiny link with a text
>> >
>> > <a href=3D"http://webhostingrating.com/libs/gittutorial">Belorussi=
an
>> > translation</a> or whatever you feel is right.
>>
>> That we way could translate any of our documentation and ship it as
>> part of Git itself, so you could have a Russian gittutorial manpage
>> installed along with Git.
>
> Dear =C3=86var,
>
> Russian !=3D Belorussian, and it might insult some Belorussians (from=
 my
> personal experience) by calling their language "Russian". Belorussian=
 is
> quite rare and people are trying to save it as hard as they can from
> Russian influence. It is a tough problem..
>
> They even have statue in Minsk for the only letter that exists in
> Belorussian, but does not exist in Russian: =D1=9E.
>
> I just wanted you to know that. Simple "apologies" might be a very ni=
ce
> thing.

Sorry about that. I just glanced at the E-Mail and the translation
itself looked similar to Russian to my untrained eyes.

I stand corrected.
