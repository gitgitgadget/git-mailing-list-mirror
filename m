From: Ralf Thielow <ralf.thielow@googlemail.com>
Subject: [PATCH 0/3] sync German translation of git-gui with git-core
Date: Tue, 19 Jun 2012 20:25:38 +0200
Message-ID: <1340130341-5224-1-git-send-email-ralf.thielow@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: trast@student.ethz.ch, jk@jk.gs, git@vger.kernel.org,
	Ralf Thielow <ralf.thielow@googlemail.com>
To: patthoyts@users.sourceforge.net, stimming@tuhh.de
X-From: git-owner@vger.kernel.org Tue Jun 19 20:25:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sh37m-00062a-9j
	for gcvg-git-2@plane.gmane.org; Tue, 19 Jun 2012 20:25:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753080Ab2FSSZy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 19 Jun 2012 14:25:54 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:50853 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752802Ab2FSSZx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jun 2012 14:25:53 -0400
Received: by bkcji2 with SMTP id ji2so5415542bkc.19
        for <git@vger.kernel.org>; Tue, 19 Jun 2012 11:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=ijUFO28bnrr/h3zjUb4Kvvzr4io+vuR3FabtxHPVnek=;
        b=fBrK0sS5ZEPoUpPTf7mYPjaqpOJk+/4ASHmygfS5wOVz1GwGgkKc4dUD8k2xIyVL0m
         jbNg8/9Ra3PY222duhXjtHPvQj3w1TsxV3B6xo6ZiMgiEiMG2thjJFos7YCMpCw+NyxL
         vtjt7Um3j2PDd0ahtX7+HQGHsKyXAEtepBhfoY/pKbNrlWNr1KmVll5CMzX5/+exjmmW
         ukPG58tCJxlRUM6pToAKQDcvoEeq/fi2E/+SkCujKbW7T1NAL6eeVAEd6R1Wn4VFFnr7
         qbziBrcp/i7wCUZQxbLUMWndPCNQ5+LmMPuHCKpFTfynfBqebs0tmns2uS6KwhIePhUy
         3Z4g==
Received: by 10.204.154.138 with SMTP id o10mr6633051bkw.34.1340130352025;
        Tue, 19 Jun 2012 11:25:52 -0700 (PDT)
Received: from localhost.localdomain (dslb-094-223-205-117.pools.arcor-ip.net. [94.223.205.117])
        by mx.google.com with ESMTPS id e20sm24459087bkw.3.2012.06.19.11.25.51
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 19 Jun 2012 11:25:51 -0700 (PDT)
X-Mailer: git-send-email 1.7.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200219>

We should keep the translation of the tools in sync with
git-core. So this patch series sync the German translation
of git-gui with the git-core one.

Ralf Thielow (3):
  git-gui: de.po: consistently add untranslated hook names within
    braces
  git-gui: de.po: translate "bare" as "blo=C3=9F"
  git-gui: de.po: translate "remote" as "extern"

 po/de.po | 36 ++++++++++++++++++------------------
 1 Datei ge=C3=A4ndert, 18 Zeilen hinzugef=C3=BCgt(+), 18 Zeilen entfer=
nt(-)

--=20
1.7.11
