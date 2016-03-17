From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: [PATCH] l10n: de.po: add missing newlines
Date: Thu, 17 Mar 2016 19:39:09 +0100
Message-ID: <1458239949-6767-1-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tr@thomasrast.ch, jk@jk.gs, stimming@tuhh.de,
	phillip.szelat@gmail.com, matthias.ruester@gmail.com,
	magnus.goerlitz@googlemail.com, worldhello.net@gmail.com,
	Ralf Thielow <ralf.thielow@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 17 19:39:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agcpK-00010Y-C5
	for gcvg-git-2@plane.gmane.org; Thu, 17 Mar 2016 19:39:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030351AbcCQSjP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Mar 2016 14:39:15 -0400
Received: from mail-wm0-f51.google.com ([74.125.82.51]:38008 "EHLO
	mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932508AbcCQSjN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Mar 2016 14:39:13 -0400
Received: by mail-wm0-f51.google.com with SMTP id l68so6551536wml.1
        for <git@vger.kernel.org>; Thu, 17 Mar 2016 11:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+2ZeboedYWqUh5exoLLxoE9FA82rFIwugDlM10aWS7c=;
        b=P+BIQIqh6Xg+I+xMfEr+f3dNS3d7fjIRxUBIAg5D4B+XLq8Z0h4W9KV0Zcj6W4qeXr
         omLYVVNkjpJfq6zhKvQqQxfV7H2AM1OU3cFslvRNR7mDUnNsYHyrKHSZ7gBG1nHTaXN0
         FsaTYkf7gvRg7DPX8AXKipeyvKZn7kH89UYgH5Xyu5P0tU8gbK0iYJyIUnjMUW2MJGNE
         /Hkcu+07phREHRZh/4dLnuFkLOr762SXyTy84Z6aUpOtuLlUpIwn54/VyaRsemvYTDnG
         hAPYZkXcgIGzMkcajN7nyacGUrLue1v1OTXhETG7Up7claUHFC9/Erm5DUcl/zYkMnRX
         O4Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+2ZeboedYWqUh5exoLLxoE9FA82rFIwugDlM10aWS7c=;
        b=gkOutJIAVd9DdFyRkVggAkWOJ1Wag17lGH5TWdQzDfl9hopw3PUfBCzETemwJYS5Ji
         b/QJVPjp1nI/bQvylRinakhdaBTrfFgWCAd6UGO8aP6BkAKALAg8bO67goeWi7ztyA6E
         c4KuVNnXn1TIqjK4TuItFngxlWZeIaNQRZ+u0ci6uYpE3zED96y9kr54xEXCLrRqFu+z
         r3FwLVj9QvXJPnCJyxNxYZsEdvxk3ND0DRLY17JPaRVtuuvwvGQqNxrFin3wkw6bYj5h
         vcSxDqWVB9bwAKNwtzpv7aleIH8wdSPotgY82bs+b42r4FY11CYj5DQdPBkCIMNgN+VX
         7IPg==
X-Gm-Message-State: AD7BkJKOyDdYNjyfA8cNhwAQZ4TgY2OwWdnR8MHL5IGz6w+smoB5Qtyr1KwuKJexFcJKRg==
X-Received: by 10.28.218.145 with SMTP id r139mr40302895wmg.52.1458239952012;
        Thu, 17 Mar 2016 11:39:12 -0700 (PDT)
Received: from localhost (cable-82-119-9-251.cust.telecolumbus.net. [82.119.9.251])
        by smtp.gmail.com with ESMTPSA id gb9sm8858949wjb.26.2016.03.17.11.39.11
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 17 Mar 2016 11:39:11 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.rc2.181.g7f8255e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289140>

Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---
This hotfix is already part of the pull request I sent
to git-po repository.

 po/de.po | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/po/de.po b/po/de.po
index 7093139..0eadf34 100644
--- a/po/de.po
+++ b/po/de.po
@@ -151,12 +151,13 @@ msgid ""
 "the remote tracking information by invoking\n"
 "\"git branch --set-upstream-to=3D%s%s%s\"."
 msgstr ""
 "\n"
 "Nachdem Sie die Fehlerursache behoben haben, k=C3=B6nnen Sie\n"
-"die Tracking-Informationen mit\"git branch --set-upstream-to=3D%s%s%s=
\"erneut "
-"setzen."
+"die Tracking-Informationen mit\n"
+"\"git branch --set-upstream-to=3D%s%s%s\"\n"
+"erneut setzen."
=20
 #: branch.c:67
 #, c-format
 msgid "Not setting branch %s as its own upstream."
 msgstr "Branch %s kann nicht sein eigener Upstream-Branch sein."
--=20
2.8.0.rc2.181.g7f8255e
