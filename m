From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: git versus CVS (versus bk)
Date: Tue, 8 Nov 2005 11:50:10 +0100
Message-ID: <200511081150.10867.Josef.Weidendorfer@gmx.de>
References: <Pine.LNX.4.64.0510301720390.14972@x2.ybpnyarg> <20051101091533.GB11618@pasky.or.cz> <20051107225652.GW1431@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Tue Nov 08 11:51:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZR3p-00042Q-OW
	for gcvg-git@gmane.org; Tue, 08 Nov 2005 11:50:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965012AbVKHKuR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 Nov 2005 05:50:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965005AbVKHKuR
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Nov 2005 05:50:17 -0500
Received: from tuminfo2.informatik.tu-muenchen.de ([131.159.0.81]:58354 "EHLO
	tuminfo2.informatik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id S965007AbVKHKuP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Nov 2005 05:50:15 -0500
Received: from dhcp-3s-40.lrr.in.tum.de (dhcp-3s-40.lrr.in.tum.de [131.159.35.40])
	by mail.in.tum.de (Postfix) with ESMTP id 5D70A28A6;
	Tue,  8 Nov 2005 11:50:12 +0100 (MET)
To: git@vger.kernel.org
User-Agent: KMail/1.8.2
In-Reply-To: <20051107225652.GW1431@pasky.or.cz>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new/sophie/sophos at mailrelay2.informatik.tu-muenchen.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11325>

On Monday 07 November 2005 23:56, Petr Baudis wrote:
> Dear diary, on Tue, Nov 01, 2005 at 10:15:33AM CET, I got a letter
> where Petr Baudis <pasky@suse.cz> told me that...
> > That said, with a big warning, I would be willing to do something like
> > cg-merge -s and cg-update -s (s as squash)
> ...
> FWIW, cg-merge -s and cg-update -s is supported now.

The -s option of git merge is about choosing a strategy.
How can I choose the "recursive" strategy with cg-merge?
Some consistency would be good here.

Josef
