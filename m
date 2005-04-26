From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: git-pasky "tutorial"
Date: Wed, 27 Apr 2005 08:42:02 +1000
Message-ID: <1114555322.7182.77.camel@gaston>
References: <1114306508.5444.7.camel@gaston>
	 <20050426195752.GG13224@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 27 00:37:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQYg8-0004h2-1K
	for gcvg-git@gmane.org; Wed, 27 Apr 2005 00:37:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261827AbVDZWm3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Apr 2005 18:42:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261831AbVDZWm3
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Apr 2005 18:42:29 -0400
Received: from gate.crashing.org ([63.228.1.57]:10705 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261827AbVDZWm0 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Apr 2005 18:42:26 -0400
Received: from gaston (localhost [127.0.0.1])
	by gate.crashing.org (8.12.8/8.12.8) with ESMTP id j3QMb2gJ032068;
	Tue, 26 Apr 2005 17:37:02 -0500
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050426195752.GG13224@pasky.ji.cz>
X-Mailer: Evolution 2.0.4 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


> you might want to try again with cogito-0.8; I hope I simplified the
> concepts a lot.

Yup, I figured that out, thanks.

> There is no tracking, and branches are trivial - branches correspond to
> repositories. When you do cg-init <remoterepo>, you get a branch origin
> which represents the remoterepo (and gets updated when you do cg-pull or
> cg-update), you can make Cogito know of more remote repositories by
> doing cg-branch-add.
> 
> 
> Yes, the README sucks; but apparently it helps at least some people. ;-)
> 
-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>

