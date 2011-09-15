From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: Anybody home?
Date: Thu, 15 Sep 2011 09:48:08 +0200
Message-ID: <201109150948.09040.trast@student.ethz.ch>
References: <CAOZxsTq1crC0zeMpFGMafG8HXu168gkK2-KDnpwLoamRLJshjg@mail.gmail.com> <4E71A5FF.5040807@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Git List <git@vger.kernel.org>
To: Joshua Stoutenburg <jehoshua02@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 15 09:48:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R46gC-00018K-8N
	for gcvg-git-2@lo.gmane.org; Thu, 15 Sep 2011 09:48:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755023Ab1IOHsL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Sep 2011 03:48:11 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:20190 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754858Ab1IOHsK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Sep 2011 03:48:10 -0400
Received: from CAS12.d.ethz.ch (172.31.38.212) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.339.1; Thu, 15 Sep
 2011 09:48:07 +0200
Received: from thomas.inf.ethz.ch (129.132.153.233) by CAS12.d.ethz.ch
 (172.31.38.212) with Microsoft SMTP Server (TLS) id 14.1.339.1; Thu, 15 Sep
 2011 09:48:09 +0200
User-Agent: KMail/1.13.7 (Linux/3.0.4-43-desktop; KDE/4.6.5; x86_64; ; )
In-Reply-To: <4E71A5FF.5040807@viscovery.net>
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181445>

Johannes Sixt wrote:
> Even when you want to exchange your commits between two or three machines,
> all you need is ssh access. There is no *git server* necessary. git is not
> svn. ;-)

I'd even put this somewhat more bluntly.  My two-step advice on
switching from svn to git is:

1) forget *everything* you know from SVN
2) learn git as usual

I don't hang out on IRC as much any more, so maybe it got better.  But
90%[*] of SVN convert's problems seem to stem from some preconceived
notions they carried over from SVN.

Such as, "HEAD is the newest commit".  Or the whole centralized
vs. distributed you mentioned.



[*] 78% of all statistics were made up on the spot

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
