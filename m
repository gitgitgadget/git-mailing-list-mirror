From: Zhi Li <lizhi1215@gmail.com>
Subject: early days before git's invention
Date: Sun, 8 Nov 2009 20:23:08 +0800
Message-ID: <2986b3940911080423p4ccfe279ia00c995e1ea23fb9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 08 13:25:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N76pn-0005AI-5Q
	for gcvg-git-2@lo.gmane.org; Sun, 08 Nov 2009 13:25:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754241AbZKHMXW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Nov 2009 07:23:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754199AbZKHMXU
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Nov 2009 07:23:20 -0500
Received: from mail-pw0-f42.google.com ([209.85.160.42]:52808 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754159AbZKHMXE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Nov 2009 07:23:04 -0500
Received: by pwi3 with SMTP id 3so139270pwi.21
        for <git@vger.kernel.org>; Sun, 08 Nov 2009 04:23:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=qHp8L4rkZAdGrDgtvgVwYqsWuy4yPvJ/sxdK7bmSdFw=;
        b=N5yjdu3BeRgV6+lDPiBCrYtPVM8ETc8it7H1StQ6cr72JbmzhEeI/ZWkiteC5a/pSf
         Z9jJa1kEpHffOmdtBZqHUALpAgwiKYZPr3lb8zS2AfVt/10X9EJzxj/f6mQ7v7DNCHa9
         Nx8irMB9mssFnjXWRpVZ0CnoMbzS5kQQBDt0k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=jFwOLubaVhCcsg/b649AYlMe9/k7RrE12xLi4PKX9AVkpb3OiB6Q7AS+4GxeKRN29Y
         o7xvUFMpI2CeseJ5x4EvBxSi95ax8BCk4e4qzobskzcsnMArw0tm0u5rSVaX0yOEYPM2
         2N1QnhJriFNetcHbXu4vUfbvOVbUshgLRFeBY=
Received: by 10.142.247.5 with SMTP id u5mr727935wfh.44.1257682988123; Sun, 08 
	Nov 2009 04:23:08 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132394>

Hello list,

I have a question maybe not suitable to be put on this list. I'm just
curious on git and Linux history. As what was said on wiki, Linux
kernel was maintained by BitKeeper, then for some reason, BitKeeper
can not be used, so git was invented. My question is what was used
before BitKeeper, CVS? I don't think so. Then, just using file to
manage?

Zhi
