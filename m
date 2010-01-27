From: Weiwei Shu <shuww1980@gmail.com>
Subject: Re: How to email out commit message automatically?
Date: Wed, 27 Jan 2010 13:49:52 -0500
Message-ID: <65d12cb11001271049v1554a362y51aaeec9c4ceec77@mail.gmail.com>
References: <65d12cb11001270820i7094001odc4d9f27b7f57767@mail.gmail.com>
	 <vpq7hr3wln2.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, shuww2008@gmail.com
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Jan 27 19:50:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NaCxk-0003VQ-Cj
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jan 2010 19:50:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754002Ab0A0Stz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Jan 2010 13:49:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751637Ab0A0Stz
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Jan 2010 13:49:55 -0500
Received: from mail-bw0-f219.google.com ([209.85.218.219]:42586 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751395Ab0A0Sty convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Jan 2010 13:49:54 -0500
Received: by bwz19 with SMTP id 19so5026502bwz.28
        for <git@vger.kernel.org>; Wed, 27 Jan 2010 10:49:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=BVUbtu7ur3tsAzGrnXMWChgXo5/H0FXhI2B5ZCqv9YU=;
        b=qdNbvXbtYTyxmJRvn65uhv0VIOv/ggV7BG7NGgDFospaSGvHVRomRBdKjGhCdFK0Ep
         5vCuhKMYUfId3g6by7BDkwPYGIx9k0CHsMqqX39yH3WguvjGPLtyRiG1R55zTAjqz6ex
         3AOf/N357h2hb3j+YstgKrYtgnZ2inYn0YGvc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=orAHas3T4RUiS1y1RK6Ay9srKAjYJlCniOhhaI8faao1ykr/6JZFKRfZxNShqe5FRN
         0gVfu6jYiG1h2IG/Y21fF2foEEG0BEvee5i4qjhgjpSQ4Ssxc5kAq+b7tgKRZGIg8tuu
         jmpnk5gHEaf5VVi+MyhXm0HiaozEK45R9mwqE=
Received: by 10.204.8.202 with SMTP id i10mr5335953bki.133.1264618192786; Wed, 
	27 Jan 2010 10:49:52 -0800 (PST)
In-Reply-To: <vpq7hr3wln2.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matthieu,

I've tried it, but not successful.  Where should I setup email server
information?  Thanks!

Weiwei

On Wed, Jan 27, 2010 at 11:36 AM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Weiwei Shu <shuww1980@gmail.com> writes:
>
>> Hi All,
>>
>> The second time to post here. =A0Git is great.
>>
>> I would like to email the commit message to my Gmail box automatical=
ly
>> whenever I submit a commit. =A0Can anybody point me a link on how to=
 do
>> that? =A0I've searched it for half day but not successful. =A0Thanks=
!
>
> http://git.kernel.org/?p=3Dgit/git.git;a=3Dblob;f=3Dcontrib/hooks/pos=
t-receive-email
>
> --
> Matthieu Moy
> http://www-verimag.imag.fr/~moy/
>



--=20
Weiwei
--Hope Springs Eternal.
