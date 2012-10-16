From: Jiang Xin <worldhello.net@gmail.com>
Subject: Please pull git-l10n updates for git v1.8.0-rc2-4-g42e55
Date: Tue, 16 Oct 2012 08:44:49 +0800
Message-ID: <CANYiYbHJM2+--6sf2ETLA-NdKmZ20MCGMFpDocxdsV8Y_k9asw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 16 02:45:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNvHJ-0000LK-Ax
	for gcvg-git-2@plane.gmane.org; Tue, 16 Oct 2012 02:45:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755260Ab2JPAou (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Oct 2012 20:44:50 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:59170 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750918Ab2JPAou (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2012 20:44:50 -0400
Received: by mail-ie0-f174.google.com with SMTP id k13so8901417iea.19
        for <git@vger.kernel.org>; Mon, 15 Oct 2012 17:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=kkGDc/AJRRYVhQPBoRAb2/klTzWUatgVpbPfiphc9zk=;
        b=VeaaPZUaNW8vGyAi8+aKKDfBMjILz37f9PkzXxMfTOd8khSWaNCE0PwKM0KRa+3ukm
         YLFHUFG26fC4zwZINxc+zvEHJlbgamXFO5LjmzB2duSUrbPYHU0jgFCQtOhIZxFqk+bd
         hLeKjB4knr9DwkJ3ISw8qgB0XMMGwQh2bfV622qkqeUZprZvFm/VQ0oAA8CPfqftvDdZ
         DQbzmyVDq483WyfGVGceugX69QkkGZRcop2FWd6JWkr6G5MUuC08PEHgsZ6KviuWcfJx
         xgBTrJ0qM+aljeiMzetDQNpZjcBwi1rsuJUC2wlGtyr+Xa7++B28/zUtT6C1EBBTTDbw
         wPBQ==
Received: by 10.50.161.232 with SMTP id xv8mr10716792igb.22.1350348289470;
 Mon, 15 Oct 2012 17:44:49 -0700 (PDT)
Received: by 10.50.186.135 with HTTP; Mon, 15 Oct 2012 17:44:49 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207792>

Hi, Junio

The following changes since commit 42e55a5f5709642cb7a56ecad8b706341f0eb38a:

  Merge branch 'maint' (2012-10-13 23:05:54 -0700)

are available in the git repository at:


  git://github.com/git-l10n/git-po master

for you to fetch changes up to 9306b5b9a33185e7867202718162d8a38d5627ab:

  l10n: Update git.pot (3 new, 6 removed messages) (2012-10-16 08:39:10 +0800)

----------------------------------------------------------------
Jiang Xin (2):
      Merge branch 'master' of git://github.com/vnwildman/git
      l10n: Update git.pot (3 new, 6 removed messages)

Tran Ngoc Quan (1):
      l10n: vi.po: update translation upto cc76011

 po/git.pot |  852 +++++------
 po/vi.po   | 4934 ++++++++++++++++++++++++++++++++++++++++++++++++++----------
 2 files changed, 4594 insertions(+), 1192 deletions(-)

-- 
Jiang Xin
