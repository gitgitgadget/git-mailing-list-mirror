From: Tim Visher <tim.visher@gmail.com>
Subject: Re: Displaying Current Git Aliases
Date: Thu, 25 Jun 2009 14:45:13 -0400
Message-ID: <c115fd3c0906251145l7641627od35b251fca899ba8@mail.gmail.com>
References: <c115fd3c0906250859q661d2319i463d6eea7e9dbe54@mail.gmail.com>
	 <m33a9oxogk.fsf@localhost.localdomain>
	 <86ljngxngu.fsf@blue.stonehenge.com>
	 <alpine.DEB.1.00.0906251857010.8908@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Randal L. Schwartz" <merlyn@stonehenge.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jun 25 20:45:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MJtww-0002cs-AL
	for gcvg-git-2@gmane.org; Thu, 25 Jun 2009 20:45:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753772AbZFYSpN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 25 Jun 2009 14:45:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753368AbZFYSpM
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Jun 2009 14:45:12 -0400
Received: from an-out-0708.google.com ([209.85.132.240]:22430 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753358AbZFYSpL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Jun 2009 14:45:11 -0400
Received: by an-out-0708.google.com with SMTP id d11so225166and.1
        for <git@vger.kernel.org>; Thu, 25 Jun 2009 11:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=BhCAOauQLKWaB5I9MECM1oI1FJkmQXDg/DXBa4uPLYI=;
        b=nCUNrpiFPGrS/e8WQeYPRPbfx97q0tkJaTMyPnFtFieHvJtdXF39A6cv552b66G6Z7
         rASnr/uHX8BeeWyR6rS10VdpDLLuAiNNmgvQ5iOM4TckuqnHGF9q1A/VpGIHqof/pdBN
         lBea6KkDdCqhTIHDwYv8g5c7lPfRmnvmF9Cpw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=K248/0l0nuuil0xq83qW657vLnwcGb9jFxFWb1fGjW6z1x1JGEZhOvavg9MTVcUGlj
         HSj2/ErQl7B/N9Y86acrrS9FB8fMUp5IW1dfj5O4XIF7fYJV83wmX0CMUqKib8dDP89l
         01lLlryY36RkrC3a2M9J7SWlg9qD8uWVo2bik=
Received: by 10.100.171.13 with SMTP id t13mr3753290ane.29.1245955513961; Thu, 
	25 Jun 2009 11:45:13 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0906251857010.8908@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122231>

Thanks everyone.

On Thu, Jun 25, 2009 at 12:57 PM, Johannes
Schindelin<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Thu, 25 Jun 2009, Randal L. Schwartz wrote:
>
>> >>>>> "Jakub" =3D=3D Jakub Narebski <jnareb@gmail.com> writes:
>>
>> Jakub> Tim Visher <tim.visher@gmail.com> writes:
>> >> Can git display a list of all of your current aliases like bash's
>> >> `alias` command?
>>
>> Jakub> In ~/.gitconfig:
>>
>> Jakub> =C2=A0 [alias]
>> Jakub> =C2=A0 =C2=A0 =C2=A0 =C2=A0 alias =3D config --get-regexp ^al=
ias\\.
>>
>> But then it shows itself. :)
>
> Which is correct.
>
> Ciao,
> Dscho
>
>



--=20

In Christ,

Timmy V.

http://burningones.com/
http://five.sentenc.es/ - Spend less time on e-mail
