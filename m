From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v2 3/8] t/README: Typo: paralell -> parallel
Date: Thu,  1 Jul 2010 20:17:53 +0000
Message-ID: <1278015478-6920-4-git-send-email-avarab@gmail.com>
References: <1278015478-6920-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 01 22:18:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OUQDW-0003KV-4d
	for gcvg-git-2@lo.gmane.org; Thu, 01 Jul 2010 22:18:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755908Ab0GAUSe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 1 Jul 2010 16:18:34 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:43842 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755539Ab0GAUSd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Jul 2010 16:18:33 -0400
Received: by mail-ew0-f46.google.com with SMTP id 23so884033ewy.19
        for <git@vger.kernel.org>; Thu, 01 Jul 2010 13:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=N9dbb4KIO8PwiB28c0mpMqh996bHoYuEXXYF6q9JmKM=;
        b=bYBEPHFBPvVELMj70SKqDvWCHrn5ZSVk3kbdZkP6cwocMLFnbfOPd+f30b0fThgmDe
         4Os/8Uw2w3CMygk+yJjuAVp4XUkHB9Qx22016bxoJ/gp/Zz98K/jpAFnSATRFg5CRtFW
         F+ASFoXNX+qEu25vIJMXamETfpTfKLsnd+bHI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=tVW+ix2zrogE9PpMBJvlvWym+PjKeErMH8HdJRJMK9db4H9mGlQ998wWB+VjBPDCex
         0vE/HZlKuBvuO1jIF4dXmGFeJePPHuKL/MRHx4SytC6rBjEgh+uLhBIcErXWUxSTiRa+
         ZkauTwL46NwAbJJs3svvrLTJHNWMpIBmMs1Dc=
Received: by 10.213.20.66 with SMTP id e2mr3038807ebb.83.1278015512198;
        Thu, 01 Jul 2010 13:18:32 -0700 (PDT)
Received: from localhost.localdomain ([188.105.94.3])
        by mx.google.com with ESMTPS id v8sm261986eeh.14.2010.07.01.13.18.29
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 01 Jul 2010 13:18:30 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.251.g92a7
In-Reply-To: <1278015478-6920-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150073>

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 t/README |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/README b/t/README
index 3cdd744..1d0fd18 100644
--- a/t/README
+++ b/t/README
@@ -33,7 +33,7 @@ the tests.
     ok 3 - plain bare
=20
 Since the tests all output TAP (see http://testanything.org) they can
-be run with any TAP harness. Here's an example of paralell testing
+be run with any TAP harness. Here's an example of parallel testing
 powered by a recent version of prove(1):
=20
     $ prove --timer --jobs 15 ./t[0-9]*.sh
--=20
1.7.1.251.g92a7
