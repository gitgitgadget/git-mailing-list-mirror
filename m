From: Dmitrijs Ledkovs <dmitrij.ledkov@ubuntu.com>
Subject: Re: How to fork on repo.or.cz?
Date: Thu, 6 May 2010 10:51:07 +0100
Message-ID: <r2t86ecb3c71005060251xf1d185d6xa9e19a532d76d48c@mail.gmail.com>
References: <x2r86ecb3c71004241233h97e3cf08l89aa4e6ef2fc4425@mail.gmail.com> 
	<4BE247B3.8060704@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 06 11:51:34 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O9xjx-0006Ld-SE
	for gcvg-git-2@lo.gmane.org; Thu, 06 May 2010 11:51:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756765Ab0EFJv2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 May 2010 05:51:28 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:64316 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753302Ab0EFJv1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 May 2010 05:51:27 -0400
Received: by pxi5 with SMTP id 5so2010940pxi.19
        for <git@vger.kernel.org>; Thu, 06 May 2010 02:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:sender:received
         :in-reply-to:references:from:date:x-google-sender-auth:message-id
         :subject:to:content-type:content-transfer-encoding;
        bh=Dci8qtbG7QV//M2mVYdsMH5Fa932g6nRMvna+0lOZq8=;
        b=T/28tBStg23TnJWWmyDOwTC2aoaf7i4TrkKKvEw8ijhPbnEy0Bh9VPMK2YD0DNEQKz
         xp18jUhFmcbTJIXY9FFQHHpzhyirv3pHUlRL66B1PSoq3MpI83ts8DdTTX+pfYS+gipB
         jXY/NLep1WoL4o2wYNI5FB4XbtF/bN2j4lctQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:content-type
         :content-transfer-encoding;
        b=DmTgEW6pWodv/FBJiBBMhlTKk5PZ/uJaVp+P8i9UMq9vu4fLdARZ4eVO5LCv75MeGK
         vG1P94Gukl1Nw4lHtBUJ3/yWi61j3ckZReNM1f7l7/7T1UXxhwD7ems93w1u1CYeIIQk
         nj8zpovi7I0JmyYxSR/XLHoQFTcJEkUYLH4M0=
Received: by 10.142.207.17 with SMTP id e17mr2153789wfg.81.1273139487221; Thu, 
	06 May 2010 02:51:27 -0700 (PDT)
Received: by 10.142.191.1 with HTTP; Thu, 6 May 2010 02:51:07 -0700 (PDT)
In-Reply-To: <4BE247B3.8060704@redhat.com>
X-Google-Sender-Auth: e211d0e0ca2aab8d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146471>

Everyone!
Do you fork on repo.or.cz? Are you an export in git things? Please
help out to fix a problem on repo.or.cz were after you fork a project
you have to repush the whole history to the fork wasting bandwidth.
Somehow alternatives are not used.


On 6 May 2010 05:38, Jason Merrill <jason@redhat.com> wrote:
> On 04/24/2010 03:33 PM, Dmitrijs Ledkovs wrote:
>>
>> Looking at this output it doesn't seem like my fork
>> is reusing objects from the "fork parent" repo.
>>
>> What wrong? How am I suppose to use forks on repo.or.cz such that I
>> upload just *my* commits and don't re-upload whole history again.
>
> I have been having the same problem. =C2=A0I sent mail to admin@repo.=
or.cz about
> it and got this reply:
>
>> =C2=A0Thank you for the info. Unfortunately the server admin team is
>> currently severely undermanned and there is noone to fix this (anyon=
e
>> interested in helping out would be gladly welcome), so all I could d=
o
>> for now is to add this to our TODO list.
>
> Jason
>
