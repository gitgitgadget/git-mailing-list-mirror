From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: [PATCH v2] l10n: de.po: add space to abbreviation "z. B."
Date: Wed,  2 Mar 2016 18:48:48 +0100
Message-ID: <1456940928-8233-1-git-send-email-ralf.thielow@gmail.com>
References: <1456939802-6171-1-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tr@thomasrast.ch, jk@jk.gs, stimming@tuhh.de,
	phillip.szelat@gmail.com, matthias.ruester@gmail.com,
	magnus.goerlitz@googlemail.com,
	Ralf Thielow <ralf.thielow@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 02 18:49:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1abAtM-0004FW-Le
	for gcvg-git-2@plane.gmane.org; Wed, 02 Mar 2016 18:48:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755282AbcCBRsx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Mar 2016 12:48:53 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33272 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755026AbcCBRsw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Mar 2016 12:48:52 -0500
Received: by mail-wm0-f67.google.com with SMTP id n186so10919768wmn.0
        for <git@vger.kernel.org>; Wed, 02 Mar 2016 09:48:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C38IULRClsjaDa/Y6iX8nmH36EqfAOaqwPLnbJ5Njbo=;
        b=dASwbM7NbtE5XWgXkEbtzmuGH2ZvVIYqKIRdgy0sHQCBdWcfQwN4++Tk2asWCxbqQH
         3MztXGp18kSAlyNDTmQjJOnZR4QlqGmT2AeR8SUV5AttQhRMez2xUm9+ykdtQRZT4/il
         K+HFHMSy3lNmSvlLQQ/ua9R6IBidP94/ksOuIQYGAxHoqZYJcGpiU8QP2smhK2EfM7P5
         jgEvG0VDrbV0xlLWoLlGYq//pU8qU+YrqR/EcWHjwHwMpByigHTal5YkcCUHRg1MpvZO
         /3XzX463D1E3aB9af4F6EObA20LG7UBt5UxfXyaFulFiUXsEd3/7hvgMyT1Xhxs6Vo+Z
         ZwuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C38IULRClsjaDa/Y6iX8nmH36EqfAOaqwPLnbJ5Njbo=;
        b=Ne9WAxVUd9ADoOS9WquEY+iKhODdWxjzrz89SlFtqP4uJcgCCwPXZwbB5lRgeoS4gD
         F61aZ6nPrvBNzWI7cTfxZD3qyGAwR0uAtbl5UTR5Qs4Jb+2WSsFVtMidqfQW163UpWXO
         4oHCnZgEB34X1RPZL1EQnZxsbFMkn0GVFEvIueYMNnJJDOvEQR+XHEdiRQF2/0eRB3+b
         KZ9HoSMq0eMG1M6X3KcdxsuzHxAG9kHa8T3WX6Tao7CXQUtMGPC3ndZo4Etuw+FNKIL3
         M75cr9DzdWgu4pWFS3QSjCtudJYaLLNY+azw+JqFzlY6TzJRQBUbze57lmByOI4ZoIQy
         Z1BA==
X-Gm-Message-State: AD7BkJJO7oYH4SwnAGAyxAIGNWRHL8Zh8ab0M0wrW/bBDEySzPkKeQFTDmnNi12HJF34tA==
X-Received: by 10.194.90.77 with SMTP id bu13mr26788197wjb.60.1456940931220;
        Wed, 02 Mar 2016 09:48:51 -0800 (PST)
Received: from localhost (cable-94-139-5-136.cust.telecolumbus.net. [94.139.5.136])
        by smtp.gmail.com with ESMTPSA id n9sm36735375wjy.36.2016.03.02.09.48.49
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 02 Mar 2016 09:48:49 -0800 (PST)
X-Mailer: git-send-email 2.8.0.rc0.140.gf92f5fe
In-Reply-To: <1456939802-6171-1-git-send-email-ralf.thielow@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288138>

Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---
 po/de.po | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/po/de.po b/po/de.po
index a6b7bf3..9344a53 100644
--- a/po/de.po
+++ b/po/de.po
@@ -9145,7 +9145,7 @@ msgid ""
 msgstr ""
 "Aktualisierungen wurden zur=C3=BCckgewiesen, weil die Spitze Ihres ak=
tuellen\n"
 "Branches hinter seinem externen Gegenst=C3=BCck zur=C3=BCckgefallen i=
st. F=C3=BChren Sie\n"
-"die externen =C3=84nderungen zusammen (z.B. 'git pull ...') bevor Sie=
 \"push\"\n"
+"die externen =C3=84nderungen zusammen (z. B. 'git pull ...') bevor Si=
e \"push\"\n"
 "erneut ausf=C3=BChren.\n"
 "Siehe auch die Sektion 'Note about fast-forwards' in 'git push --help=
'\n"
 "f=C3=BCr weitere Details."
@@ -9160,7 +9160,7 @@ msgstr ""
 "Aktualisierungen wurden zur=C3=BCckgewiesen, weil die Spitze eines ve=
rsendeten\n"
 "Branches hinter seinem externen Gegenst=C3=BCck zur=C3=BCckgefallen i=
st. Checken Sie\n"
 "diesen Branch aus und f=C3=BChren Sie die externen =C3=84nderungen zu=
sammen\n"
-"(z.B. 'git pull ...') bevor Sie erneut \"push\" ausf=C3=BChren.\n"
+"(z. B. 'git pull ...') bevor Sie erneut \"push\" ausf=C3=BChren.\n"
 "Siehe auch die Sektion 'Note about fast-forwards' in 'git push --help=
'\n"
 "f=C3=BCr weitere Details."
=20
@@ -9177,7 +9177,7 @@ msgstr ""
 "die lokal nicht vorhanden sind. Das wird =C3=BCblicherweise durch ein=
en \"push\" "
 "von\n"
 "Commits auf dieselbe Referenz von einem anderen Repository aus verurs=
acht.\n"
-"Vielleicht m=C3=BCssen Sie die externen =C3=84nderungen zusammenzuf=C3=
=BChren (z.B. 'git "
+"Vielleicht m=C3=BCssen Sie die externen =C3=84nderungen zusammenf=C3=BC=
hren (z. B. 'git "
 "pull ...')\n"
 "bevor Sie erneut \"push\" ausf=C3=BChren.\n"
 "Siehe auch die Sektion 'Note about fast-forwards' in 'git push --help=
'\n"
--=20
2.8.0.rc0.140.gf92f5fe
