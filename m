From: Drew Northup <n1xim.email@gmail.com>
Subject: Re: [PATCH 66/66] Use imperative form in help usage to describe an action
Date: Wed, 22 Aug 2012 14:32:18 -0400
Message-ID: <CAM9Z-nmrtU_a1v_4C_j=YAF7_HZ4+hGnBUcp969JfAbSXgUBig@mail.gmail.com>
References: <1345465975-16927-1-git-send-email-pclouds@gmail.com>
	<1345465975-16927-67-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jonathan Niedier <jrnieder@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 22 20:32:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4Fj9-0000r7-Jr
	for gcvg-git-2@plane.gmane.org; Wed, 22 Aug 2012 20:32:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933251Ab2HVScW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 22 Aug 2012 14:32:22 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:39734 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933208Ab2HVScU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Aug 2012 14:32:20 -0400
Received: by bkwj10 with SMTP id j10so435959bkw.19
        for <git@vger.kernel.org>; Wed, 22 Aug 2012 11:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=yoSg+jS/7THgR7s+EN4zDOm2YgWyTO5FN1BqfrvUxms=;
        b=hSHeDRR/MYC04uh7ExkzTAcSR5Q9wp4beFGmg3zGqgH6e7yVgpZuFOYgunCh/tSv3e
         AdEJCEbDBFg7/ZQ4+MhUPDj8hQLLSk9mMz89KpkOfI4d8LcIoAr5kRqHA1j7JJRFMhRS
         AAYZQFaVLv5bj9hGS+Ykpi4tB8fCeWpZVmEaGBwEJaV8weddlM19N6eD8pksARny+6em
         0cqaizMngGiQoXxDGz8B5pg/K7I03RqjeMJy/5qf++mvcCdBPk3d4+ILOuVVpVHIDvfY
         Pw5kf4zWeYuYrHz+kXEcSBWZgqGXlYUZUWHofXupzTBkWihsFUNt1weQxBvpHqTtlkli
         uO/w==
Received: by 10.205.137.8 with SMTP id im8mr6769773bkc.135.1345660338987; Wed,
 22 Aug 2012 11:32:18 -0700 (PDT)
Received: by 10.204.10.87 with HTTP; Wed, 22 Aug 2012 11:32:18 -0700 (PDT)
In-Reply-To: <1345465975-16927-67-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204063>

On Mon, Aug 20, 2012 at 8:32 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc =
Duy <pclouds@gmail.com> wrote:
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  My guts tell me this is correct, but my English foundation is shakin=
g
>  so I say "change in the name of consistency"!

Your gut is working just fine. I haven't attempted to apply the patch,
but the English changes check out just fine. It could be argued that
these all should have taken the imperative form from the beginning as
the user is directing the program to do something (perhaps vicariously
via the documentation).

The other perspective I can think of off hand is that the
documentation is describing what the program options do to the user (a
different "audience")--which explains why the text wasn't in
imperative form to begin with.

--=20
-Drew Northup
--------------------------------------------------------------
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
