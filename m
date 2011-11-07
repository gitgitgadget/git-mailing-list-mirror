From: Peng Yu <pengyu.ut@gmail.com>
Subject: Is there a pdf git manual?
Date: Mon, 7 Nov 2011 11:24:14 -0600
Message-ID: <CABrM6wkzV58WLnHkZ88y=MQVWjD8dwYMtG9HTto8t8QXBEW-hA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 07 18:24:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNSvm-0008NB-Aw
	for gcvg-git-2@lo.gmane.org; Mon, 07 Nov 2011 18:24:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932981Ab1KGRYR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Nov 2011 12:24:17 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:40712 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932759Ab1KGRYP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Nov 2011 12:24:15 -0500
Received: by gyc15 with SMTP id 15so4394475gyc.19
        for <git@vger.kernel.org>; Mon, 07 Nov 2011 09:24:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=EEOyWQgNzBD8HhJwV5hWQeVatMEWNWhYXL9lFusJUpE=;
        b=tposNaoMYnyWPM/CyFT0gWyzzfDT0vFIduhh93HVMa0mf1GA+Jj+/waN+207tjS9K4
         8Vn7FKvZ6sDC+6TTb/BqoOvIDzs3rkTnMBdE+aqE08dlttRON38j748CCF+BgPVEM3JO
         WRygIr5IjpwXtQ4DsAMwMfQZPDCbHww5cZCE8=
Received: by 10.236.180.200 with SMTP id j48mr5015769yhm.26.1320686654741;
 Mon, 07 Nov 2011 09:24:14 -0800 (PST)
Received: by 10.236.103.8 with HTTP; Mon, 7 Nov 2011 09:24:14 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185003>

Hi,

http://schacon.github.com/git/user-manual.html

The manual is in html. I'm not able to find a pdf version. Running
make in git/Documentation doesn't generate a pdf document
automatically. Could anybody generated the pdf document and post it to
the git project website? Thanks!

-- 
Regards,
Peng
