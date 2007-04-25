From: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
Subject: Re: using stgit/guilt for public branches
Date: Wed, 25 Apr 2007 22:52:48 +0300
Message-ID: <20070425195248.GA5217@mellanox.co.il>
References: <20070425122048.GD1624@mellanox.co.il>
	<20070425191838.GA6267@filer.fsl.cs.sunysb.edu>
Reply-To: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>,
	Junio C Hamano <junkio@cox.net>,
	Catalin Marinas <catalin.marinas@arm.com>, git@vger.kernel.org,
	Josef 'Jeff' Sipek <jsipek@cs.sunysb.edu>
To: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
X-From: git-owner@vger.kernel.org Wed Apr 25 21:52:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HgnXm-0003U2-4U
	for gcvg-git@gmane.org; Wed, 25 Apr 2007 21:52:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752985AbXDYTwr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Apr 2007 15:52:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753240AbXDYTwq
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Apr 2007 15:52:46 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:4188 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752985AbXDYTwp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Apr 2007 15:52:45 -0400
Received: by ug-out-1314.google.com with SMTP id 44so486105uga
        for <git@vger.kernel.org>; Wed, 25 Apr 2007 12:52:44 -0700 (PDT)
Received: by 10.67.19.17 with SMTP id w17mr1649295ugi.1177530764045;
        Wed, 25 Apr 2007 12:52:44 -0700 (PDT)
Received: from ?127.0.0.1? ( [89.138.119.177])
        by mx.google.com with ESMTP id e1sm132705ugf.2007.04.25.12.52.42;
        Wed, 25 Apr 2007 12:52:43 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20070425191838.GA6267@filer.fsl.cs.sunysb.edu>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45553>

> Quoting Josef Sipek <jsipek@fsl.cs.sunysb.edu>:
> Subject: Re: using stgit/guilt for public branches
> 
> You could try to use git to version the patches directory
> (.git/patches/$branch/) and publish that in addition to the actual kernel
> repository.

How does one do this, exactly?

-- 
MST
