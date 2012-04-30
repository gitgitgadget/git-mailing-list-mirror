From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Branch to base i18n work on?
Date: Mon, 30 Apr 2012 18:37:11 +0700
Message-ID: <CACsJy8ADeD25C6di=PTv1U_O9K5PTkGSJN+7svhv6AWNjtOAcg@mail.gmail.com>
References: <CACBZZX5M1X8oU7gh-BVnKrVP75+piXLbaimTCONrw-hWBqLnbw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Xin Jiang <worldhello.net@gmail.com>
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 30 13:37:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SOovM-0004Uq-35
	for gcvg-git-2@plane.gmane.org; Mon, 30 Apr 2012 13:37:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755410Ab2D3Lhn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Apr 2012 07:37:43 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:53233 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752266Ab2D3Lhm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Apr 2012 07:37:42 -0400
Received: by wibhj6 with SMTP id hj6so2753429wib.1
        for <git@vger.kernel.org>; Mon, 30 Apr 2012 04:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=A7+GpcQKFgONiupGJMhxcpDQAIi0COVEKU/NJmg59Is=;
        b=mMOHx6nKoG23K7qQuoalIsN0JMe8BHZ24F/jelNS49jLvFoJ59SW08IGiQkFps4l96
         iWy+u1OIq9KrQkpA8lE0UfuBx4e5ta1wXEJqyJ94iuPf/QezW4h9AwjBgekcvqVtTFz7
         X7CBIXjNPwKEDQWfkhvwhHvmnUAn/yeaBaBsHAWkdSW6Jg+bRWYirGXFzBNsuzEERZqb
         1X59X6Jo3YYk44g2HqvFCA7Q1eTdl9ezbL0v0MBLXJ/hcDw/dcVKZbXUbGYUEf8FuvU1
         /CPNdzvVDGMMQhRqI7NdT33Uh9DtzvL7nZaEpw03/VI7GtqU5duB9XAJvVV31Rf1u3jR
         HE5Q==
Received: by 10.216.139.194 with SMTP id c44mr12761740wej.112.1335785861668;
 Mon, 30 Apr 2012 04:37:41 -0700 (PDT)
Received: by 10.223.14.193 with HTTP; Mon, 30 Apr 2012 04:37:11 -0700 (PDT)
In-Reply-To: <CACBZZX5M1X8oU7gh-BVnKrVP75+piXLbaimTCONrw-hWBqLnbw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196555>

2012/4/30 =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>:
> We have at least one series in flight to mark up more messages in Git=
 for i18n.
>
> I'd like to do some work on this as well, but I don't want to
> duplicate efforts, is there someone who's further ahead than pu/next
> are so I can base my work on that instead of pu/next?
>
> Nguy=E1=BB=85n, is there some repository I can pull your series from =
without
> trying to extract it from Junio's tree where it's been rebased with
> other work?

Nope. I think you should base on master though, just extract related
series and merge/rebase on top. nd/i18n is actually on top of master.
--=20
Duy
