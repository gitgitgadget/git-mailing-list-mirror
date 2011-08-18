From: Ori Avtalion <ori@avtalion.name>
Subject: Missing item in 1.7.7 release notes
Date: Fri, 19 Aug 2011 01:32:26 +0300
Message-ID: <CALgdb5K5iWbqudT_4Euw8yxCmxOz6JVVhFUG=kywjDSTGbx4XA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 19 00:32:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QuB8a-0006dX-RF
	for gcvg-git-2@lo.gmane.org; Fri, 19 Aug 2011 00:32:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754975Ab1HRWc2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Aug 2011 18:32:28 -0400
Received: from mail-iy0-f170.google.com ([209.85.210.170]:57604 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754435Ab1HRWc1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Aug 2011 18:32:27 -0400
Received: by iye16 with SMTP id 16so4743298iye.1
        for <git@vger.kernel.org>; Thu, 18 Aug 2011 15:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:date:x-google-sender-auth:message-id:subject
         :from:to:content-type;
        bh=cQrXDzsq9MBxelj7Ocdewvisu7+xQXfHaZw/4ulkn+o=;
        b=YJLjkuvPGmzf5i0YpDgaNQ3aZPjazaXo4ITgfKm5/hCgcUVBVSvGx9YghJovMZ5PPL
         IkfN42/8y8honw6CzoHfK3ZLvGr+Yeuts1rq/e95kTIBR4gFW7XZN+vZ2C2rjHKRs1iB
         eGhUQua3U3kqFGcT99eL1+SsrjLWwz6kxKLC8=
Received: by 10.231.2.67 with SMTP id 3mr2752751ibi.8.1313706746713; Thu, 18
 Aug 2011 15:32:26 -0700 (PDT)
Received: by 10.231.166.193 with HTTP; Thu, 18 Aug 2011 15:32:26 -0700 (PDT)
X-Google-Sender-Auth: 1ev7ec2GBTV8k2Xji17QgVqSlvE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179646>

The patch

   d04520e reset: give better reflog messages

is merge into master, but isn't in the release notes.
