From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH Cogito] Improve option parsing for cg-log
Date: Thu, 12 May 2005 23:49:46 +0200
Message-ID: <1115934586.18499.70.camel@pegasus>
References: <1115931114.18499.66.camel@pegasus>
	 <20050512211315.GP324@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 12 23:44:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWLSn-0001q1-SD
	for gcvg-git@gmane.org; Thu, 12 May 2005 23:43:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262150AbVELVul (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 May 2005 17:50:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262147AbVELVul
	(ORCPT <rfc822;git-outgoing>); Thu, 12 May 2005 17:50:41 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:10161 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S262146AbVELVt2
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2005 17:49:28 -0400
Received: from pegasus (p5487C16D.dip.t-dialin.net [84.135.193.109])
	by mail.holtmann.net (8.12.3/8.12.3/Debian-7.1) with ESMTP id j4CLoiWX019299
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NO);
	Thu, 12 May 2005 23:50:45 +0200
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050512211315.GP324@pasky.ji.cz>
X-Mailer: Evolution 2.2.2 
X-Virus-Scanned: ClamAV 0.83/875/Tue May 10 13:27:59 2005 on coyote.holtmann.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi Petr,

> > the attached patch changes the option parsing, because otherwise we are
> > stuck to a specific order.
> 
> thanks, applied. However, you didn't include the -r options parsing in
> there yet.

what do you mean by that?

Regards

Marcel


