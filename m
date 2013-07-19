From: Yamada Saburo <devil.tamachan@gmail.com>
Subject: [PATCH v2 0/3] git-gui translation update
Date: Fri, 19 Jul 2013 21:29:52 +0900
Message-ID: <CAPM==HKcPB80TH+VkFzkjCRUU+bhfZHGKTzcXBbs_KXsXXrQPQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 19 14:30:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V09or-0004uZ-VL
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jul 2013 14:29:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760099Ab3GSM3y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jul 2013 08:29:54 -0400
Received: from mail-vb0-f50.google.com ([209.85.212.50]:49973 "EHLO
	mail-vb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759992Ab3GSM3x (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jul 2013 08:29:53 -0400
Received: by mail-vb0-f50.google.com with SMTP id w16so3130206vbb.37
        for <git@vger.kernel.org>; Fri, 19 Jul 2013 05:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=q6FPxszBENTwCIcvSmJndE8kg6nc7GvVhqzMLPM230Q=;
        b=kNTLKHYZXjqll9cDmA6KJRr6JwbiCS+CrsfLP4rw1N9OsxQLCNoLJrlLykFq0IGuvZ
         3sXCQXtzn5UqHpd6HIfyaMHscS2AdNm5sSmlmvTuoSKXqFuYFcOzBc6nQVUda6x2RGjE
         FiUdOw84wePTvNEQB0QU5Al2d/n8VkA/TQez8+7pdwPkDwD6/metUyQ+iKAzyvGCWRCi
         rEnVWFL/UkfEkFvEaEcBphoQSTi1zU4h59UasNr8cqwnYSoTdstlAxSf2ZVgqQZfbxyR
         qUhT15JGQNsTWxW6Sx+f48mX11wS56oJk6N7ewDtYY2z/SzrML3xxf/JmAxenlLmOSKY
         aDNg==
X-Received: by 10.58.34.69 with SMTP id x5mr5684855vei.11.1374236992801; Fri,
 19 Jul 2013 05:29:52 -0700 (PDT)
Received: by 10.221.24.7 with HTTP; Fri, 19 Jul 2013 05:29:52 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230795>

 lib/option.tcl |    2 +-
 po/git-gui.pot | 1056 +++++++++++++++++++++++++++------------------------
 po/ja.po       | 1143 ++++++++++++++++++++++++++++++--------------------------
 3 files changed, 1195 insertions(+), 1006 deletions(-)
