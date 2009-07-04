From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] Git User's Survey 2009 - second trial run, and question  about announcing it
Date: Sun, 5 Jul 2009 00:43:58 +0200
Message-ID: <200907050043.58875.jnareb@gmail.com>
References: <200907030130.24417.jnareb@gmail.com> <20090704012635.GB39268@gmail.com> <94a0d4530907040124i32abe421x86e5c8f0839bf2fa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Aguilar <davvid@gmail.com>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 05 00:44:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MNDyG-0007Uh-6U
	for gcvg-git-2@gmane.org; Sun, 05 Jul 2009 00:44:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753055AbZGDWoG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 4 Jul 2009 18:44:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752918AbZGDWoF
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Jul 2009 18:44:05 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:59977 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752508AbZGDWoE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Jul 2009 18:44:04 -0400
Received: by fxm18 with SMTP id 18so2905370fxm.37
        for <git@vger.kernel.org>; Sat, 04 Jul 2009 15:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=yRJBxw7F5BVHQoaYd3hppcyo5VQtQnoZUuc+6+CI+G4=;
        b=uMYg0ArHy9t1VqzFRBd6iP83z2Ebb3umu4mAARtzbAvnKuetX1Sgy9KBDwIH8HOgmI
         JmyxFIe2F85vlSVjocmDZr9XTZ+rsNJuSYUrX7onAsF59LzvlgLtRQP9aB59J/GaKLKg
         MCAsv8X2QnwZ3ptevRRdU4Oo2777YeJU26gGg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=BXR0QX+oFxj4+BDPVYCT13jzIRASLLq1rIAJBxATpL1uB5P87vns5cnda6EsORkR8R
         2CCU8zERPBrnvWrMSiGofUO6vLcmMZZPn5+W/TYA01jURA4N04qOWafkvC1TJH65U9CK
         e624/UTCCJLOnENqE6JohOMychazUX2ndeD7A=
Received: by 10.103.197.14 with SMTP id z14mr1695915mup.1.1246747446482;
        Sat, 04 Jul 2009 15:44:06 -0700 (PDT)
Received: from ?192.168.1.13? (absh167.neoplus.adsl.tpnet.pl [83.8.127.167])
        by mx.google.com with ESMTPS id t10sm25393274muh.30.2009.07.04.15.44.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 04 Jul 2009 15:44:05 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <94a0d4530907040124i32abe421x86e5c8f0839bf2fa@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122731>

On Sat, 4 July 2009, Felipe Contreras wrote:
> On Sat, Jul 4, 2009 at 4:26 AM, David Aguilar<davvid@gmail.com> wrote=
:
>> On Sat, Jul 04, 2009 at 02:19:25AM +0300, Felipe Contreras wrote:
>>> 2009/7/3 Jakub Narebski <jnareb@gmail.com>:
>>>
>>>> 20. Overall, how happy are you with Git?
>>>> =C2=A0 =C2=A0* unhappy
>>>> =C2=A0 =C2=A0* not so happy
>>>> =C2=A0 =C2=A0* happy
>>>> =C2=A0 =C2=A0* very happy
>>>> =C2=A0 =C2=A0* completely ecstatic
>>>
>>> Let's leave room for git haters too:
>>> =C2=A0* I hate it
>>
>> Umm, let's not.
>>
>> If they hate it, they'll be in the "unhappy" category.
>> And if they hate it, I doubt they'll be filling out this survey.

[...]
>> Let's not encourage them by including including "I hate git"
>> in our survey.
>=20
> That's a good point, I just thought it would be nice to spot them;
> which would be easy if they answer "I hate it". But also, if there's
> an extreme positive (completely ecstatic) I thought there should be a=
n
> extreme negative, just in case.
>=20
> Probably not important at all.

Hmmm...

On the one hand side it would be better, I think, to have balanced set
of answers, with neutral position in the middle, and unhappy/happy
along the axis.

On the other hand that was the set of answers used in previous surveys,
so if we change it it would be harder to compare against surveys in pas=
t
years.

--=20
Jakub Narebski
Poland
