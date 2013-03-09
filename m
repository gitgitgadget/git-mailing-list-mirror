From: Paul Campbell <pcampbell@kemitix.net>
Subject: [PATCH 01/19] spell checking
Date: Sat, 9 Mar 2013 19:19:44 +0000
Message-ID: <CALeLG_=R4o1y-kA+n883nnAu+jrjgaA2ys2d+Vo9KasmVKeduQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: David Michael Barr <b@rr-dav.id.au>, Kindjal <kindjal@gmail.com>,
	bibendi <bibendi@bk.ru>, Herman van Rink <rink@initfour.nl>,
	James Roper <jroper@vz.net>, mhart <michael@adslot.com>,
	mhoffman <matt.hoffman@quantumretail.com>,
	Nate Jones <nate@endot.org>,
	Paul Cartwright <paul.cartwright@ziilabs.com>,
	Peter Jaros <pjaros@pivotallabs.com>
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Mar 09 20:20:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UEPJT-0004gK-9t
	for gcvg-git-2@plane.gmane.org; Sat, 09 Mar 2013 20:20:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751007Ab3CITTp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Mar 2013 14:19:45 -0500
Received: from mail-ob0-f175.google.com ([209.85.214.175]:34586 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750798Ab3CITTo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Mar 2013 14:19:44 -0500
Received: by mail-ob0-f175.google.com with SMTP id uz6so2265052obc.34
        for <git@vger.kernel.org>; Sat, 09 Mar 2013 11:19:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-received:x-originating-ip:date:message-id:subject
         :from:to:cc:content-type:x-gm-message-state;
        bh=z5ThocuF0ZbRJYp2TC0eicGe22X1Yaus2yTEWf/n73Q=;
        b=VCHtbb31S0i64iZacyfaez1R/Mx/sx4fCMrdfKWgE8Fn2J0quXhKppm8z0KZzSF6Fq
         HNJPSxVtdOnxy0HQZUjmtpLkjrcUupjXG7l6ki7mpNdT9Qf0FX0zDhbdpHylFNsN/YvM
         XRyZnIiclHfkDUwNRHuhkMZC16o+CeY9SV79MTAo+e/1tWGc1GFwLL3vJDVfExeJQQss
         oqZonDpBbPFWl/6/1KcSSBrScf706PDZ0o3mmrf/hycTDWH+pgDPERUrcFiJpD93Tsg/
         f5woSqH0NRoUqX7EF4E7ka569Vk89QIc74R86dtJ0H8i1l5ADyD1dWT78bL0GXqKh8y2
         HuEg==
X-Received: by 10.60.22.34 with SMTP id a2mr5033843oef.97.1362856784305; Sat,
 09 Mar 2013 11:19:44 -0800 (PST)
Received: by 10.76.122.109 with HTTP; Sat, 9 Mar 2013 11:19:44 -0800 (PST)
X-Originating-IP: [2.102.85.67]
X-Gm-Message-State: ALoCoQk9RahsfOOkdWFVoSpc16AgV2WqLdBBeIk37z+AC3RU0EpZiaxYMDI/9p6nK1TOoagynZo7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217737>

>From 72fc84b6e5085b328cc90e664c9f85a1f5cde36c Mon Sep 17 00:00:00 2001
From: Paul Cartwright <paul.cartwright@ziilabs.com>
Date: Thu, 27 Jan 2011 22:33:06 +0800
Subject: [PATCH 01/19] spell checking

---
 contrib/subtree/git-subtree.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/subtree/git-subtree.txt b/contrib/subtree/git-subtree.txt
index 7ba853e..e0957ee 100644
--- a/contrib/subtree/git-subtree.txt
+++ b/contrib/subtree/git-subtree.txt
@@ -270,7 +270,7 @@ git-extensions repository in ~/git-extensions/:
 name

 You can omit the --squash flag, but doing so will increase the number
-of commits that are incldued in your local repository.
+of commits that are included in your local repository.

 We now have a ~/git-extensions/git-subtree directory containing code
 from the master branch of git://github.com/apenwarr/git-subtree.git
-- 
1.8.2.rc1


-- 
Paul [W] Campbell
