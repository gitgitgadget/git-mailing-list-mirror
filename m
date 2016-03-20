From: larsxschneider@gmail.com
Subject: [PATCH v2 2/2] Documentation: use ASCII quotation marks in git-p4
Date: Sun, 20 Mar 2016 19:39:21 +0100
Message-ID: <1458499161-61642-3-git-send-email-larsxschneider@gmail.com>
References: <1458499161-61642-1-git-send-email-larsxschneider@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: sunshine@sunshineco.com, gitster@pobox.com,
	Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 20 19:39:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ahiGG-0005ic-Mp
	for gcvg-git-2@plane.gmane.org; Sun, 20 Mar 2016 19:39:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751877AbcCTSjb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 20 Mar 2016 14:39:31 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35006 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751654AbcCTSj1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Mar 2016 14:39:27 -0400
Received: by mail-wm0-f68.google.com with SMTP id r129so5408903wmr.2
        for <git@vger.kernel.org>; Sun, 20 Mar 2016 11:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ermQr5tALrA7s/efBWt8G8/+7/cQaCi+WN/rdjfbfSU=;
        b=n1QyFDpqWBIXoVVsLsAlL4/mVX07AKjOguuoeefzNr52zIYD9sGpor1nYVPLXGXm19
         y8qlTNi8hGutCyI0/gRxJBdpbVm3ZKmKMokVDKIi32WhHgfKnvldXT5nLGb03Q9nN2Cv
         TvIbhs+fG63EByosLEgY7q6vp+D2ws7u+1uSm7LJbLKeCFd4QxJwAY7EvlpWOAWtOFa7
         bSarUvRBq7pX3f1u0oX1B9GBfUHsavz5VeKVejz2NwCdquxBctuAr/2ve8kNJqSFaZS/
         u8ZecTRQjpRmx2fVW27Snvui8Ojjd8aofZUlCjBZeMnvfLcT9mUE95dJFeqLKE209vzT
         fJRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ermQr5tALrA7s/efBWt8G8/+7/cQaCi+WN/rdjfbfSU=;
        b=QxuKMXEySTgJ5i+vVt7i9FVhdHaowmOJKCXiTTpqcvl8HdnXtHv9YRV9XOOXhC0VMN
         mJK5o4PAb0XpIwLx0RLp8VqXhf5UoBWCGpSHD8qvqBjAETUJK8mH5RheqfDtLXzBzmhy
         ko+XbU7FYfEXx/xYsmxTxABVmCitoVzpa0850Ipld/4pqgouyfsw0I6vr1EfX7v3gqDo
         L1wDoQeAIs0i3sKxEzOkwpEnBIvSH7OWB3nS2kguRM9eSDYbmj1w120KZPZC+/q43gOP
         7iOwzMH7/8srO7GW3uFNIrJuL8E1XVe0DX92Bs8v5evlCRuAxeRZXtQ109gN94UAOhAu
         Xmlw==
X-Gm-Message-State: AD7BkJIgjs1oWstM5Ixl2VoqUpWPI0CdsABI2vk4S4gEP2IFD05pEra2TkjaZV4vn8y/vA==
X-Received: by 10.194.220.225 with SMTP id pz1mr3124530wjc.99.1458499165259;
        Sun, 20 Mar 2016 11:39:25 -0700 (PDT)
Received: from slxBook3.fritz.box (p5DDB416B.dip0.t-ipconnect.de. [93.219.65.107])
        by smtp.gmail.com with ESMTPSA id et11sm21829064wjc.30.2016.03.20.11.39.24
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 20 Mar 2016 11:39:24 -0700 (PDT)
X-Mailer: git-send-email 2.5.1
In-Reply-To: <1458499161-61642-1-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289376>

=46rom: Lars Schneider <larsxschneider@gmail.com>

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 Documentation/git-p4.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
index 6457634..8afb31d 100644
--- a/Documentation/git-p4.txt
+++ b/Documentation/git-p4.txt
@@ -515,7 +515,7 @@ git-p4.pathEncoding::
 	Git expects paths encoded as UTF-8. Use this config to tell git-p4
 	what encoding Perforce had used for the paths. This encoding is used
 	to transcode the paths to UTF-8. As an example, Perforce on Windows
-	often uses =E2=80=9Ccp1252=E2=80=9D to encode path names.
+	often uses "cp1252" to encode path names.
=20
 git-p4.largeFileSystem::
 	Specify the system that is used for large (binary) files. Please note
--=20
2.5.1
