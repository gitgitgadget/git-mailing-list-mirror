From: Howard Miller <howard@e-learndesign.co.uk>
Subject: Re: What IDEs are you using to develop git?
Date: Sun, 30 Aug 2009 20:06:15 +0100
Message-ID: <26ae428a0908301206s38b36901y6027486f0d780ebc@mail.gmail.com>
References: <000001ca257d$b60326c0$22097440$@com>
	 <43d8ce650908250547t17b76c95qb9931983e0a4b232@mail.gmail.com>
	 <1251655664.31273.4.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: John Tapsell <johnflux@gmail.com>,
	=?ISO-8859-1?Q?Frank_M=FCnnich?= <git@frank-muennich.com>,
	git@vger.kernel.org
To: Daniele Segato <daniele.bilug@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 30 21:13:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MhpqM-0006w4-W2
	for gcvg-git-2@lo.gmane.org; Sun, 30 Aug 2009 21:13:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751080AbZH3TN3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 30 Aug 2009 15:13:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750883AbZH3TN3
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Aug 2009 15:13:29 -0400
Received: from mail-ew0-f228.google.com ([209.85.219.228]:52359 "EHLO
	mail-ew0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750716AbZH3TN2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 30 Aug 2009 15:13:28 -0400
X-Greylist: delayed 434 seconds by postgrey-1.27 at vger.kernel.org; Sun, 30 Aug 2009 15:13:28 EDT
Received: by ewy28 with SMTP id 28so3458304ewy.39
        for <git@vger.kernel.org>; Sun, 30 Aug 2009 12:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=eQlKURaFIYBZAbUAY9+oZawBCatF2C+3gqqdXEWd9kg=;
        b=lT3SZnDYdB1i3DyRlSa/kLwcDcwY8ChnSsC74+i221VGmKSLCV0i551T6a133V0McE
         /saDnBhhLG7yfySMmkqH95V7KAFdpfgrotAAR88fLIPo4bTG/Xst8b6o6WGzbwkQxflg
         6bVEhpirhYSF00UnxCwYvHi+xLH5Gt7OMWfw0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=VsmdueUCIKtsjU2m7vmSy+XNOiJLbZx7GHeo8tWc9c1iiz5A/dSN8on9rkctTDiaeq
         4/yLvKbYHwVW5hLup/yZUgMusrMPpAeGAXzKXED7CBJEArEzUIQKPD31+gpbQY+OjBOq
         T6r2b2wrD6CwwHOWEaP0o3ks4im/A1TrOptJo=
Received: by 10.216.52.78 with SMTP id d56mr903547wec.143.1251659175963; Sun, 
	30 Aug 2009 12:06:15 -0700 (PDT)
In-Reply-To: <1251655664.31273.4.camel@localhost>
X-Google-Sender-Auth: 0a71583d72a0ddcb
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127421>

I can only reply very generally (I don't develop git - I develop php
and use git). However, I have tried to use Eclipse on a number of
occasions and have always drifted back to Vim. With a bit of learning
can can do most of the stuff that an IDE does, usually faster and with
less fuss. However, the killer for me is that you can access your
development box in an emergency over a slow dialup line and vim will
get you out of trouble - your fancy, resource-hogging IDE will not.

2009/8/30 Daniele Segato <daniele.bilug@gmail.com>:
> Il giorno mar, 25/08/2009 alle 13.47 +0100, John Tapsell ha scritto:
>> 2009/8/25 Frank M=FCnnich <git@frank-muennich.com>:
>> > One thing I would like to ask you: what, if any, IDEs are you work=
ing with?
>>
>> I think everyone just uses vim/emacs :-)
>
> I can't get how would one take vim or emacs instead of an IDE like
> Eclipse.
> That's probably because I'm mainingly a Java developer and i don't kn=
ow
> vim/emacs very much.
>
> What are the advantages of developing git with vim/emacs over an IDE?
>
> Cheers,
> Daniele
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
