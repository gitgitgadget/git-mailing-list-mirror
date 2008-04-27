From: "Marco Costalba" <mcostalba@gmail.com>
Subject: [RFH] Installing qgit under OS X 10.5.2 [was: Aloha]
Date: Sun, 27 Apr 2008 11:24:21 +0200
Message-ID: <e5bfff550804270224s10ea9dacu8899aa3523926895@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: drmark@gmail.com, "Shawn O. Pearce" <spearce@spearce.org>
To: "git mailing list" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Apr 27 11:25:13 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jq38A-00083N-Nw
	for gcvg-git-2@gmane.org; Sun, 27 Apr 2008 11:25:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752608AbYD0JYX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Apr 2008 05:24:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752300AbYD0JYX
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Apr 2008 05:24:23 -0400
Received: from wf-out-1314.google.com ([209.85.200.168]:24075 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751756AbYD0JYW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Apr 2008 05:24:22 -0400
Received: by wf-out-1314.google.com with SMTP id 28so3540548wff.4
        for <git@vger.kernel.org>; Sun, 27 Apr 2008 02:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=KBNtqxcOMItlye+Mn8Lx+MlB2vDP/CSGHx6X8rJ3UpA=;
        b=jPO1BrLzJHg9gbNyjG+IBWoinCenotHdxN77Cs/SxDbpfMPjv3ht3haKwMW0wnqGpOSqsGlXbChOBZMtZOBIvdnm5M7qmjf4Z2XYB7Cx857nm+dr9mfEj3hhfWMNLq7n3CjhU25ZmguMdfgch9uD4/kus/Ll57LzNZnaV3/XcRM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=mRZwJhoenZg9bCgcHjDRjzSUsjSdQO2tevCwxigK/gHFnMp1RbhtBjhTpO1C0NaajPk/boV4VUGUgbMU+2LCHmHLXTGlGZMD74cH9qFpXF0KXpwMBiwSSL7w58EjJVDGqFPVoWykXWnZWAoVHf7GXGMgkqr3IVH7NvcYyAVrgo4=
Received: by 10.143.167.19 with SMTP id u19mr1783508wfo.247.1209288261316;
        Sun, 27 Apr 2008 02:24:21 -0700 (PDT)
Received: by 10.142.212.18 with HTTP; Sun, 27 Apr 2008 02:24:21 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80435>

Aloha everybody,

    I don't have a OS X to test myself, so I would really appreciate
if someone on the list, lucky owner of a MAC, could help us with
this...

Thanks a lot in advance
Marco



---------- Forwarded message ----------
From: Mark A. Lane, Ph.D. <drmark@gmail.com>
Date: Sun, Apr 27, 2008 at 10:05 AM
Subject: Aloha, quick qgit question
To: mcostalba@gmail.com


Aloha,

I am sorry to bother you. Thank you for writing qgit. I really enjoy
it. I have been using version 2.0 for a while and like it a lot.

I have been trying to get the 3-21-08 version to compile on OS X
10.5.2 and I have not succeeded. Are there instructions or do you have
advice on the proper compile steps?

I have searched Google and have not found the answer. I have Qt4
installed as well as the xcode tools. The normal ./configure, make,
make install doesn't work. I also tried the qmake process and can't
get that to work either.

I would be happy to write up the instructions and host them if you can help me.

Thanks!

Mark

-- 
Mark A. Lane, Ph.D.
