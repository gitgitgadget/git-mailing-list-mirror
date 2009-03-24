From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: newbie question: git on existing svn repo via eclipse on windows
Date: Tue, 24 Mar 2009 23:31:22 +0100
Message-ID: <200903242331.22522.robin.rosenberg.lists@dewire.com>
References: <49C8A66C.3080203@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Michael Gaber <Michael.Gaber@gmx.net>
X-From: git-owner@vger.kernel.org Tue Mar 24 23:33:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmFBB-0001FW-Ep
	for gcvg-git-2@gmane.org; Tue, 24 Mar 2009 23:33:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752052AbZCXWbd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Mar 2009 18:31:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751503AbZCXWbc
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Mar 2009 18:31:32 -0400
Received: from mail.dewire.com ([83.140.172.130]:1662 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750812AbZCXWbc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Mar 2009 18:31:32 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 460A9139A449;
	Tue, 24 Mar 2009 23:31:25 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WbTvKmKCxsBU; Tue, 24 Mar 2009 23:31:24 +0100 (CET)
Received: from sleipner.localnet (unknown [10.9.0.6])
	by dewire.com (Postfix) with ESMTP id AE0D0139141C;
	Tue, 24 Mar 2009 23:31:24 +0100 (CET)
User-Agent: KMail/1.11.1 (Linux/2.6.27-14-generic; KDE/4.2.1; i686; ; )
In-Reply-To: <49C8A66C.3080203@gmx.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114502>

tisdag 24 mars 2009 10:22:52 skrev Michael Gaber <Michael.Gaber@gmx.net>:
> Hello,
> 
> I hope I'm right here to post this question and it hasn't been answered 
> 100k times already.
> I'm currently programming my bachelor-thesis and my university only 
> gives me a svn repository. Since I'm working a big amount of time 
> offline I'd like to have the features a dvcs offers me to commit 
> whenever i have completed a minor step even while I'm offline, so I 
> don't forget what I've done until i get online again.
> Is there a simple way to do this especially on windows while using 
> eclipse and egit.

Depends on your definition of "simple". Egit has no SVN support whatsoever,
so you have to use git-svn and egit side-by-side to accomplish your tasks.

-- robin
