From: Ralf Thielow <ralf.thielow@googlemail.com>
Subject: [PATCH 00/10] 'maint' updates of German translation
Date: Tue,  8 May 2012 19:33:35 +0200
Message-ID: <1336498425-17890-1-git-send-email-ralf.thielow@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: worldhello.net@gmail.com, git@vger.kernel.org,
	Ralf Thielow <ralf.thielow@googlemail.com>
To: trast@student.ethz.ch, jk@jk.gs, stimming@tuhh.de
X-From: git-owner@vger.kernel.org Tue May 08 19:35:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRoJR-0002G2-RY
	for gcvg-git-2@plane.gmane.org; Tue, 08 May 2012 19:35:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753086Ab2EHRe0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 May 2012 13:34:26 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:41121 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751765Ab2EHReZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2012 13:34:25 -0400
Received: by wibhn19 with SMTP id hn19so437464wib.1
        for <git@vger.kernel.org>; Tue, 08 May 2012 10:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=RVx2oYWb6yaFYXnaswqR77tbNX7pSMLc5xasT5UYG3U=;
        b=dFrPtih1/CjpLPH6F1fXWK2TTTJZB5x28GIjp6r5LPP7CB+yjlK44uJBn/R8kY3nsF
         nBq7zgF+e1cfZAwxkbhOB/T7ljkWBoNPUklTElc/TrlPRqEhTcHV+6B/38w4eQAdycZM
         Y5lGUhezqiyOIuy9LWic6Tz1rSRVJg5/GirQ+5LjGsdmVCp6REl8yM6N5hy/Ru9kKNZH
         pXL0kgCMrizJSBG7PmEw27UoI6ocW5MpqmgDgjBQ0TsfygYizNIuJPsG2UPOYfTo4mpo
         pVcgWb47evOPO/r930EP/o5cshd+hGmTcX8x1E2CiSPLVctrThG3DoubGZKI5Jsw4qcb
         2cNA==
Received: by 10.180.24.35 with SMTP id r3mr46603081wif.7.1336498462803;
        Tue, 08 May 2012 10:34:22 -0700 (PDT)
Received: from localhost.localdomain (dslb-094-223-205-117.pools.arcor-ip.net. [94.223.205.117])
        by mx.google.com with ESMTPS id ff2sm47784452wib.9.2012.05.08.10.34.20
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 08 May 2012 10:34:21 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.129.g1ec31a3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197408>

Hi German l10n team,

these are the updates for the German translation
of branch 'maint'. If you want to get something
changed before I'll send a pull request to git.po,
please let me know.

Thanks

Ralf Thielow (6):
  l10n: add new members to German translation team
  l10n: de.po: translate "track" as "beobachten"
  l10n: de.po: translate "remote" as "extern"
  l10n: de.po: collection of improvements
  l10n: de.po: unify translation of "ahead" and "behind"
  l10n: de.po: translate one new message

Thomas Rast (4):
  l10n: de.po: translate "bare" as "blo=C3=9F"
  l10n: de.po: hopefully uncontroversial fixes
  l10n: de.po: translate "bad" as "ung=C3=BCltig" ("invalid")
  l10n: de.po: collection of suggestions

 po/TEAMS |    3 +
 po/de.po |  666 ++++++++++++++++++++++++++++++++----------------------=
--------
 2 Dateien ge=C3=A4ndert, 342 Zeilen hinzugef=C3=BCgt(+), 327 Zeilen en=
tfernt(-)

--=20
1.7.10.129.g1ec31a3
