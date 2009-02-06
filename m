From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: Eclipse Plugin install issue
Date: Fri, 6 Feb 2009 17:10:33 +0100
Message-ID: <200902061710.34337.robin.rosenberg@dewire.com>
References: <b0a3bf780902060717l653cc6dcx385aa147f606a520@mail.gmail.com> <20090206153418.GM26880@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Chris Velevitch <chris.velevitch@gmail.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Feb 06 17:12:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVTJL-0005yh-Or
	for gcvg-git-2@gmane.org; Fri, 06 Feb 2009 17:12:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759744AbZBFQKn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Feb 2009 11:10:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759731AbZBFQKm
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Feb 2009 11:10:42 -0500
Received: from mail.dewire.com ([83.140.172.130]:10209 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759657AbZBFQKl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Feb 2009 11:10:41 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id E50B6147E896;
	Fri,  6 Feb 2009 17:10:35 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NHmxMrEVErfz; Fri,  6 Feb 2009 17:10:35 +0100 (CET)
Received: from sleipner.localnet (sleipner.dewire.com [10.1.2.197])
	by dewire.com (Postfix) with ESMTP id 399C9147E88F;
	Fri,  6 Feb 2009 17:10:35 +0100 (CET)
User-Agent: KMail/1.10.4 (Linux/2.6.27-11-generic; KDE/4.1.4; i686; ; )
In-Reply-To: <20090206153418.GM26880@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108752>

fredag 06 februari 2009 16:34:18 skrev Shawn O. Pearce:
> Chris Velevitch <chris.velevitch@gmail.com> wrote:
> > I've pointed the Eclipse update manager to
> > http://www.jgit.org/update-site and when try to install it, it get:-
> > 
> > Cannot complete the request.  See the details.
> > Cannot find a solution satisfying the following requirements
> > Match[requiredCapability:
> > org.eclipse.equinox.p2.iu/org.spearce.egit.feature.group/[0.4.0.200901290136,0.4.0.200901290136]].
> ...
> > The instructions didn't say there were any prerequisites.
> 
> There aren't any prerequisites beyond the base Eclipse 3.4 and
> any Java 5 or later runtime.  Its very odd that the update manager
> can't install EGit.
>  
> Robin, is there a missing JAR file on the jgit.org update site?

I installed the latest version yesterday myself in both  the SDK edition and JEE editions of Ganymed 3.4.0. Just checked that it worked in 3.4.1 too and from another location. That was a later version though 200902052244, but I try every version unless I get interrupted and forget about it.

-- robin
