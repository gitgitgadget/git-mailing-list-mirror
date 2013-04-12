From: =?UTF-8?q?Beno=C3=AEt=20Bourbi=C3=A9?= <benoit.bourbie@gmail.com>
Subject: [PATCH] Fixing typos
Date: Fri, 12 Apr 2013 00:05:40 -0500
Message-ID: <1365743141-2513-1-git-send-email-benoit.bourbie@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Beno=C3=AEt=20Bourbi=C3=A9?= <benoit.bourbie@gmail.com>,
	git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Apr 12 07:06:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQWBm-000218-97
	for gcvg-git-2@plane.gmane.org; Fri, 12 Apr 2013 07:06:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752207Ab3DLFGO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 12 Apr 2013 01:06:14 -0400
Received: from mail-oa0-f43.google.com ([209.85.219.43]:55390 "EHLO
	mail-oa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750817Ab3DLFGN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Apr 2013 01:06:13 -0400
Received: by mail-oa0-f43.google.com with SMTP id l10so2190887oag.2
        for <git@vger.kernel.org>; Thu, 11 Apr 2013 22:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=sz09tLq36VfKSStdB6t5y1uimtPGRWsAUOcWXkc3Vk4=;
        b=mzk6ZsHdJG7GBtv6Aboev0/Wud4XrtJxkhJ6ez4CynVIVKogHM/s86qQelbMK3IMMy
         IZzWbYCatXhU5H0jiQRLyr8uZAJwAmD0VGlwwJ41jMvmAgjg5b0AtnBMDIy7etOfmWzM
         H3m+EEiAkYOQNTuZeR0Z51kKEYlnGI2zEZPx/jFHwFpWib+sHofXmrgOSiFreDXq76uL
         jQ4vjFGjA2REVgQ2WA83+2dEA496BscT8x7WaKBoLw+RtP3q91xu1EhwT/DJiTYvfKg3
         +n/PypsyxAYTdPU1ipxs2g0JyWYvO/dNNPSa2f4NfAeGakaAJfWpoRMzMKWlrIo360AA
         YoXw==
X-Received: by 10.182.39.201 with SMTP id r9mr161921obk.16.1365743173036;
        Thu, 11 Apr 2013 22:06:13 -0700 (PDT)
Received: from localhost.localdomain (c-98-201-171-34.hsd1.tx.comcast.net. [98.201.171.34])
        by mx.google.com with ESMTPS id x10sm1495193oes.6.2013.04.11.22.06.11
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 11 Apr 2013 22:06:12 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.470.g21ccebe.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220953>

Very basic documentation typo fixes.=20

Beno=C3=AEt Bourbi=C3=A9 (1):
  Typo fix: replacing it's -> its

 INSTALL               | 2 +-
 perl/private-Error.pm | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

--=20
1.8.2.470.g21ccebe.dirty
