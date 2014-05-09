From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v1 18/25] contrib: remove 'emacs'
Date: Fri, 09 May 2014 03:50:47 -0500
Message-ID: <536c96e73af79_2bf0e952f093@nysa.notmuch>
References: <1399597116-1851-1-git-send-email-felipe.contreras@gmail.com>
 <1399597116-1851-19-git-send-email-felipe.contreras@gmail.com>
 <CAFcZeCqbF54-KjHU1R3pC6XgWi21KcpRGB7HcbfSGyvTScQU2A@mail.gmail.com>
 <536c91f079e71_2bf0e952f0a@nysa.notmuch>
 <CAFcZeCo5mCfnUN1uBiaZnD6DL6y8hPhK5MPts5raLCTGwJX9Gg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Alexandre Julliard <julliard@winehq.org>,
	=?UTF-8?B?RGF2aWQgS8OlZ2VkYWw=?= <davidk@lysator.liu.se>,
	=?UTF-8?B?SmFrdWIgTmFyxJlic2tp?= <jnareb@gmail.com>
To: =?UTF-8?B?RGF2aWQgS8OlZ2VkYWw=?= <davidk@lysator.liu.se>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 09 10:50:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WigW8-0002cv-Kp
	for gcvg-git-2@plane.gmane.org; Fri, 09 May 2014 10:50:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755486AbaEIIuw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 May 2014 04:50:52 -0400
Received: from mail-oa0-f52.google.com ([209.85.219.52]:43174 "EHLO
	mail-oa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754110AbaEIIuv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 May 2014 04:50:51 -0400
Received: by mail-oa0-f52.google.com with SMTP id eb12so4429033oac.25
        for <git@vger.kernel.org>; Fri, 09 May 2014 01:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=+rzadLW4Xe1OEQVR6PdAS5zeGSgNqr413BxxznPdrv4=;
        b=On5uHGQWZV7pHUM+qzfl6P8XNcb9zmWwzS4FmKYFxOtbnZ2a7SkEJeyPsCjj9sUOLB
         Mh23qQk4uW7XWGkqs4UVhNFdtorZVFCAgxW1mIxYU0mnfOiQW8XvPKM00l/1yzBtAh+Z
         6R2t6q3Uh65fyP9b/WNEABUDV3tI4CpRxMUFqdj4D4oTJYp/kcarscbkjx6Xl67/JWPk
         3cobstcmOxvikUf5lzgo0yWTcbiYFRhd5/2zXNXOGVMwexwKrSmWxLvK9Zw1CCoHeDN3
         /1hJqziOK4OQxU+HIA2oZri59xucq+zkt9HZpjag1MJl8G3XHc81xYe/mqHE0ze9TvIc
         FZmA==
X-Received: by 10.182.117.195 with SMTP id kg3mr11287743obb.17.1399625450472;
        Fri, 09 May 2014 01:50:50 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id dh8sm14086985oeb.10.2014.05.09.01.50.48
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 May 2014 01:50:49 -0700 (PDT)
In-Reply-To: <CAFcZeCo5mCfnUN1uBiaZnD6DL6y8hPhK5MPts5raLCTGwJX9Gg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248536>

David K=C3=A5gedal wrote:
> 2014-05-09 10:29 GMT+02:00 Felipe Contreras <felipe.contreras@gmail.c=
om>:
>=20
> > David K=C3=A5gedal wrote:
> > > What problem does this removal solve?
> >
> > Please do not top post.
> >
> >   a) What problem does it solve by staying?
> >   b) Where are the tests?
> >   c) Why it cannot be moved to an outside repository like may other
> >      git-related tools?
>=20
> Fair enough. I guess the target should rather be to get it into the e=
macs
> distribution.

That would be ideal I think.

However, I see many tools that already exist in the emacs wiki[1].

Why can't this one be one for those?

Cheers.

[1] http://www.emacswiki.org/emacs/Git

--=20
=46elipe Contreras