From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v4 2/7] t/README: Typo: paralell -> parallel
Date: Fri,  2 Jul 2010 14:59:44 +0000
Message-ID: <1278082789-19872-3-git-send-email-avarab@gmail.com>
References: <1278082789-19872-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 02 17:00:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OUhjf-0004LD-6S
	for gcvg-git-2@lo.gmane.org; Fri, 02 Jul 2010 17:00:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758735Ab0GBPAo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 2 Jul 2010 11:00:44 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:48646 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755851Ab0GBPAm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Jul 2010 11:00:42 -0400
Received: by wwb24 with SMTP id 24so467999wwb.1
        for <git@vger.kernel.org>; Fri, 02 Jul 2010 08:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=AFZfb/tP2fs3HwRaJ23NwGX2Qf+6n5gI4D/QR6DuZAo=;
        b=iIKXpJ4N5ylXrP8bfHMI1amDodgm4X9HZxGEUBZFdrisShae94ch9/K3pnpSX+dxDX
         0uQUJbKJflOuPQpdzAvBE8/fMnZBsd7NQa61Xi8O15eQJZJcvL+maO00yNBqXIvWGyRZ
         fp0whX6+oYRb1tuHOJKcxo8ldaMVule2QDrBY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=l5C6ZflGYJDYdXMPLVjgw03hv5JEEdY8Pf47ZvM5xgy8QrFhWQ3HrE/UsrVEuWzhHp
         IVDR9IukB3/O8VCCa+I6pzAFqDnb+uX3UjgaNxtic/Feqw0udJszbSAceW9N/dEDt9Lz
         gtGrIF8+Y9b03DBsaINjAm897IfN85B5CuGNs=
Received: by 10.213.27.68 with SMTP id h4mr824552ebc.4.1278082841205;
        Fri, 02 Jul 2010 08:00:41 -0700 (PDT)
Received: from localhost.localdomain ([188.105.94.3])
        by mx.google.com with ESMTPS id a48sm6206858eei.19.2010.07.02.08.00.34
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 02 Jul 2010 08:00:39 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.251.g92a7
In-Reply-To: <1278082789-19872-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150131>

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 t/README |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/README b/t/README
index cad6fde..a7312fa 100644
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
