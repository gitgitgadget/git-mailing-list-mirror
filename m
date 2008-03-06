From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: GSoC 2008 - Mentors Wanted!
Date: Thu, 6 Mar 2008 21:47:13 +0100
Message-ID: <200803062147.14067.robin.rosenberg@dewire.com>
References: <20080304051149.GS8410@spearce.org> <200803052213.20501.robin.rosenberg@dewire.com> <7bfdc29a0803052133p67741421gb6aa1b1f7357dd90@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	"Carlos Rica" <jasampler@gmail.com>, git@vger.kernel.org,
	"Junio C Hamano" <gitster@pobox.com>
To: "Imran M Yousuf" <imyousuf@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 06 21:48:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXN0S-0002xx-JR
	for gcvg-git-2@gmane.org; Thu, 06 Mar 2008 21:48:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759776AbYCFUrS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Mar 2008 15:47:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759708AbYCFUrS
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Mar 2008 15:47:18 -0500
Received: from [83.140.172.130] ([83.140.172.130]:11052 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1759431AbYCFUrR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Mar 2008 15:47:17 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id CF139802671;
	Thu,  6 Mar 2008 21:47:14 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2NJd1kUdB9pL; Thu,  6 Mar 2008 21:47:14 +0100 (CET)
Received: from [10.9.0.7] (unknown [10.9.0.7])
	by dewire.com (Postfix) with ESMTP id 626AA80266D;
	Thu,  6 Mar 2008 21:47:14 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <7bfdc29a0803052133p67741421gb6aa1b1f7357dd90@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76422>

Den Thursday 06 March 2008 06.33.26 skrev Imran M Yousuf:
> I am honoured and would be grateful for your support.
Great!.

> >  You can make a plugin for Netbeans today that will do the basic like
> > walking the history, finding out what to commit, commit,
> > switch/create/reset branches, decorations based on jgit and you wouldn't
> > need to change a thing in jgit. There might be things you *want* to
> > change, but that's another story and applied to the continued development
> > for the Eclipse plugin too. Even the license might be changed.
>
> I was taking a look at the Mercurial VCS Plugin for NetBeans and I
> think GIT's one will be similar. Using jGit would be great; Do you
> have any plans to have a Maven version of jGit so that it could be
> used from any Maven project? Another question is - Is jGit dependent
Same thing as with Netbeans. We don't need a special version of jgit
for Maven, Ant, Cruisecontrol, whatever. We might (will) discover new use
cases where we want to put more code into jgit because it not application
specific. So go ahead, invoke jgit, send patches etc.

-- robin
