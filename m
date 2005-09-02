From: David Woodhouse <dwmw2@infradead.org>
Subject: Re: empty patch-2.6.13-git? patches on ftp.kernel.org
Date: Fri, 02 Sep 2005 10:21:54 +0100
Message-ID: <1125652914.6928.27.camel@baythorne.infradead.org>
References: <Pine.BSO.4.62.0508311527340.10416@rudy.mif.pg.gda.pl>
	 <1125649389.6928.19.camel@baythorne.infradead.org>
	 <Pine.LNX.4.58.0509020159110.3613@evo.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Tomasz =?ISO-8859-1?Q?K=B3oczko?= <kloczek@rudy.mif.pg.gda.pl>,
	git@vger.kernel.org, linux-kernel@vger.kernel.org
X-From: linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751162AbVIBJV6@vger.kernel.org Fri Sep 02 11:24:29 2005
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751162AbVIBJV6@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EB7lB-0003ph-8l
	for glk-linux-kernel-3@gmane.org; Fri, 02 Sep 2005 11:22:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751162AbVIBJV6 (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Fri, 2 Sep 2005 05:21:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751163AbVIBJV6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 05:21:58 -0400
Received: from baythorne.infradead.org ([81.187.2.161]:15247 "EHLO
	baythorne.infradead.org") by vger.kernel.org with ESMTP
	id S1751162AbVIBJV5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 05:21:57 -0400
Received: from localhost ([127.0.0.1] helo=localhost.localdomain)
	by baythorne.infradead.org with esmtpsa (Exim 4.52 #1 (Red Hat Linux))
	id 1EB7kA-0005LC-NF; Fri, 02 Sep 2005 10:21:54 +0100
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0509020159110.3613@evo.osdl.org>
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by baythorne.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8012>

On Fri, 2005-09-02 at 02:00 -0700, Linus Torvalds wrote:
> Ahh. Please change that to
> 
>         rm -rf tmp-empty-tree
>         mkdir tmp-empty-tree
>         cd tmp-empty-tree
>         git-init-db
> 
> because otherwise you'll almost certainly hit something else later
> on..

OK, done. 

-- 
dwmw2
