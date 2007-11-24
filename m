From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC/PATCH (homepage)] Add links to binaries for MS Windows (Cygwin, msysGit)
Date: Sat, 24 Nov 2007 23:47:31 +0100
Message-ID: <1195944451-10587-1-git-send-email-jnareb@gmail.com>
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Sat Nov 24 23:49:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iw3n1-0007JD-8t
	for gcvg-git-2@gmane.org; Sat, 24 Nov 2007 23:47:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752684AbXKXWrg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Nov 2007 17:47:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752677AbXKXWrf
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Nov 2007 17:47:35 -0500
Received: from nf-out-0910.google.com ([64.233.182.187]:4966 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752662AbXKXWrf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Nov 2007 17:47:35 -0500
Received: by nf-out-0910.google.com with SMTP id g13so227812nfb
        for <git@vger.kernel.org>; Sat, 24 Nov 2007 14:47:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:from:to:cc:subject:date:message-id:x-mailer;
        bh=nZvjGzCkqQ8CPF4PQVuPiutaSoRPpa2ehl79B6rlY6A=;
        b=QjmwA+5JjcPHSAmS7zn6InTBZhIrckq+kVIBG3U+mMr8ZsT2tLFzAxecxKgaJdMyZdjZAeY/6OK9SE9oFpNqJkc0YczFEpqHRQYBDoD8gruHi6ZTDSYhc2nTNCdO9kpn+jwhZUqLDXwvWTUEFJxd6h9HwEeVJoutrRTKsj5ANY0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:from:to:cc:subject:date:message-id:x-mailer;
        b=jaRy+RwMOht6ra3oDgO5OQcAmJR3xJq0zSYM0olV1hpAmV3A3DxjbCbmDJ82wnzANlLzjmlcnW5IprQWRPCYH89GPuVhz+ItaYcIZcsE8vqSf9ySP4yg3+1LzwTcZ3ZnOxK5NFYhatUOo1IxdWNEb9OiPPIS6/5LNhGQx4bMqKA=
Received: by 10.86.91.12 with SMTP id o12mr913497fgb.1195944453670;
        Sat, 24 Nov 2007 14:47:33 -0800 (PST)
Received: from roke.D-201 ( [83.8.240.234])
        by mx.google.com with ESMTPS id v23sm50097fkd.2007.11.24.14.47.31
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 24 Nov 2007 14:47:32 -0800 (PST)
Received: from roke.D-201 (localhost.localdomain [127.0.0.1])
	by roke.D-201 (8.13.4/8.13.4) with ESMTP id lAOMlXT1010602;
	Sat, 24 Nov 2007 23:47:33 +0100
Received: (from jnareb@localhost)
	by roke.D-201 (8.13.4/8.13.4/Submit) id lAOMlVKC010601;
	Sat, 24 Nov 2007 23:47:31 +0100
X-Mailer: git-send-email 1.5.3.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65965>

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 index.html |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/index.html b/index.html
index 29fa0b1..142bd46 100644
--- a/index.html
+++ b/index.html
@@ -236,6 +236,16 @@ You can also use one of many <a href="http://www.kernel.org/mirrors/">kernel.org
 <td><a href="http://packages.debian.org/unstable/devel/git-core">http://packages.debian.org/unstable/devel/git-core</a></td>
 </tr>
 
+<tr>
+<td rowspan="2">Win</td>
+<td><a href="http://www.cygwin.com/">Cygwin</a></td>
+<td><a href="http://www.cygwin.com/setup.exe">http://www.cygwin.com/setup.exe</a></td>
+</tr>
+<tr class="odd">
+<td><a href="http://code.google.com/p/msysgit/">msysGit</a></td>
+<td><a href="http://code.google.com/p/msysgit/downloads/list">http://code.google.com/p/msysgit/downloads/list</a></td>
+</tr>
+
 </table>
 
 <h3>Development snapshots</h3>
-- 
1.5.3.6
