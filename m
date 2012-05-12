From: Jiang Xin <worldhello.net@gmail.com>
Subject: Please pull git-l10n maint branch with de, zh_CN l10n updates
Date: Sat, 12 May 2012 15:34:04 +0800
Message-ID: <CANYiYbEyZsiE7MWbJVQGYM_1vyi+y8MVCeGGf7G-_y9vMRdxYQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	Ralf Thielow <ralf.thielow@googlemail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 12 09:34:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ST6qG-0002bD-3a
	for gcvg-git-2@plane.gmane.org; Sat, 12 May 2012 09:34:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753369Ab2ELHeH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 12 May 2012 03:34:07 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:51863 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752724Ab2ELHeE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 12 May 2012 03:34:04 -0400
Received: by obbtb18 with SMTP id tb18so4342058obb.19
        for <git@vger.kernel.org>; Sat, 12 May 2012 00:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=gVFs5rq/ObaSo3RHP7/ASe8UM4jVE0e+ewpGgPvvj4w=;
        b=hOcapV67dQ4i6AAPK496wBV7uRthz3YnpPKY7uu2wiyRf3eBhGCtFERb+CA+iHux2H
         kqWIBv54EEHTJM32gIDXt88Ouf7gJrTSDxAkWBigjNxoOo1g0uGIV/n6TLio4TBAdBQc
         YAqNRRa/AyIJaemuDI9seOtHeV1MciE9599/2Nb7K9dguOHQIhIRf3+IU7BD+pw+IgxM
         a8NLiXoQNkzyf3VGILt4ijRPfinW+h/4j6KsDkVmZw3voPecd9M/jvK0KlT/wPe9Foqu
         Z3SKyqOiRQGoRlAXK9f4G7eH86soPyLKvCAtG31zB18WempzJiDgjx4Tuq9PW69repUz
         A7SA==
Received: by 10.50.190.197 with SMTP id gs5mr408521igc.37.1336808044398; Sat,
 12 May 2012 00:34:04 -0700 (PDT)
Received: by 10.50.134.102 with HTTP; Sat, 12 May 2012 00:34:04 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197714>

Hi Junio,

The following changes since commit 42325fb2e078377a3914bf1d80160f22cb1f=
78d6:

  Start preparing for 1.7.10.2 (2012-05-07 13:24:32 -0700)

are available in the git repository at:

  https://github.com/git-l10n/git-po/ maint

for you to fetch changes up to 2f64542f9c2f6082dd5aa7d8d13886cdc965d175=
:

  l10n: zh_CN.po: translate 1 new message (2012-05-12 14:56:06 +0800)

----------------------------------------------------------------
Jiang Xin (2):
      l10n: Update git.pot (1 new messages)
      l10n: zh_CN.po: translate 1 new message

Ralf Thielow (6):
      l10n: add new members to German translation team
      l10n: de.po: translate "track" as "beobachten"
      l10n: de.po: translate "remote" as "extern"
      l10n: de.po: collection of improvements
      l10n: de.po: unify translation of "ahead" and "behind"
      l10n: de.po: translate one new message

Thomas Rast (4):
      l10n: de.po: translate "bare" as "blo=DF"
      l10n: de.po: hopefully uncontroversial fixes
      l10n: de.po: translate "bad" as "ung=FCltig" ("invalid")
      l10n: de.po: collection of suggestions

 po/TEAMS    |    3 +
 po/de.po    |  666 ++++++++++++++++++++++++++++++---------------------=
--------
 po/git.pot  |  192 ++++++++---------
 po/zh_CN.po |  192 ++++++++---------
 4 files changed, 538 insertions(+), 515 deletions(-)

--=20
Jiang Xin
