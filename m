From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 13/51] i18n: git-pull die messages
Date: Sun, 3 Apr 2011 20:14:12 +0200
Message-ID: <BANLkTinFT77rGXc08eXGMsucyQ7qkcKTsg@mail.gmail.com>
References: <1301849175-1697-1-git-send-email-avarab@gmail.com>
	<1301849175-1697-14-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 03 20:14:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6Roa-00031a-80
	for gcvg-git-2@lo.gmane.org; Sun, 03 Apr 2011 20:14:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752870Ab1DCSOO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Apr 2011 14:14:14 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:46973 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752848Ab1DCSOO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 3 Apr 2011 14:14:14 -0400
Received: by fxm17 with SMTP id 17so3495451fxm.19
        for <git@vger.kernel.org>; Sun, 03 Apr 2011 11:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ecTabjJhFF6R0Q4+pr3+ldLqubOu+3v28LZiJ0zvKMk=;
        b=e2+wJDQ/ynWKoTxGV0X6ACGoZQabV4pgRT378sFR8WyFtIyQep9zXHrmZDQk+Jz2Xq
         zRTw/jBPG/zVlqBf/1cLqDrwaGIIzX87K9kJ0QAJoaQly+j+eI/z0QFK4GQGdCCf1dEX
         xx0fetSvpADgn+Ka2VbF8bb+oyE3EmaCWwjPU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=U0qGSHThJEa0guaA8rbSYj8mZUuK4BqOucXwvQn8M7bRSF++7+BNIg76VUj/8v8X0t
         FRgaXXWoWi/xnjYiezzZXwKb/ZiakZaiEvVVcz7aoACvKxkgObb54bJvIf68DM1zWqOR
         zSCz1hReBKNdSkFkRTkFs1ERYDvS8kkG0OuVM=
Received: by 10.223.14.137 with SMTP id g9mr5260573faa.8.1301854452867; Sun,
 03 Apr 2011 11:14:12 -0700 (PDT)
Received: by 10.223.93.196 with HTTP; Sun, 3 Apr 2011 11:14:12 -0700 (PDT)
In-Reply-To: <1301849175-1697-14-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170766>

On Sun, Apr 3, 2011 at 18:45, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <a=
varab@gmail.com> wrote:

> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # XXX: This is an =
abomination
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0require_clean_=
work_tree "pull with rebase" "Please commit or stash them."

I'd forgotten that I'd left that in there.

Anyway, we can just skip translating these for now.
