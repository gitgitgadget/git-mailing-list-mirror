From: Jiang Xin <worldhello.net@gmail.com>
Subject: [GIT PULL] l10n updates for 2.2.0
Date: Sun, 16 Nov 2014 08:56:39 +0800
Message-ID: <CANYiYbFXMU2HrV8B6nfN38pD6pYsWb2q-0NgXj_yAYJCJ5YnsQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Ralf Thielow <ralf.thielow@googlemail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 16 01:56:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xpo98-0004S4-VF
	for gcvg-git-2@plane.gmane.org; Sun, 16 Nov 2014 01:56:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754816AbaKPA4n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Nov 2014 19:56:43 -0500
Received: from mail-wg0-f49.google.com ([74.125.82.49]:48671 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754768AbaKPA4m (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Nov 2014 19:56:42 -0500
Received: by mail-wg0-f49.google.com with SMTP id x13so22141489wgg.8
        for <git@vger.kernel.org>; Sat, 15 Nov 2014 16:56:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=VLqWX7m5ZqemtcMPausTQhsUsXNSrK47NVDj17mwh6E=;
        b=KCQpggIFcXMv7L/CodhlUz39zESbirFNS7jLIZY26WfPQfJkwTSegrgNlOsQO7tRiq
         6ULFrVsJcH7IgXGWEzvU4B3Xiu3u6eF9eRPk3PRI8bNKXzAhYjqW3Q3rk9IOgIz2YtPF
         FzKTJJMxpiCxYGB7R2caqG7WbJr90otl5PVXP026meTq7MtlZYcgNv8M/pjVIGWBqtk3
         IBlcb9gbLEwu++d6E3PbZevnNUttp3CoGpZpLwUHr4L3lMTvZ6u9jXA8Deer1mbNREr+
         6RR7oyPYhCjVbNUKt5RQBA/9rPkjUy4mzGsQu/B+ELyvGxjEjQYp+nnjLxrTYKTZpA1S
         5vgg==
X-Received: by 10.194.119.230 with SMTP id kx6mr20521585wjb.80.1416099400654;
 Sat, 15 Nov 2014 16:56:40 -0800 (PST)
Received: by 10.194.169.105 with HTTP; Sat, 15 Nov 2014 16:56:39 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

Translations for German is ready, please pull.

The following changes since commit 6c31a5e94af1036bb29da8a75f1e735e662aee92:

  l10n: Updated Bulgarian translation of git (2296t,0f,0u) (2014-11-02
19:11:08 +0200)

are available in the git repository at:

  git://github.com/git-l10n/git-po master

for you to fetch changes up to d544b2d495295142cb3418b13b5a106d415d2216:

  l10n: de.po: translate 62 new messages (2014-11-15 18:22:05 +0100)

----------------------------------------------------------------
Ralf Thielow (2):
      l10n: de.po: use imperative form for command options
      l10n: de.po: translate 62 new messages

Stefan Beller (1):
      l10n: de.po: Fixup one translation

 po/de.po | 4229 +++++++++++++++++++++++++++++++++-----------------------------
 1 file changed, 2239 insertions(+), 1990 deletions(-)
