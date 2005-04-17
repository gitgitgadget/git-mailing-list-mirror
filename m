From: Paul Jackson <pj@sgi.com>
Subject: Re: Yet another base64 patch
Date: Sun, 17 Apr 2005 01:16:15 -0700
Organization: SGI
Message-ID: <20050417011615.3e7dfb29.pj@sgi.com>
References: <425DEF64.60108@zytor.com>
	<20050414022413.GB18655@64m.dyndns.org>
	<425E0174.4080404@zytor.com>
	<20050414024228.GC18655@64m.dyndns.org>
	<425E0D62.9000401@zytor.com>
	<Pine.LNX.4.58.0504140038450.7211@ppc970.osdl.org>
	<425EA152.4090506@zytor.com>
	<Pine.LNX.4.58.0504141042450.7211@ppc970.osdl.org>
	<20050414191157.GA27696@outpost.ds9a.nl>
	<425EC3B4.6090908@zytor.com>
	<20050414214756.GA31249@outpost.ds9a.nl>
	<Pine.LNX.4.58.0504141743360.7211@ppc970.osdl.org>
	<425F13C9.5090109@zytor.com>
	<20050414205831.01039ee8.pj@engr.sgi.com>
	<4261DDBC.3050706@dwheeler.com>
	<20050416210513.1ba26967.pj@sgi.com>
	<42620452.4080809@dwheeler.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 17 10:13:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DN4uL-0000bA-BK
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 10:13:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261282AbVDQIRR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 04:17:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261283AbVDQIRR
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 04:17:17 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:12269 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261282AbVDQIRO (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Apr 2005 04:17:14 -0400
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2])
	by omx2.sgi.com (8.12.11/8.12.9/linux-outbound_gateway-1.1) with ESMTP id j3H9uUB4013930;
	Sun, 17 Apr 2005 02:56:43 -0700
Received: from vpn2 (mtv-vpn-hw-pj-2.corp.sgi.com [134.15.25.219])
	by cthulhu.engr.sgi.com (SGI-8.12.5/8.12.5) with SMTP id j3H8GJlU15336013;
	Sun, 17 Apr 2005 01:16:19 -0700 (PDT)
To: dwheeler@dwheeler.com
In-Reply-To: <42620452.4080809@dwheeler.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

David wrote:
> My list would be:
> ext2, ext3, NFS, and Windows' NTFS (stupid short filenames,
> case-insensitive/case-preserving).

I'm no mind reader, but I'd bet a pretty penny that what you have in
mind and what Linus has in mind have no overlaps in their solution sets.

Happy coding ...

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
