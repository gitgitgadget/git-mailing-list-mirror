From: Aghiles <aghilesk@gmail.com>
Subject: Re: potential improvement to 'git log' with a range
Date: Fri, 9 Apr 2010 20:13:22 -0400
Message-ID: <n2t3abd05a91004091713s4d081106qd74419425b25e8e@mail.gmail.com>
References: <w2j3abd05a91004091624mb2836ff4v118a1ae9ac5ca6e7@mail.gmail.com> 
	<i2kfabb9a1e1004091633nc70f2f19hd16ea9704f0933b0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git list <git@vger.kernel.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 10 02:13:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0OKc-0000to-SG
	for gcvg-git-2@lo.gmane.org; Sat, 10 Apr 2010 02:13:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756743Ab0DJANo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Apr 2010 20:13:44 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:49749 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756473Ab0DJANn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Apr 2010 20:13:43 -0400
Received: by wwi17 with SMTP id 17so1201360wwi.19
        for <git@vger.kernel.org>; Fri, 09 Apr 2010 17:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type;
        bh=BT1Rx1l5kdP5pQGwjNZ3hGhy7b+2VQ5dvDcLeopsuSY=;
        b=mxWOX2hr6GUkQFpdD7VBvag4qUpBQunUaDOTocaISdJpaobpI4FoKelFXoConSsmrd
         4i+XRkpvEmfw75EwsOHYPhTLciKYtIOgNjoC3FbPy3gHuFD0+qXAv8Ip2esw9uxo/6vq
         3AgUnqj1FglRj+G8NqoO9ZpSGw78ypczla54A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=wxnEtYXtG1q/7AwKBffPTG/4Q+m+t2uyTmppNm/xxoYIrkyj9dHcZf6z6RsRdNWBVu
         pJS0z//gW7nTmKhbS0geM+fWwocptl4HRhyEWsjxLwbOh5+vV425EO9odVHte2t8YaCo
         CjKDeJCsVQscq0mpu6bfSnBOHokt1g/Fv8Po4=
Received: by 10.216.170.8 with HTTP; Fri, 9 Apr 2010 17:13:22 -0700 (PDT)
In-Reply-To: <i2kfabb9a1e1004091633nc70f2f19hd16ea9704f0933b0@mail.gmail.com>
Received: by 10.216.85.133 with SMTP id u5mr454847wee.91.1270858422136; Fri, 
	09 Apr 2010 17:13:42 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144492>

Sverre Rabbelier <srabbelier@gmail.com> wrote:
>
> Yes, read up on the documentation as to what ".." means. Hint, a \ b
> is not the same as b \ a [0].
>
> [0] http://en.wikipedia.org/wiki/Intersection_(set_theory)
>

Oh, I should have read the documentation. I was certain that ".." stands
for a range but it is a ... complement.

Thanks for you help.

  -- aghiles
