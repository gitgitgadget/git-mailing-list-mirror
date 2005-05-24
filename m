From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
Subject: Re: gitweb wishlist
Date: Tue, 24 May 2005 20:29:51 +0200
Message-ID: <20050524182951.GB9537@cip.informatik.uni-erlangen.de>
References: <1116626652.12975.118.camel@dhcp-188> <Pine.LNX.4.58.0505201604460.2206@ppc970.osdl.org> <428E745C.30304@zytor.com> <Pine.LNX.4.58.0505201702170.2206@ppc970.osdl.org> <4292A08A.5050108@cobite.com> <Pine.LNX.4.58.0505232048190.2307@ppc970.osdl.org> <Pine.LNX.4.58.0505240110580.2307@ppc970.osdl.org> <20050524161745.GA9537@cip.informatik.uni-erlangen.de> <Pine.LNX.4.58.0505240929051.2307@ppc970.osdl.org> <Pine.LNX.4.58.0505240943080.2307@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Tue May 24 20:30:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dae8e-0002LN-Vl
	for gcvg-git@gmane.org; Tue, 24 May 2005 20:28:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261935AbVEXS36 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 May 2005 14:29:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261946AbVEXS36
	(ORCPT <rfc822;git-outgoing>); Tue, 24 May 2005 14:29:58 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:19595 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S261935AbVEXS34 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2005 14:29:56 -0400
Received: from faui03.informatik.uni-erlangen.de (faui03.informatik.uni-erlangen.de [131.188.30.103])
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) with ESMTP id j4OITpS8022912
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 24 May 2005 18:29:51 GMT
Received: (from sithglan@localhost)
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) id j4OITpC9022911;
	Tue, 24 May 2005 20:29:51 +0200 (CEST)
To: Git Mailing List <git@vger.kernel.org>
Mail-Followup-To: Git Mailing List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0505240943080.2307@ppc970.osdl.org>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hello,

>  - name translation doesn't exist (so all of Peters changesets get 
>    reported as author "hpa <hpa>")

I pick that up.

>  - the commit time will be the conversion time, not the original commit 
>    time (but the _author_ time will be correct). I suspect that for a 
>    conversion like this, we really should add support for GIT_COMMIT_DATE. 

Thanks. I wanted to send patches or at least ask you this for ages, but
never did. :-)

	Thomas
