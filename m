From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: Email patch -> git commit?
Date: Wed, 3 Aug 2005 00:27:18 +0200
Message-ID: <20050802222718.GA19107@mars.ravnborg.org>
References: <42EFF077.6080606@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Aug 03 00:24:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E05Aw-0006dF-5s
	for gcvg-git@gmane.org; Wed, 03 Aug 2005 00:23:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261447AbVHBWXt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 2 Aug 2005 18:23:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261455AbVHBWXt
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Aug 2005 18:23:49 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:63643 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S261447AbVHBWXs
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 2 Aug 2005 18:23:48 -0400
Received: from mars.ravnborg.org (0x50a0757d.hrnxx9.adsl-dhcp.tele.dk [80.160.117.125])
	by pfepb.post.tele.dk (Postfix) with ESMTP id 860245EE02E;
	Wed,  3 Aug 2005 00:23:47 +0200 (CEST)
Received: by mars.ravnborg.org (Postfix, from userid 1000)
	id 6FC746AC01D; Wed,  3 Aug 2005 00:27:18 +0200 (CEST)
To: "H. Peter Anvin" <hpa@zytor.com>
Content-Disposition: inline
In-Reply-To: <42EFF077.6080606@zytor.com>
User-Agent: Mutt/1.5.8i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 02, 2005 at 03:15:19PM -0700, H. Peter Anvin wrote:
> Anyone have any good scripts for taking patches in email and turning 
> them into git commits, preferrably while preserving the author information?

git-applymbox seems to be what you are looking for.
It was named dotest in the old days.

	Sam
