From: =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: co-authoring commits
Date: Fri, 19 Jun 2015 23:25:19 +0200
Message-ID: <CANQwDwd8V-RO2XbkdraLhwmvCbUb=1KBTxmf-ZtyQ7gCVXAeWQ@mail.gmail.com>
References: <CAOvwQ4i_HL7XGnxZrVu3oSnsbnTyxbg8Vh6vzi4c1isSrrexYQ@mail.gmail.com>
 <xmqq4mm66r99.fsf@gitster.dls.corp.google.com> <CAOvwQ4j2bjR1jnLVyZbw1OCE=xQxbCEFGKcK1bpuv1K3s_Y2EQ@mail.gmail.com>
 <20150617225224.GF4076@thunk.org> <CAOvwQ4jb-w4+Ah3ZhVE0j1aXLx1=8tRN3Wo98tz+G-wEqLGAcA@mail.gmail.com>
 <55845CFE.4070407@gmail.com> <CAOvwQ4gYsQtZPWOA+1gBtdw9XkjQ4WGipk9grb+_ad9iiBj5Og@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Theodore Ts'o" <tytso@mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	git <git@vger.kernel.org>, Josh Triplett <josh@joshtriplett.org>
To: Tuncer Ayaz <tuncer.ayaz@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 19 23:26:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z63nc-0002lJ-6x
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jun 2015 23:26:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755946AbbFSV0E convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Jun 2015 17:26:04 -0400
Received: from mail-la0-f45.google.com ([209.85.215.45]:35387 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755524AbbFSV0C convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Jun 2015 17:26:02 -0400
Received: by labko7 with SMTP id ko7so81569193lab.2
        for <git@vger.kernel.org>; Fri, 19 Jun 2015 14:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=jGLWYs7VerfB8gPAZ+UxeBDroE194WrhWa9RPnhyjys=;
        b=iDXnBkbCUIAIHBImQAPGkQVKfE7CuHc/ACG6g220nnP5nuKGu1TgVJw8Gpazv2ure1
         mZyIEfKJaXPjT2F9ZXlp9SMO/LLepu8mX7crNxMSkM2An1qWVgMNN/wVivt0qsDxnXMG
         7EcwsM8Ph+f9eCajozjc6N6mDz2gvEdPFi7Wb65f5QPaeLaSNKDuGW+edhGmGPLaFWXu
         jfFXII58wlF1NcAZJLhWtoJqb/iT9669f5eu3vA2alHa8mr08vVrTl7AWJQiIDf3k1El
         W2TMQrf0yZuCyZvCHCZ92+eZP+puhhid8z2tUX5o1cclthi7FU0R3NkptcLX5P2AXtJI
         7mRQ==
X-Received: by 10.112.163.101 with SMTP id yh5mr19652125lbb.25.1434749160664;
 Fri, 19 Jun 2015 14:26:00 -0700 (PDT)
Received: by 10.25.128.213 with HTTP; Fri, 19 Jun 2015 14:25:19 -0700 (PDT)
In-Reply-To: <CAOvwQ4gYsQtZPWOA+1gBtdw9XkjQ4WGipk9grb+_ad9iiBj5Og@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272213>

On Fri, Jun 19, 2015 at 11:11 PM, Tuncer Ayaz <tuncer.ayaz@gmail.com> w=
rote:
> On Fri, Jun 19, 2015 at 8:18 PM, Jakub Nar=C4=99bski <jnareb@gmail.co=
m> wrote:

>> [This is sent from Thunderbird news, so it should be all right]
>
> This is fine, the other one was broken. Out of curiosity what's the
> difference between Thunderbird email and news?

One was sent as Reply All from the news interface (nntp://news.gmane.or=
g),
one was sent as Reply All from the email interface (Gmail account).

Damned if I know why the difference...
--=20
Jakub Narebski
