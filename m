From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: should Documentation/howto/setup-git-server-over-http.txt be
 marked obsolete?
Date: Sat, 23 Oct 2010 11:59:00 +0530
Message-ID: <AANLkTi=mP6r=QSLs-rVv3H1PKpwA3NQZW90Nwn1Zu3V6@mail.gmail.com>
References: <AANLkTimJe9vEUwWM482NLmfHGYjnsKD5RAryQO=Zyqjj@mail.gmail.com>
	<7vsjzyrh2w.fsf@alter.siamese.dyndns.org>
	<AANLkTinv3kzvtC_Pq4F0cM_JqU7-Q2a=sWs8YSxbMiPs@mail.gmail.com>
	<7viq0um5vt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 23 08:29:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9Xba-0007rL-77
	for gcvg-git-2@lo.gmane.org; Sat, 23 Oct 2010 08:29:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752263Ab0JWG3E convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 23 Oct 2010 02:29:04 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:60328 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752041Ab0JWG3C convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Oct 2010 02:29:02 -0400
Received: by ewy7 with SMTP id 7so2219157ewy.19
        for <git@vger.kernel.org>; Fri, 22 Oct 2010 23:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=yiJCn07UrVqOZKCAM29+5CGmmwtsnWve1bwGZ36azeE=;
        b=u713BkR2bVtciRcHrn90nzR0+R8sXNX+sEXtK+SeUvyImcaY3ssK4JAJXyPwKZlzb6
         X0s0JWzH3OsIx0zjamneSjQFn5vCpP4sGh6NQ/S7kwKJDiL8ZZn/f0wn91onqPEaCusJ
         EvXuIO+m9+asBjqt3xOKnAIa2q25R9KaGWW6I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=GjeNq93G+xuWpfV8cxDWmwiOHDMrYYlDqvQ7RAsBjCwT/uG9Ld6mbd7CNznCU6ZKoY
         6ZW9fuGA9eTHAhYK3GkNNmaXN9UiDK12Kn+CynLBMtum9i63vs5K6dbZRR7v5DxhjAUj
         S63odw37vhiIWqLDH2uVb+/seIGtXIPdybGcY=
Received: by 10.213.102.4 with SMTP id e4mr158009ebo.3.1287815340936; Fri, 22
 Oct 2010 23:29:00 -0700 (PDT)
Received: by 10.213.14.6 with HTTP; Fri, 22 Oct 2010 23:29:00 -0700 (PDT)
In-Reply-To: <7viq0um5vt.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159773>

On Sat, Oct 23, 2010 at 12:06 AM, Junio C Hamano <gitster@pobox.com> wr=
ote:

> No; that would mean the next step would be (as you suggested)...
>
>>> =C2=A0- When the above two is done, insert one line "This describes=
 an older
>>> =C2=A0 way; see <<insert the name of the other document here>> for =
insn to set
>>> =C2=A0 up an experimental smart HTTP server" at the beginning of th=
e original
>>> =C2=A0 document.

I meant to ask earlier but forgot.  Is this considered experimental sti=
ll?

> ... this one.
>
> I trust you can take care of the gitolite documentation side ;-)

;-)
