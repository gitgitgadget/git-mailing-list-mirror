From: Alecs King <alecsk@gmail.com>
Subject: [PATCH] Documentation/git-log.txt: trivial typo fix.
Date: Thu, 17 Nov 2005 03:06:03 +0800
Message-ID: <20051116190603.GA13321@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Nov 16 20:09:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EcSbc-00072L-6m
	for gcvg-git@gmane.org; Wed, 16 Nov 2005 20:06:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751010AbVKPTFu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 16 Nov 2005 14:05:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751490AbVKPTFt
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Nov 2005 14:05:49 -0500
Received: from zproxy.gmail.com ([64.233.162.195]:31666 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751010AbVKPTFs (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Nov 2005 14:05:48 -0500
Received: by zproxy.gmail.com with SMTP id 18so1790089nzp
        for <git@vger.kernel.org>; Wed, 16 Nov 2005 11:05:46 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:mail-followup-to:mime-version:content-type:content-disposition:user-agent;
        b=brP5bgqT+uSw3K1IOy6zsL+b89foxSO1DIrMDVC0PlpxB1vWDWLAgjKYJNj7JtL9FgvpgapIJj0xNM1YfqJ2POD3MBtnzAotPyjkZTwN622vRDfRNFsh9CYSaHPn4nOKHOyFBMMQeg2ODXGOE6FEYc3okefDhlDXLxl2S5sGN8o=
Received: by 10.36.38.13 with SMTP id l13mr6580182nzl;
        Wed, 16 Nov 2005 11:05:46 -0800 (PST)
Received: from localhost ( [221.222.170.245])
        by mx.gmail.com with ESMTP id 7sm993311nzo.2005.11.16.11.05.43;
        Wed, 16 Nov 2005 11:05:45 -0800 (PST)
To: git <git@vger.kernel.org>
Mail-Followup-To: git <git@vger.kernel.org>
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12041>


Signed-off-by: Alecs King <alecsk@gmail.com>

---

 Documentation/git-log.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

applies-to: 1e3fcf60526c196a46433e6947c9104ca236f230
c9c64ee3f4e333a7c3626da45b38105e67c6517f
diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index 9cac088..e995d1b 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -20,7 +20,7 @@ This manual page describes only the most
 
 OPTIONS
 -------
---pretty=<format>:
+--pretty=<format>::
 	Controls the way the commit log is formatted.
 
 --max-count=<n>::
---
0.99.9.GIT
-- 
Alecs King
