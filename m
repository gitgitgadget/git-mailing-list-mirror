From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: Please pull git-l10n maint branch with de, zh_CN l10n updates
Date: Sat, 12 May 2012 15:45:05 +0800
Message-ID: <CANYiYbETtF6SYMVJM0H+XNsB3E+KTLd8dgJM6vWHoS1E+V4YRw@mail.gmail.com>
References: <CANYiYbEyZsiE7MWbJVQGYM_1vyi+y8MVCeGGf7G-_y9vMRdxYQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	Ralf Thielow <ralf.thielow@googlemail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 12 09:45:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ST70s-0008LT-6C
	for gcvg-git-2@plane.gmane.org; Sat, 12 May 2012 09:45:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753392Ab2ELHpH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 12 May 2012 03:45:07 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:44897 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751556Ab2ELHpG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 12 May 2012 03:45:06 -0400
Received: by obbtb18 with SMTP id tb18so4351922obb.19
        for <git@vger.kernel.org>; Sat, 12 May 2012 00:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=HGzQ8FglMDxukxZwBOY/MJhP4PANvMZoPj8c1F8QQnI=;
        b=Bkzn9eEjSkQnEwuO8imUjO6SdSFC1uNQNqVG2mtYqn3qxGUpRq3j9yO1kiKPjKBska
         bnqY1cPP0H/HXW41ecpfYciTlsu85xQcL77+TqMALppHskDNML9n+VUeEYp5BPpVLd4q
         08mSP/SZYnfYtyKe42gpPQjrXNkhRKNDUaA9MDU9A2Sx++AZ1vSw71qRV7Bl8VYutsmA
         Yyjb8/O6mfNMkhZOpkwEVuC+O8DwSocFdle4EEPTFyVL5/EFwCK/rlPMEb/MLcvWqzzC
         9c+0TzH9LiQxUIm5zzaHM7sImnTa/+jO6ezg7TeMM8B7UnW3kUTSVXpzhha4c1bBqj4t
         C8Ng==
Received: by 10.50.155.132 with SMTP id vw4mr429660igb.27.1336808705484; Sat,
 12 May 2012 00:45:05 -0700 (PDT)
Received: by 10.50.134.102 with HTTP; Sat, 12 May 2012 00:45:05 -0700 (PDT)
In-Reply-To: <CANYiYbEyZsiE7MWbJVQGYM_1vyi+y8MVCeGGf7G-_y9vMRdxYQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197715>

Hi, Junio

Please also pull the master branch which contains merge from
'maint' branch with fixes of non-trivial conflicts.

The following changes since commit a3935e6791c619a9f2f472e9e553d45d88c4=
e263:

  The ninth batch of topics graduated to 'master' (2012-05-07 13:39:38 =
-0700)

are available in the git repository at:

  https://github.com/git-l10n/git-po/ master

for you to fetch changes up to b652ada42a76548569a0dc9c9cf356343f9e1c3a=
:

  Merge branch 'maint' (2012-05-12 15:01:22 +0800)

----------------------------------------------------------------

Jiang Xin (5):
      l10n: Update git.pot (1 new messages)
      Merge branch 'maint'
      l10n: Update git.pot (275 new, 15 removed messages)
      l10n: zh_CN.po: translate 1 new message
      Merge branch 'maint'

Ralf Thielow (7):
      l10n: add new members to German translation team
      l10n: de.po: translate "track" as "beobachten"
      l10n: de.po: translate "remote" as "extern"
      l10n: de.po: collection of improvements
      l10n: de.po: unify translation of "ahead" and "behind"
      l10n: de.po: translate one new message
      Merge branch 'maint' into master

Thomas Rast (4):
      l10n: de.po: translate "bare" as "blo=DF"
      l10n: de.po: hopefully uncontroversial fixes
      l10n: de.po: translate "bad" as "ung=FCltig" ("invalid")
      l10n: de.po: collection of suggestions

 po/TEAMS   |    3 +
 po/de.po   |  487 ++++----
 po/git.pot | 3715 ++++++++++++++++++++++++++++++++++++++++------------=
--------
 3 files changed, 2760 insertions(+), 1445 deletions(-)

--=20
Jiang Xin
