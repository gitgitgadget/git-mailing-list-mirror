From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: [RFC] gitweb wishlist and TODO list
Date: Wed, 21 Jun 2006 10:56:10 +0200
Message-ID: <200606211056.10889.Josef.Weidendorfer@gmx.de>
References: <e79921$u0e$1@sea.gmane.org> <20060620215331.GB25183@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>,
	Michael Gernoth <simigern@stud.uni-erlangen.de>
X-From: git-owner@vger.kernel.org Wed Jun 21 10:56:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FsyVa-0003IB-Hq
	for gcvg-git@gmane.org; Wed, 21 Jun 2006 10:56:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751299AbWFUI4Q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Jun 2006 04:56:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751314AbWFUI4Q
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jun 2006 04:56:16 -0400
Received: from mailout1.informatik.tu-muenchen.de ([131.159.0.18]:46842 "EHLO
	mailout1.informatik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id S1751299AbWFUI4Q (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jun 2006 04:56:16 -0400
Received: from dhcp-3s-61.lrr.in.tum.de (dhcp-3s-61.lrr.in.tum.de [131.159.35.61])
	by mail.in.tum.de (Postfix) with ESMTP id 7E7542684;
	Wed, 21 Jun 2006 10:56:14 +0200 (MEST)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
In-Reply-To: <20060620215331.GB25183@cip.informatik.uni-erlangen.de>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new/sophie/sophos at mailrelay2.informatik.tu-muenchen.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22241>

On Tuesday 20 June 2006 23:53, you wrote:
> he didn't do so far. So I use this opportunity. Maybe something else
> would be much more handier: Use gitweb to request the log and shortlog
> of a directory tree, like git-whatchanged arch/i386 does for example.
> Maybe it is already possible and I missed it?

There aren't any links, but:
On the bottom of a commit, you can click on "history" for blobs.
Changing the URL afterwards (the f= arg) can give you the history of
a directory.

I just tried, and in fact it works. But "Diff to current" does not
work for directories.

It would be nice to have a list of the files in the directory
touched by the given commits.

Josef
