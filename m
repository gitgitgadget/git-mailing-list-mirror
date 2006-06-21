From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: [RFC] gitweb wishlist and TODO list
Date: Wed, 21 Jun 2006 11:57:23 +0200
Message-ID: <200606211157.23809.Josef.Weidendorfer@gmx.de>
References: <e79921$u0e$1@sea.gmane.org> <200606211056.10889.Josef.Weidendorfer@gmx.de> <e7b2n4$hd8$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 21 11:57:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FszSl-00051l-QU
	for gcvg-git@gmane.org; Wed, 21 Jun 2006 11:57:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751454AbWFUJ53 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Jun 2006 05:57:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751455AbWFUJ53
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jun 2006 05:57:29 -0400
Received: from mailout1.informatik.tu-muenchen.de ([131.159.0.18]:18850 "EHLO
	mailout1.informatik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id S1751454AbWFUJ52 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jun 2006 05:57:28 -0400
Received: from dhcp-3s-61.lrr.in.tum.de (dhcp-3s-61.lrr.in.tum.de [131.159.35.61])
	by mail.in.tum.de (Postfix) with ESMTP id 68A5D2748;
	Wed, 21 Jun 2006 11:57:27 +0200 (MEST)
To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KMail/1.9.3
In-Reply-To: <e7b2n4$hd8$1@sea.gmane.org>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new/sophie/sophos at mailrelay2.informatik.tu-muenchen.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22250>

On Wednesday 21 June 2006 11:15, you wrote:
> Josef Weidendorfer wrote:
> 
> > It would be nice to have a list of the files in the directory
> > touched by the given commits.
> 
> 'commit' view gives at the bottom list of all files affected by given
> commit.

Yup, but when you are interested in the history of changes to files in
a given directory, you also want to see the name of the changed files on
the same page, and not have to click on every commit to get the file names.
Besides, the "commit" view shows all changed files, and not only the ones
which are in the directory.

> Is that what you wanted, or did you want 'blame' for directories 
> (trees)?

Could be interesting; but everytime I look at such a page in ViewCVS,
I want to have it sorted by time...

Josef
