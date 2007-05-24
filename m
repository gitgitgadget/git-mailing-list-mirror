From: "Lars Hjemli" <hjemli@gmail.com>
Subject: [ANNOUNCE] cgit v0.5
Date: Thu, 24 May 2007 15:51:41 +0200
Message-ID: <op.tst3gfyq9pspc6@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 24 15:49:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HrDhI-0004Gg-Qw
	for gcvg-git@gmane.org; Thu, 24 May 2007 15:49:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750698AbXEXNti convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 24 May 2007 09:49:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750702AbXEXNth
	(ORCPT <rfc822;git-outgoing>); Thu, 24 May 2007 09:49:37 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:16010 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750698AbXEXNth (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2007 09:49:37 -0400
Received: by ug-out-1314.google.com with SMTP id j3so881267ugf
        for <git@vger.kernel.org>; Thu, 24 May 2007 06:49:35 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:date:to:subject:from:content-type:mime-version:content-transfer-encoding:message-id:user-agent;
        b=XOLYFyIpX5bXa6wukAraaXMSrQ/tq06RSUZ7wD79p6Q4p59iF7yzVb4YR3AJYyZ5wIez2wqGnMQKjW+qBXhWWFobxuwefhzcOVAJyV4sGpQzbVa12HPpoPG6nvnZzGA6vGkI+q3Gr1WWN5OIxgFt/sM+skmDZvFB4NyXRaZOhdA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:to:subject:from:content-type:mime-version:content-transfer-encoding:message-id:user-agent;
        b=gPMJSz3u5fYBh3b0Qx9Mgq01oYDgFHrPixxnM0SzM+nY2DJSp9TsiDj7aB7MbuAHVep4G58eeyOpiCBvrzn8mXdZ1F168g8yEdMJoE+BEjoYaUdM3RNPhF2iNHsZG6Mf1O8W53YvIrnuhwnPUvgMHhdiJuZF64DWWI/RPniBDKQ=
Received: by 10.82.136.4 with SMTP id j4mr3196288bud.1180014574679;
        Thu, 24 May 2007 06:49:34 -0700 (PDT)
Received: from localhost ( [80.213.29.208])
        by mx.google.com with ESMTP id y37sm2545332iky.2007.05.24.06.49.32;
        Thu, 24 May 2007 06:49:33 -0700 (PDT)
User-Agent: Opera Mail/9.10 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48264>

cgit v0.5 (a fast web interface for git) is now available for download =
at =20
the usual places:
  tarballs - http://hjemli.net/git/cgit
  git repo - git://hjemli.net/pub/git/cgit

Release highlights:
  * path-filtering of log
  * grouping of repositories
  * external html files in index- and summary pages
  * index page shows time since last update for all repos
  * bugfixes

Many of the improvements and bugfixes are (or should have been) credite=
d =20
to Kristian H=C3=B8gsberg and his testing of cgit on =20
http://people.freedesktop.org/krh-cgi/cgit

--=20
larsh

[this is a resend, since vger dropped my previuos mail (probably due to=
 =20
gmails decision to base64-encode it)]
