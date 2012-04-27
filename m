From: Hilco Wijbenga <hilco.wijbenga@gmail.com>
Subject: Re: Subtree in Git
Date: Fri, 27 Apr 2012 14:09:38 -0700
Message-ID: <CAE1pOi2+FqfsyF3RsQPG4cVMHwXCStgom+8eT3o8MnTesFK6rw@mail.gmail.com>
References: <CAE1pOi2uT=wipyrOYCwy9QuXnXFV27F1gN3Ej-RaSr-fegQCfA@mail.gmail.com>
	<nngk410vrja.fsf@transit.us.cray.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Users <git@vger.kernel.org>
To: dag@cray.com
X-From: git-owner@vger.kernel.org Fri Apr 27 23:10:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SNsQa-0000Ch-Ux
	for gcvg-git-2@plane.gmane.org; Fri, 27 Apr 2012 23:10:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752388Ab2D0VJk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 27 Apr 2012 17:09:40 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:57105 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751679Ab2D0VJj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 Apr 2012 17:09:39 -0400
Received: by yenl12 with SMTP id l12so731153yen.19
        for <git@vger.kernel.org>; Fri, 27 Apr 2012 14:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=z2OlzdPphjK2bS7o0erCDGDwXUKNY+xurew5/pIuEmw=;
        b=MqtK6VhkXbYqY048LeUlCAZUfextUigO8A6XtYrPSlFyiTLMNPV2t2reW5niXJKQio
         Tc9DUzstIBJlrgyUtcqxbLEFoq9Vzj+TGrDAFV7NzPqvQpARz3R7SLmeIjh0Nezxo/1i
         lJJG8xIdpplXEqiQr3Vg6n0M72hItjCBZojCMNBZCa8nHZG3g2lE4EqdFyz/ze9pblho
         X8aNcOm5uW0hxvfj50TMv9Vz3S0gPLMJZcOqTviW3GuzkKyo77mC0OIRvoFfQkcIjfKF
         kvsukkui5pqbOQXqtlxw6LwnMhx+JNURDDxBoQzxPiqMl2qLt5CkC3hzBNSJ2NOPOxzh
         huBg==
Received: by 10.236.175.41 with SMTP id y29mr13063445yhl.60.1335560978609;
 Fri, 27 Apr 2012 14:09:38 -0700 (PDT)
Received: by 10.236.79.98 with HTTP; Fri, 27 Apr 2012 14:09:38 -0700 (PDT)
In-Reply-To: <nngk410vrja.fsf@transit.us.cray.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196485>

On 27 April 2012 13:38,  <dag@cray.com> wrote:
> Hilco Wijbenga <hilco.wijbenga@gmail.com> writes:
>
>> Do we have an idea of when subtree support will be a part of Git cor=
e?
>> I am aware that I can install it separately but I'd like to know if
>> there is something like a timeline or a target Git version number. A=
nd
>> "no", is fine. :-)
>
> We don't know right now. =C2=A0I want to take a look at Herman's patc=
hes
> first but have been delayed for various reasons. =C2=A0I hope to get =
to that
> this weekend. =C2=A0I also want to get at least one release under our=
 belt.

I pretty much expected that. :-) Good luck!

No worries, I've just installed the latest Subtree from contrib/ so I
can play with it. I just don't want to rely on Subtree until I no
longer have to tell everyone to install it separately. That's just not
going to fly. :-)
