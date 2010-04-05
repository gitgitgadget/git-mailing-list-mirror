From: Howard Miller <howard@e-learndesign.co.uk>
Subject: Re: Mysterious junk in file.... "not commited yet"
Date: Mon, 5 Apr 2010 20:03:11 +0100
Message-ID: <p2y26ae428a1004051203jbb7c838eh8de0cb5f6ae1dcb1@mail.gmail.com>
References: <i2v26ae428a1004051113q68a0cf13o65fbf1349f941648@mail.gmail.com>
	 <o2n32541b131004051152ie6c82b3wdab0f38a9e657943@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 05 21:03:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NyrZu-0000uL-AN
	for gcvg-git-2@lo.gmane.org; Mon, 05 Apr 2010 21:03:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755489Ab0DETDO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 5 Apr 2010 15:03:14 -0400
Received: from mail-fx0-f227.google.com ([209.85.220.227]:56416 "EHLO
	mail-fx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754736Ab0DETDM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Apr 2010 15:03:12 -0400
Received: by fxm27 with SMTP id 27so1273220fxm.28
        for <git@vger.kernel.org>; Mon, 05 Apr 2010 12:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:received:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=4LQYViDqtQsTIT+5mKn0rskLH/naL+X+sC52PBJlIBU=;
        b=XPUuRasyrEfN8StiKV9ZneH2GQYT2sioaFc9ir2iebAeGuNaCJuPuiyDAcpbOeXZ1s
         lpbOWBJfZvfy/SuhWYrvCT7mY7EW4C3iSnYyQ8OAvX6TSQgQC6od3HOIP2peswM5BHtI
         JQzBcHw6mtvRCHzUU9cXMjIBZY1BzI3j0i6Ro=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=kMD7NCOLf10b0AsuEwYZTdOgRf6YCuHJ4fReRlCJSv7HaEWW5lEkpNlw9CKNNW0vuq
         5svfZvJq1gTF97L7xiMv/TMoT3//un2NXPt9LDaoR8QBEN9mvlqq0MlZYxcEJGxoL15N
         HA4NR1+Nao7Gyt6mjIf8Zx5/i86BqkWgHyd/Y=
Received: by 10.239.160.143 with HTTP; Mon, 5 Apr 2010 12:03:11 -0700 (PDT)
In-Reply-To: <o2n32541b131004051152ie6c82b3wdab0f38a9e657943@mail.gmail.com>
X-Google-Sender-Auth: a40090c3b9cf1afa
Received: by 10.239.158.68 with SMTP id t4mr514920hbc.72.1270494191085; Mon, 
	05 Apr 2010 12:03:11 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144049>

>
> You might have 'git add'ed the changed line. =A0Try this:
>
> =A0 git checkout HEAD -- <filename>
>
> Have fun,
>
> Avery
>

Hmmm... fixed. I've never even heard of 'git add' before. Why is this
different to plain old 'checkout' without the HEAD?

Anyway... thanks. Day saved :)
