From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [git-po] [fr] first commits for French localization (#62)
Date: Mon, 12 Aug 2013 15:30:27 +0800
Message-ID: <CANYiYbHZi0RPmgzvkQh1h1TAr4YT5a6GSdf9m=7oMdJMiKXvFQ@mail.gmail.com>
References: <git-l10n/git-po/pull/62@github.com>
	<CANYiYbFz2kQj512SiOTTc4atdH5Na70grSgRhSBfTNgXdiqgAQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>,
	Jean-Noel Avila <jn.avila@free.fr>
X-From: git-owner@vger.kernel.org Mon Aug 12 09:30:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V8maG-0004rj-Ki
	for gcvg-git-2@plane.gmane.org; Mon, 12 Aug 2013 09:30:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753987Ab3HLHa3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Aug 2013 03:30:29 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:57371 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753624Ab3HLHa2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Aug 2013 03:30:28 -0400
Received: by mail-wi0-f178.google.com with SMTP id j17so1384388wiw.11
        for <git@vger.kernel.org>; Mon, 12 Aug 2013 00:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=pz+a/S14LkQeeoGt5goDjoSfYVeMj3C/qsL+otStgwk=;
        b=D5ipVU9CogHL5hFKSLn3/c7eYMLuAYeDrAhKcXjQMeTrXYwNf3v+iwU9Xd2NAe/HCz
         UvGjy+zlnPkFPmf8HL+KlV6n1nP5WRDhSoGGtcWS03XwrO0/5R9Hr0BJhRLlx65+mOuK
         bW+6Ob0JBbmRNleLNPwLGXh7WOvQQR5lE3oc3RSI3UllkWFavOrPRK23qZtZfQUsTyDh
         haxVENckq92Bd3RCjiBd3HTaSd95cXSF4qs3+ZOWAVA61igXKCBn4tx5D+oIuC03Vo8E
         OH8xn9xKHJzb6f3/IPefhF3EHsCi2dnJgnAn4z377iYWDvmPio58P2CFSofKId3ykPnW
         BLUw==
X-Received: by 10.180.188.202 with SMTP id gc10mr5746234wic.3.1376292627127;
 Mon, 12 Aug 2013 00:30:27 -0700 (PDT)
Received: by 10.194.104.201 with HTTP; Mon, 12 Aug 2013 00:30:27 -0700 (PDT)
In-Reply-To: <CANYiYbFz2kQj512SiOTTc4atdH5Na70grSgRhSBfTNgXdiqgAQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232165>

Hi, Junio

Haven't seen new languages support for git l10n for over 1 year.
Here comes French translation.

Please pull the following updates from Jean-Noel Avila.

The following changes since commit 96cb27a9d2db3c01b8e296a0fbc1da1da09d1412:

  Merge branch 'maint' (2013-08-09 15:49:55 -0700)

are available in the git repository at:


  git://github.com/git-l10n/git-po master

for you to fetch changes up to 1b5f46f15917fc938c219732fe5ec6a45748f1f7:

  l10n: Add reference for french translation team (2013-08-11 17:14:58 +0200)

----------------------------------------------------------------
Jean-Noel Avila (2):
      l10n: fr.po: 821/2112 messages translated
      l10n: Add reference for french translation team

 po/TEAMS |    4 +
 po/fr.po | 9668 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 9672 insertions(+)
 create mode 100644 po/fr.po

--
Jiang Xin
