From: Tom Byrer <tombyrer@gmail.com>
Subject: Please update grep in the Windows Git distro
Date: Mon, 2 Dec 2013 12:36:33 -0700
Message-ID: <CACAE+cGBvwVRjm8=-3e+w_xQozP1nfsphK4-ndky2yZoCoMjxw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 02 20:36:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VnZIR-0002Z3-CS
	for gcvg-git-2@plane.gmane.org; Mon, 02 Dec 2013 20:36:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754365Ab3LBTgi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Dec 2013 14:36:38 -0500
Received: from mail-la0-f53.google.com ([209.85.215.53]:53338 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752285Ab3LBTgf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Dec 2013 14:36:35 -0500
Received: by mail-la0-f53.google.com with SMTP id ea20so8690732lab.12
        for <git@vger.kernel.org>; Mon, 02 Dec 2013 11:36:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=WeTsxPeUEXx0LH0kyRwzmoTLFztMru7v8iZMb2ISVWM=;
        b=bTYhS2vVf2e8vpHcT+8o0aSsYY8vMJP+oJz7UgUYpC6IsQvmBRw5cFoVq3qhdHaedd
         bhd6W3bXuv6s+dFrUzUB0nM1xOMbpskmkjJ3KUbwQ4tgahXmVjXYnc+npRJ2HnUOBCFT
         8E6b59vjEXYiC2/8H8UcvZ5OdWgiRt8gabf9H71J4RakgQ9JFVIe6Xxu/BaxJ2voPDQO
         fGiGNqZQHjsye6kZ8iSKPcJY2N/cGyPEJwLaH0EhpzIXnjSUCGGNi+NmkIe3a1+Xbo7V
         tZfpxjoVJgOpeanGgYZQwQC0lptdrFno26lueJ9xuK5vgDMa3izbzz+A3XvGTs/AIlHu
         +Vag==
X-Received: by 10.152.28.161 with SMTP id c1mr1908170lah.24.1386012993560;
 Mon, 02 Dec 2013 11:36:33 -0800 (PST)
Received: by 10.152.5.228 with HTTP; Mon, 2 Dec 2013 11:36:33 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238648>

Seems that grep.exe is too outdated for some scripts:
https://github.com/creationix/nvm/issues/75#issuecomment-13735767

Updating to a newer grep distro fixes the problem:
https://github.com/creationix/nvm/issues/75#issuecomment-29054164

Seems other OSX & Linux don't have problems with the same scripts.

If the grep for the Git for Windows could be updated next, that would
be helpful.

cheers
