From: Jiang Xin <worldhello.net@gmail.com>
Subject: Minor update on po/git.pot
Date: Tue, 16 Oct 2012 08:54:08 +0800
Message-ID: <CANYiYbETgWEEw_uJbnWgkDAtLV+YRjkMCnTuzXmcz0BFa+pRDQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: Byrial Jensen <byrial@vip.cybercity.dk>,
	Ralf Thielow <ralf.thielow@googlemail.com>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
	Marco Paolone <marcopaolone@gmail.com>,
	Vincent van Ravesteijn <vfr@lyx.org>,
	Marco Sousa <marcomsousa@gmail.com>,
	Peter Krefting <peter@softwolves.pp.se>,
	=?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 16 02:54:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNvQL-0002Az-UF
	for gcvg-git-2@plane.gmane.org; Tue, 16 Oct 2012 02:54:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755293Ab2JPAyL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Oct 2012 20:54:11 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:60371 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751679Ab2JPAyJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Oct 2012 20:54:09 -0400
Received: by mail-ie0-f174.google.com with SMTP id k13so8912373iea.19
        for <git@vger.kernel.org>; Mon, 15 Oct 2012 17:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=6oYHsRF/98i770h1wO2zo/VAOFtP2sKu9oLc6syuICE=;
        b=VzT3Iud7lrxv7ejoX/giDlLhylLrAlgMUOjrqHLdAN8oOPZm4VI2i/Hj8HnRfqE7FI
         MG0uz1zVydyFTbaGLljbXsOjEWq5t+pWmUuSoLEABJ3/qv6M+tDDiJcp6D/j5L+4ngwX
         f0fBTnwOolz+2I5gsvyayMDn5skIKaWnQrdDjJ8fX1hAVA47ZFm0JN5LPUYa7V2dmNnC
         HhQDanOs9r29w3hJsB/6trk13k1S3ItlmnHCbsg7RA2a03YU9IA74Rqm3DfkECt30W6+
         pay9ZpxNxezrexdd4N2cIXrWtuMnwbsdSqIuHgveMxEciPWScrMM7Ipgoh42wfKqSlGz
         OQqw==
Received: by 10.50.158.201 with SMTP id ww9mr10724580igb.22.1350348848803;
 Mon, 15 Oct 2012 17:54:08 -0700 (PDT)
Received: by 10.50.186.135 with HTTP; Mon, 15 Oct 2012 17:54:08 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207793>

Hi, all

There is a minor update on "po/git.pot" in the following pull request,
so it time to update your works for the upcoming git 1.8.0.

commit 9306b5b9a33185e7867202718162d8a38d5627ab
Author: Jiang Xin <worldhello.net@gmail.com>
Date:   Tue Oct 16 08:39:10 2012 +0800

    l10n: Update git.pot (3 new, 6 removed messages)

    This po/git.pot update is generated from v1.8.0-rc2-4-g42e55.

    Signed-off-by: Jiang Xin <worldhello.net@gmail.com>


---------- Forwarded message ----------
=46rom: Jiang Xin <worldhello.net@gmail.com>
Date: 2012/10/16
Subject: Please pull git-l10n updates for git v1.8.0-rc2-4-g42e55
To: Junio C Hamano <gitster@pobox.com>, Tr=E1=BA=A7n Ng=E1=BB=8Dc Qu=C3=
=A2n
<vnwildman@gmail.com>, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclou=
ds@gmail.com>
=E6=8A=84=E9=80=81=EF=BC=9A Git List <git@vger.kernel.org>


Hi, Junio

The following changes since commit 42e55a5f5709642cb7a56ecad8b706341f0e=
b38a:

  Merge branch 'maint' (2012-10-13 23:05:54 -0700)

are available in the git repository at:


  git://github.com/git-l10n/git-po master

for you to fetch changes up to 9306b5b9a33185e7867202718162d8a38d5627ab=
:

  l10n: Update git.pot (3 new, 6 removed messages) (2012-10-16 08:39:10=
 +0800)

----------------------------------------------------------------
Jiang Xin (2):
      Merge branch 'master' of git://github.com/vnwildman/git
      l10n: Update git.pot (3 new, 6 removed messages)

Tran Ngoc Quan (1):
      l10n: vi.po: update translation upto cc76011

 po/git.pot |  852 +++++------
 po/vi.po   | 4934 ++++++++++++++++++++++++++++++++++++++++++++++++++--=
--------
 2 files changed, 4594 insertions(+), 1192 deletions(-)

--
Jiang Xin


--=20
=E8=92=8B=E9=91=AB

=E5=8C=97=E4=BA=AC=E7=BE=A4=E8=8B=B1=E6=B1=87=E4=BF=A1=E6=81=AF=E6=8A=80=
=E6=9C=AF=E6=9C=89=E9=99=90=E5=85=AC=E5=8F=B8
=E9=82=AE=E4=BB=B6: worldhello.net@gmail.com
=E7=BD=91=E5=9D=80: http://www.ossxp.com/
=E5=8D=9A=E5=AE=A2: http://www.worldhello.net/
=E5=BE=AE=E5=8D=9A: http://weibo.com/gotgit/
=E7=94=B5=E8=AF=9D: 010-51262007, 18601196889
