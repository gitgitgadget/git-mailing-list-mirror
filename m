From: Ralf Thielow <ralf.thielow@googlemail.com>
Subject: [PATCH 0/5] l10n: de.po: improvements
Date: Fri,  4 May 2012 21:48:21 +0200
Message-ID: <1336160906-20708-1-git-send-email-ralf.thielow@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Ralf Thielow <ralf.thielow@googlemail.com>
To: trast@student.ethz.ch, jk@jk.gs, stimming@tuhh.de
X-From: git-owner@vger.kernel.org Fri May 04 21:48:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQOUk-00076o-TM
	for gcvg-git-2@plane.gmane.org; Fri, 04 May 2012 21:48:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759547Ab2EDTsq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 May 2012 15:48:46 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:62404 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754379Ab2EDTsp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 May 2012 15:48:45 -0400
Received: by werb10 with SMTP id b10so138033wer.19
        for <git@vger.kernel.org>; Fri, 04 May 2012 12:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=wIdiiFfnmXgHMyLf3r+LDtDsc24m5AWEJWUrjbt1yFs=;
        b=CsAkmNaqa/LTmDp9p/aDL9BnJu2guXF+ABFfGmR5oUG17cmzuv4eVtjmSc7mHJ21/J
         EDnAyU6JTf2u7ndMqCgWnReFAyfacO+XDOiR36d4/Pdl82SNbmF8MVgnFThTyCkiMvRn
         7XvTggzgnoljmLQppAAcN8BO7QBDRQmhHWu0bL2N8+WItJyPqkh9L7dgDiCL19jeStPC
         jRPVT7e7gRJ+xE5neAXddIvhVLGJkf4hnPRxku9/WlM2YbYvaErsYm+DzRxe3AVYnP77
         gPYWnYVbT7xYMR+GTzGC88IgB0SyL37eYJdBBesNDea6EETjUe6kBBjRFjEDPZ3bOagQ
         8jzw==
Received: by 10.216.134.155 with SMTP id s27mr1096597wei.80.1336160924360;
        Fri, 04 May 2012 12:48:44 -0700 (PDT)
Received: from localhost.localdomain (dslb-094-223-205-117.pools.arcor-ip.net. [94.223.205.117])
        by mx.google.com with ESMTPS id 6sm3408902wiz.1.2012.05.04.12.48.42
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 04 May 2012 12:48:43 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.72.g0dc6d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197064>

This series contains a list of patches with
improvements on the german translation.

Ralf Thielow (5):
  l10n: add new members to German translation team
  l10n: de.po: translate "track" as "folgen"
  l10n: de.po: translate "remote" as "extern"
  l10n: de.po: collection of improvements
  l10n: de.po: unify translation of "ahead" and "behind"

 po/TEAMS |    3 +
 po/de.po |  287 +++++++++++++++++++++++++++++++-----------------------=
--------
 2 Dateien ge=C3=A4ndert, 148 Zeilen hinzugef=C3=BCgt(+), 142 Zeilen en=
tfernt(-)

--=20
1.7.10.72.g0dc6d
