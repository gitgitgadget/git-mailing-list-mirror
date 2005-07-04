From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: expensive local git clone
Date: Mon, 4 Jul 2005 14:44:08 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0507041443510.3570@g5.osdl.org>
References: <20050704.125744.59481768.davem@davemloft.net>
 <Pine.LNX.4.58.0507041327580.3570@g5.osdl.org> <20050704204235.GE21128@pasky.ji.cz>
 <20050704.140043.112609056.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: pasky@suse.cz, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 04 23:44:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DpYjy-0000UT-Af
	for gcvg-git@gmane.org; Mon, 04 Jul 2005 23:44:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261701AbVGDVoW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Jul 2005 17:44:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261702AbVGDVoW
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jul 2005 17:44:22 -0400
Received: from smtp.osdl.org ([65.172.181.4]:19425 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261701AbVGDVoR (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Jul 2005 17:44:17 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j64LiAjA022876
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 4 Jul 2005 14:44:10 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j64Li8cO004934;
	Mon, 4 Jul 2005 14:44:09 -0700
To: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20050704.140043.112609056.davem@davemloft.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.111 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Mon, 4 Jul 2005, David S. Miller wrote:
> 
> I keep hoping git-clone-script is going to be a good way
> to clone two local trees.  Is my hope misguided?  :-)

Well, I'm not working on it, but tested patches...

		Linus
