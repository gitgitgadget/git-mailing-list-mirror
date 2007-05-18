From: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
Subject: Re: [3/4] What's not in 1.5.2 (new topics)
Date: Fri, 18 May 2007 19:21:06 +0300
Message-ID: <20070518162106.GN4708@mellanox.co.il>
References: <200705170539.11402.andyparkins@gmail.com>
	<200705181524.40705.Josef.Weidendorfer@gmx.de>
	<20070518133922.GK4708@mellanox.co.il>
	<200705181751.15435.Josef.Weidendorfer@gmx.de>
	<20070518160840.GK18276@pasky.or.cz>
Reply-To: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>,
	"Michael S. Tsirkin" <mst@dev.mellanox.co.il>,
	Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <junkio@cox.net>,
	Andy Parkins <andyparkins@gmail.com>,
	Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
To: Petr Baudis <pasky@ucw.cz>
X-From: git-owner@vger.kernel.org Fri May 18 18:21:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hp5Cb-0004Oy-0j
	for gcvg-git@gmane.org; Fri, 18 May 2007 18:21:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755149AbXERQVI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 May 2007 12:21:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756427AbXERQVI
	(ORCPT <rfc822;git-outgoing>); Fri, 18 May 2007 12:21:08 -0400
Received: from py-out-1112.google.com ([64.233.166.177]:19288 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755149AbXERQVF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 May 2007 12:21:05 -0400
Received: by py-out-1112.google.com with SMTP id a29so1205304pyi
        for <git@vger.kernel.org>; Fri, 18 May 2007 09:21:05 -0700 (PDT)
Received: by 10.65.185.3 with SMTP id m3mr6711409qbp.1179505264708;
        Fri, 18 May 2007 09:21:04 -0700 (PDT)
Received: from ?127.0.0.1? ( [217.132.34.225])
        by mx.google.com with ESMTP id f14sm4107411qba.2007.05.18.09.21.00;
        Fri, 18 May 2007 09:21:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20070518160840.GK18276@pasky.or.cz>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47620>

> > The current way is far simpler, but you have to edit the .gitmodule
> > file when moving subprojects around. The argument by Linus was
> > that this inconvenience should be acceptable as moving subprojects
> > around should only happen very few times in the lifetime of a
> > project, and involves heavy rearranging either way, such that editing
> > .gitmodules info is the smaller issue.
> 
> Furthermore, git mv can trivially take care of this anyway...

Good idea.

-- 
MST
