From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: Nits abut the italian translation (was: Re: Please pull git-l10n
 updates on master branch)
Date: Fri, 1 Jun 2012 21:49:21 +0800
Message-ID: <CANYiYbGgPZMYC9ea8jsKkz6ybBBb_Kyx+gBFncaGYW=Wh0m-Zg@mail.gmail.com>
References: <CANYiYbF3sbtKVTZJOTbQ-aOjBKGKFZfq-xQDwyOvR56C7akrLw@mail.gmail.com>
	<4FC8A88D.3080700@gmail.com>
	<20120601123642.GA11543@quizzlo.invalid>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Stefano Lattarini <stefano.lattarini@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>,
	Peter Krefting <peter@softwolves.pp.se>,
	=?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>
To: Marco Paolone <marcopaolone@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 01 15:49:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SaSEN-0003sb-Cp
	for gcvg-git-2@plane.gmane.org; Fri, 01 Jun 2012 15:49:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759882Ab2FANtX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 1 Jun 2012 09:49:23 -0400
Received: from mail-gg0-f174.google.com ([209.85.161.174]:34689 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759848Ab2FANtW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 Jun 2012 09:49:22 -0400
Received: by gglu4 with SMTP id u4so1733591ggl.19
        for <git@vger.kernel.org>; Fri, 01 Jun 2012 06:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=eR2X73czvQaaRjKMoXUuA+QGuws+1hUIfP0uCBzRQHs=;
        b=jkLraX7D+aYSxLGia/YdXSfsZUpgQ0Na9zMz5cGbp0/e5vKIMUH5FseJ2QAbq6Jt59
         dYL9Q+eSZ9fgVbKLIO3+QHSOmJTlG1s1+iMUXz9OcozzK2cHlYGhf3fzTxI1Cg3wZIlD
         yHpyx3cUHzI3XSp2VFXsAjwOElBFYHI8higa9aGZJi7mzVvorC3WZsaHOzfd9u4QBZ4K
         PqF9kWx2hKdwbnUq38dMnFF2ZYRwG1qveBmKQbwFqw3qzRtIUpF2nvfs7wCC58UwLnhH
         lFBJZhDrKryDWiW+WesBs9S/glJ3dbI7yWT9HTSaqwW5CRmG56l8b3mTcTMZt6yD8JBK
         fTog==
Received: by 10.50.209.73 with SMTP id mk9mr1496373igc.66.1338558561488; Fri,
 01 Jun 2012 06:49:21 -0700 (PDT)
Received: by 10.50.111.194 with HTTP; Fri, 1 Jun 2012 06:49:21 -0700 (PDT)
In-Reply-To: <20120601123642.GA11543@quizzlo.invalid>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198987>

2012/6/1 Marco Paolone <marcopaolone@gmail.com>:
> Thanks for your report, I'll fix them in next commit. =A0We could eve=
n leave terms

Italian team may have team members this time, update the po/TEAMS
file, and when there are new translation updates, you can send
review request to other team members.

Different l10n teams have different ways for communication.
The German l10n team uses this list, while Chinese l10n team
use weibo (a twitter clone, because of the strict Internet censorship
in China) and googlegroup, such as http://groups.google.com/group/gotgi=
t.

--=20
Jiang Xin
