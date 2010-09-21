From: Wilbert van Dolleweerd <wilbert@arentheym.com>
Subject: [ANNOUNCE] TFS2GIT. Script that will import Microsoft Team Foundation
 Server repositories in a Git repository.
Date: Tue, 21 Sep 2010 19:55:27 +0200
Message-ID: <AANLkTinmhhrerxPJGU8b2iuGSNV-=vz-Y6fCvHJODXAs@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 21 19:55:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oy743-0005NE-GN
	for gcvg-git-2@lo.gmane.org; Tue, 21 Sep 2010 19:55:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758006Ab0IURz3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Sep 2010 13:55:29 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:38377 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757066Ab0IURz2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Sep 2010 13:55:28 -0400
Received: by qwh6 with SMTP id 6so4436018qwh.19
        for <git@vger.kernel.org>; Tue, 21 Sep 2010 10:55:27 -0700 (PDT)
Received: by 10.229.1.143 with SMTP id 15mr7144092qcf.287.1285091727222; Tue,
 21 Sep 2010 10:55:27 -0700 (PDT)
Received: by 10.229.44.196 with HTTP; Tue, 21 Sep 2010 10:55:27 -0700 (PDT)
X-Originating-IP: [82.171.76.203]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156735>

Hello,

I had a personal itch to import Microsoft Team Foundation Server
repositories into a Git repository. I wrote a small Powershell script
and released this on Github at
http://github.com/WilbertOnGithub/TFS2GIT

I also wrote a small article about its usage at
http://walkingthestack.wordpress.com/2010/09/21/importing-a-tfs-repository-into-a-git-repository-using-powershell/

This is the very first version and my first Powershell script, i.e. it
works on my machine. You will need to modify it if you want to import
your own repositories. This is explained in the above article.

I'm hoping this can convince other Team Foundation users to start using Git ;-)

-- 
Kind regards,

Wilbert van Dolleweerd
Blog: http://walkingthestack.wordpress.com/
Twitter: http://www.twitter.com/wvandolleweerd
