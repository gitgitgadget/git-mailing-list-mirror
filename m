From: =?UTF-8?B?w5h5dmluZCBBLiBIb2xt?= <sunny@sunbase.org>
Subject: 10000 tests
Date: Sat, 20 Apr 2013 23:42:25 +0200
Message-ID: <CAA787rn3s4TbrpTPgQ46OR7jmMnBrLFJzJQKPRzuk6GTwndBfA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 20 23:42:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTfYR-0002Vu-DJ
	for gcvg-git-2@plane.gmane.org; Sat, 20 Apr 2013 23:42:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755414Ab3DTVm1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 20 Apr 2013 17:42:27 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:49931 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755390Ab3DTVm1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 20 Apr 2013 17:42:27 -0400
Received: by mail-lb0-f174.google.com with SMTP id s10so4681433lbi.19
        for <git@vger.kernel.org>; Sat, 20 Apr 2013 14:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:date:x-google-sender-auth:message-id
         :subject:from:to:content-type:content-transfer-encoding;
        bh=mDt44lK16b3cCIatdzl3NzqRUpU8IwekLXcyiWJNSy4=;
        b=KaCLUdJatcQ3xiSXNBg47/6zHnrD5TQn51Hu3b4ggbbEN79OZieCgalNkzN+VC6M0T
         7nS4kCu4YCojYXgiADo7otCJo3wt40T8cUW3gxT7ZkQ/xildqDI7d3PJHTyEyUnhGhws
         2RsQi21BEVkhJlruaFKZO179N2bhFkJHU0OGQ+tpBIqDr1OsUuKbTrO2YBMSJKpqtmLA
         Vk9JiXRfv2SoyBRVKeculX+mXALtxGGTanYhK+PlPtzwkrdhGjRAYl/MuPZEBlM5fBcn
         2lXF6jbIbora74+YKs4vZSaycV8JBY9F17kgtgVCSRSbRVt26rAN7RleEmeD/qmElZw+
         ILdA==
X-Received: by 10.112.134.135 with SMTP id pk7mr10426935lbb.54.1366494145697;
 Sat, 20 Apr 2013 14:42:25 -0700 (PDT)
Received: by 10.112.39.69 with HTTP; Sat, 20 Apr 2013 14:42:25 -0700 (PDT)
X-Google-Sender-Auth: uauHhvb-30eCoUxbrBgElZljZLg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221876>

So this showed up after running the test suite of current master at
v1.8.2.1-501-gd2949c7:

  fixed   0
  success 9838
  failed  0
  broken  83
  total   10000

Ten thousand tests is worth celebrating. Congratulations! :)

Regards,
=C3=98yvind
