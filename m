From: "Mike.lifeguard" <mike.lifeguard@gmail.com>
Subject: Gitweb: Scan dir for repos & show these other specified repos
Date: Mon, 01 Mar 2010 15:15:51 -0400
Message-ID: <4B8C1267.2050301@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 01 20:16:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NmB61-0004lc-JM
	for gcvg-git-2@lo.gmane.org; Mon, 01 Mar 2010 20:16:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751896Ab0CATP4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Mar 2010 14:15:56 -0500
Received: from mail-qy0-f179.google.com ([209.85.221.179]:53824 "EHLO
	mail-qy0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751820Ab0CATPz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Mar 2010 14:15:55 -0500
Received: by qyk9 with SMTP id 9so1529031qyk.5
        for <git@vger.kernel.org>; Mon, 01 Mar 2010 11:15:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:x-enigmail-version:content-type
         :content-transfer-encoding;
        bh=UCaOhQamhuSIzYen2Gur+V+DJne0bzkDvybo+w40CQM=;
        b=rOsyZoyhJ1lQehqSYuLDQTNPYTJdgwu70zwDasiMjpCYhl4cIaIyuiC5mIKuqtPDZm
         4VfeuA7akUjjBr2ShlZFNwO7GBxaw13WI1rHUPf4O0H0PTTnsbN7x2lOU8Ac5pVCSHWw
         SVfL3DnQscbq5b6emWmMlt05d4mVwtUPwQf1I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :x-enigmail-version:content-type:content-transfer-encoding;
        b=v2nDlxLuzXVdidzbwmPW5+86lLqWoOYJNQ7XizSWdu+XpLslhdvd3vO5o5KQno2fCu
         /0Gd1kk9RKFwG4ReXb6jDhMnnyILKmQipvzzEy1Ha+0CWOOFPcUHKEOiGVjkuxon2a2l
         6iZggntbacKZBNNRZk13vXr2q508ZnsUkSMKE=
Received: by 10.229.88.19 with SMTP id y19mr678143qcl.46.1267470954923;
        Mon, 01 Mar 2010 11:15:54 -0800 (PST)
Received: from ?192.168.0.6? (hlfxns0169w-142177063200.pppoe-dynamic.High-Speed.ns.bellaliant.net [142.177.63.200])
        by mx.google.com with ESMTPS id 35sm32078732vws.0.2010.03.01.11.15.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 01 Mar 2010 11:15:53 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.23) Gecko/20090817 Thunderbird/2.0.0.23 Mnenhy/0.7.6.0
X-Enigmail-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141342>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello,

Is it possible to have gitweb show all repositories in /path/to/wherever
and also show some other repositories at particular locations like
/home/user/git/repo1 and /home/user2/git/repo2 ? Or better yet, scan
multiple dirs? Currently I can only see how to do one or the other
within a single gitweb installation. I suppose I could run two of them...

Thanks for the help.

- -Mike
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkuMEmQACgkQst0AR/DaKHuYiQCeL3EoeUCr676lbwE2PIZK2tk3
7dsAoMpBmKoZZj3LV1zKLVqtIpFIiIii
=YDlg
-----END PGP SIGNATURE-----
