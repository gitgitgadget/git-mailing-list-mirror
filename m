From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 0/5] i18n: TRANSLATORS commends and LEGO--
Date: Mon, 30 Apr 2012 15:33:09 +0000
Message-ID: <1335799995-7667-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio Hamano <gitster@pobox.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 30 17:33:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SOsbP-00018o-UT
	for gcvg-git-2@plane.gmane.org; Mon, 30 Apr 2012 17:33:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753481Ab2D3PdX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Apr 2012 11:33:23 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:55592 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753049Ab2D3PdW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Apr 2012 11:33:22 -0400
Received: by bkcji2 with SMTP id ji2so383521bkc.19
        for <git@vger.kernel.org>; Mon, 30 Apr 2012 08:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=qBMLWM17K6/1nC96+6suyjeyhmVIRLX1u1dXWvvFG6U=;
        b=0QHBq9E7O7W3fDlyJRL1uKZKh0Fvrg54pJL+rbnVzvrV2O3xOML3UQlUzkQRz/ebXy
         mMRq5rxisaT2vGYJzQpx4eFAyOVGG2fxmdHwUTSmaJJY16pWFHYTY3pqW4I9VUHreEcJ
         /vj8RFtZ7WtL/vt3iO6ArcTufYFiJ0C95XVPDjYwvxsWnokeLOPy924DAUya1imng8Hx
         N3GPzDgKqmIsjQ/mx8JCFeWy2waIO5NFN9ecEojMQBa5RPvnF4y6yk1BMSSWPeXdTx2M
         UxwlJlCDaaXc2OvuxihmxJQrHzbxV/sTVebh/Os9ZfmLOHZmW/e29N9v8t3cAo89GzGJ
         /OmQ==
Received: by 10.204.128.152 with SMTP id k24mr6739611bks.127.1335800000998;
        Mon, 30 Apr 2012 08:33:20 -0700 (PDT)
Received: from w.nix.is (w.nix.is. [188.40.98.140])
        by mx.google.com with ESMTPS id jr13sm27636569bkb.14.2012.04.30.08.33.19
        (version=SSLv3 cipher=OTHER);
        Mon, 30 Apr 2012 08:33:19 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.546.gbaa1a.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196565>

This series fixes/adds some TRANSLATORS commends and removes lego from
some branch/commit messages.

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (5):
  diff: move TRANSLATORS comments so they're picked up
  i18n: Add more TRANSLATORS comments
  git-branch: remove lego in i18n messages
  git-commit: remove lego in i18n messages
  git-commit: remove lego in i18n messages

 advice.c         |    3 +++
 builtin/branch.c |   24 ++++++++++++--------
 builtin/commit.c |   66 ++++++++++++++++++++++++----------------------=
--------
 bundle.c         |    5 +++++
 commit.c         |    4 ++++
 connected.c      |    3 +++
 diff.c           |   17 +++++++-------
 remote.c         |   10 +++++++++
 sequencer.c      |   10 +++++++++
 9 files changed, 88 insertions(+), 54 deletions(-)

--=20
1.7.10.546.gbaa1a.dirty
