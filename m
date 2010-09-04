From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 63/63] po/en_GB.po: add British English Translation
Date: Sat,  4 Sep 2010 22:10:29 +0000
Message-ID: <1283638229-14199-10-git-send-email-avarab@gmail.com>
References: <1283638229-14199-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Sam Reed <sam@reedyboy.net>,
	=?UTF-8?q?Jan=20Kr=C3=BCger?= <jk@jk.gs>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 05 00:11:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Os0xS-0003a5-Si
	for gcvg-git-2@lo.gmane.org; Sun, 05 Sep 2010 00:11:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754108Ab0IDWLL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 4 Sep 2010 18:11:11 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:57357 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754096Ab0IDWLJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Sep 2010 18:11:09 -0400
Received: by mail-wy0-f174.google.com with SMTP id 22so1463766wyf.19
        for <git@vger.kernel.org>; Sat, 04 Sep 2010 15:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=KUi9WmfDof0UkN0WHkDkRvbGNPfh5Ogcu3cM7ALOFIg=;
        b=I84OXbseoq4tvnqVmgCEGmivLJhMsaHMxXhgpVylGRNPHp3YAO0oAFFn0TszJd6P9e
         sa4jPsWwZG/I7R6wOY5VSyZkxHxQkRVqU6nDMF1+TgXUwownm5c1+n77ofr5jvNcYzye
         oVbsNKa3hJmZABcPdoJnJBmS5IU1BbE3xcHcM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=WhSlXWkdE0oUfwiU97cwvzcHOEPXgy5TSnzDaLsDqJ4PQyDeJ/B937Zaz6F6KzEQQu
         4bF1U8wDxaVnEECrRWgD6H6/qznVIaNy4FZasjoZWBLD2hFffWG31wqazEJwu4mhVp7t
         u1tdeFZjxujrO9y584SGh7p9ROJGfBeSjAHuk=
Received: by 10.227.133.18 with SMTP id d18mr219121wbt.33.1283638268843;
        Sat, 04 Sep 2010 15:11:08 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id k15sm2261604wer.23.2010.09.04.15.11.07
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 04 Sep 2010 15:11:07 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.3.313.gcd15
In-Reply-To: <1283638229-14199-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155376>

=46rom: Sam Reed <sam@reedyboy.net>

Translate the three Git messages from US to British English. These all
had to do with z v.s. s differences.

Signed-off-by: Sam Reed <sam@reedyboy.net>
Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 po/en_GB.po |   22 ++++++++++++++++++++++
 1 files changed, 22 insertions(+), 0 deletions(-)
 create mode 100644 po/en_GB.po

diff --git a/po/en_GB.po b/po/en_GB.po
new file mode 100644
index 0000000..b1f3e34
--- /dev/null
+++ b/po/en_GB.po
@@ -0,0 +1,22 @@
+msgid ""
+msgstr ""
+"Project-Id-Version: Git\n"
+"PO-Revision-Date: 2010-09-02 19:09 +0000\n"
+"Language-Team: Git Mailing List <git@vger.kernel.org>\n"
+"Report-Msgid-Bugs-To: Git Mailing List <git@vger.kernel.org>\n"
+"Last-Translator: Sam Reed <sam@reedyboy.net>\n"
+"Language-Team: Git Mailing List <git@vger.kernel.org>\n"
+"Language: en-gb\n"
+"MIME-Version: 1.0\n"
+"Content-Type: text/plain; charset=3DUTF-8\n"
+"Content-Transfer-Encoding: 8bit\n"
+
+msgid "Reinitialized existing"
+msgstr "Reinitialised existing"
+
+msgid "Initialized empty"
+msgstr "Initialised empty"
+
+#, c-format
+msgid "unrecognized argument: %s"
+msgstr "unrecognised argument: %s"
--=20
1.7.2.3.313.gcd15
