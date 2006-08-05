From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: RE: update-ref logs: problem with committer info?
Date: Sun, 6 Aug 2006 01:55:05 +0200
Organization: Dewire
Message-ID: <200608060155.06723.robin.rosenberg.lists@dewire.com>
References: <001a01c6b8cd$0a7b5860$c47eedc1@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: spearce@spearce.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 06 01:55:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G9VzE-0000hn-HG
	for gcvg-git@gmane.org; Sun, 06 Aug 2006 01:55:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751400AbWHEXzQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 5 Aug 2006 19:55:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751404AbWHEXzQ
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Aug 2006 19:55:16 -0400
Received: from [83.140.172.130] ([83.140.172.130]:34609 "EHLO
	torino.dewire.com") by vger.kernel.org with ESMTP id S1751400AbWHEXzO
	(ORCPT <rfc822;git@vger.kernel.org>); Sat, 5 Aug 2006 19:55:14 -0400
Received: from localhost (localhost [127.0.0.1])
	by torino.dewire.com (Postfix) with ESMTP id 8113BAE5738;
	Sun,  6 Aug 2006 01:53:11 +0200 (CEST)
Received: from torino.dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 06107-05; Sun,  6 Aug 2006 01:53:11 +0200 (CEST)
Received: from [10.9.0.2] (unknown [10.9.0.2])
	by torino.dewire.com (Postfix) with ESMTP id 2CE9980264C;
	Sun,  6 Aug 2006 01:53:09 +0200 (CEST)
To: "Ramsay Jones" <ramsay@ramsay1.demon.co.uk>
User-Agent: KMail/1.9.4
In-Reply-To: <001a01c6b8cd$0a7b5860$c47eedc1@ramsay1.demon.co.uk>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24941>

> Yes, I am quite a long way behind, at version 1.4.1, which is light-years
> in git-time!  Unfortunately, since I can't pull from the git repo (I don't
> have internet access from Linux), I won't be able to update until the
> v1.4.2 tar-ball is posted. Yep, not exactly ideal.

Couldn't you track git with another machine? Then copy that clone to
your linux box and then do a local pull from the copied clone. 

There's also the http_proxy, but I guess you know that already.

-- robin
