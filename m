From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC/PATCH (homepage)] Add links to binaries for MS Windows (Cygwin, msysGit)
Date: Fri, 30 Nov 2007 12:34:51 +0100
Message-ID: <200711301234.52497.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Fri Nov 30 12:35:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iy49S-00050O-Np
	for gcvg-git-2@gmane.org; Fri, 30 Nov 2007 12:35:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760625AbXK3LfA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Nov 2007 06:35:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756446AbXK3LfA
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Nov 2007 06:35:00 -0500
Received: from nf-out-0910.google.com ([64.233.182.184]:41034 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755322AbXK3Le7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Nov 2007 06:34:59 -0500
Received: by nf-out-0910.google.com with SMTP id g13so2215325nfb
        for <git@vger.kernel.org>; Fri, 30 Nov 2007 03:34:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=6hQQJPESyhz7MWTn7YfCzoqht8jCxK+NlwPcdxhLrvk=;
        b=QTEe8hbLVuY9t3ew03J053DNC2phELFoAlXyJIZdRabMgJ00MrBY89BH77k0kV8+uwaucvwY82vSRflrjLR9ZfCDx/uZ0jVrZVjJ7llFILueCtElLOHrr9bO07SbrFrKg8BE2DEtVIc2cduynxYByERZcEIpLi1urpg+Zq0fzgk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=EU4RE5cuCyVUr7f/dk9IMfkPnItr457TZnYgp8WphKq+5wkWq1Q/eLtDaETzkWylK464MXtan6sAKkZ5IZiZ6tAp5W7XHktm06/8lxrERMAb9Kl392lT20JO/pxNkF4lVtwjEu5QHm4fUGgXA0v9NdDYftuCZWzVWNeRTEPj2dY=
Received: by 10.86.9.8 with SMTP id 8mr7123249fgi.1196422497049;
        Fri, 30 Nov 2007 03:34:57 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.252.40])
        by mx.google.com with ESMTPS id f31sm5300220fkf.2007.11.30.03.34.54
        (version=SSLv3 cipher=OTHER);
        Fri, 30 Nov 2007 03:34:55 -0800 (PST)
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66629>

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
What links should be provided for Cygwin? I could only found net
installer... (setup.exe)...

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
