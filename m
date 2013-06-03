From: =?Big5?B?pEG7xL5Z?= <ch3cooli@gmail.com>
Subject: Typo in Documentation/RelNotes/1.8.4.txt
Date: Mon, 3 Jun 2013 09:36:41 +0800
Message-ID: <CAHtLG6SGF=D-_gz47qAfhvkZHPU3-Ucj-cM_aF8BhTsE1mo2sg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 03 03:37:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjJhj-0003TS-At
	for gcvg-git-2@plane.gmane.org; Mon, 03 Jun 2013 03:36:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755363Ab3FCBgn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Jun 2013 21:36:43 -0400
Received: from mail-vb0-f43.google.com ([209.85.212.43]:42002 "EHLO
	mail-vb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755276Ab3FCBgm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Jun 2013 21:36:42 -0400
Received: by mail-vb0-f43.google.com with SMTP id e15so735042vbg.16
        for <git@vger.kernel.org>; Sun, 02 Jun 2013 18:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=JSIsCLkSvbQwWX6BUQQNWSEJDyYTHEgsqS6L461eMdM=;
        b=kgFXEm9jQYvs7K/OXywWE9qyVc0L2HkuiN2Tslgj+wWFW8CQDG7vmMavBBmHaWXX+T
         J1hPMseYY0oqZpeNZywfbUBsG6xZsyKtSu75m+3tje7uUzZSRqmq6h9b9BSIP/ogWdIl
         2Krgzgs5K5LUcCQIFSFqL83/ZFeHqskahAUIaoa5WsIlg5hdBctB0ES7tweyTdnUJKZ5
         93/9X+51znsjtbynCfmVY03B6qKdRP+mOlNsAcXNm5u29suInBLWawb/yAX0QfAau2GZ
         mGGqtt3BlaxgOycqOnBW3Nb6xrts2F31EoRtBRY/Y7uKhFBSWuDDUFOFQoM+I6cGLPvL
         J98w==
X-Received: by 10.52.22.133 with SMTP id d5mr44115vdf.128.1370223401310; Sun,
 02 Jun 2013 18:36:41 -0700 (PDT)
Received: by 10.220.93.70 with HTTP; Sun, 2 Jun 2013 18:36:41 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226202>

Typo in Documentation/RelNotes/1.8.4.txt
line 39:
opportunisticly -> opportunistically
