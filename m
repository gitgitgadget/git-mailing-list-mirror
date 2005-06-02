From: "Sean" <seanlkml@sympatico.ca>
Subject: Re: gitk-1.1 out
Date: Thu, 2 Jun 2005 09:32:25 -0400 (EDT)
Message-ID: <3064.10.10.10.24.1117719145.squirrel@linux1>
References: <17053.35147.52729.794561@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 02 15:31:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DdplK-0004ku-HU
	for gcvg-git@gmane.org; Thu, 02 Jun 2005 15:29:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261415AbVFBNcb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Jun 2005 09:32:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261417AbVFBNcb
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Jun 2005 09:32:31 -0400
Received: from simmts12.bellnexxia.net ([206.47.199.141]:38302 "EHLO
	simmts12-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S261415AbVFBNca (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jun 2005 09:32:30 -0400
Received: from linux1 ([70.50.38.176]) by simmts12-srv.bellnexxia.net
          (InterMail vM.5.01.06.10 201-253-122-130-110-20040306) with ESMTP
          id <20050602133225.KYDP1005.simmts12-srv.bellnexxia.net@linux1>;
          Thu, 2 Jun 2005 09:32:25 -0400
Received: from linux1 (linux1.attic.local [127.0.0.1])
	by linux1 (8.12.11/8.12.11) with ESMTP id j52DWPcE013455;
	Thu, 2 Jun 2005 09:32:25 -0400
Received: from 10.10.10.24
        (SquirrelMail authenticated user sean)
        by linux1 with HTTP;
        Thu, 2 Jun 2005 09:32:25 -0400 (EDT)
In-Reply-To: <17053.35147.52729.794561@cargo.ozlabs.ibm.com>
To: "Paul Mackerras" <paulus@samba.org>
User-Agent: SquirrelMail/1.4.4-2
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, June 1, 2005 6:09 am, Paul Mackerras said:
> The latest version of gitk is at:
>
> 	http://ozlabs.org/~paulus/gitk/gitk-1.1.tar.gz
>
> (yes, a real tarball this time, with a README even. :)
>

Hi Paul,

Looks really good!  Thought i'd share some homespun rpms that upgrade
Fedora TCL/Tk to use anti-aliased fonts for gitk.   They make the text
displayed in gitk a little nicer to read.  Only tested on Fedora FC3 and
there's no warranty, but they should work for others too.

The rpms and a couple of screenshots are available from:
http://git.homelinux.com

Cheers,
Sean


