From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] Add cg-printenv command.
Date: Mon, 09 May 2005 03:19:00 +0200
Message-ID: <1115601540.8949.104.camel@pegasus>
References: <200505081911.10371.elenstev@mesatop.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Petr Baudis <pasky@ucw.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 09 03:11:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DUwo0-0000v0-67
	for gcvg-git@gmane.org; Mon, 09 May 2005 03:11:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263020AbVEIBSl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 May 2005 21:18:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263021AbVEIBSl
	(ORCPT <rfc822;git-outgoing>); Sun, 8 May 2005 21:18:41 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:10670 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S263020AbVEIBSk
	(ORCPT <rfc822;git@vger.kernel.org>); Sun, 8 May 2005 21:18:40 -0400
Received: from pegasus (p5487DDD1.dip.t-dialin.net [84.135.221.209])
	by mail.holtmann.net (8.12.3/8.12.3/Debian-7.1) with ESMTP id j491JtWX008487
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NO);
	Mon, 9 May 2005 03:19:55 +0200
To: Steven Cole <elenstev@mesatop.com>
In-Reply-To: <200505081911.10371.elenstev@mesatop.com>
X-Mailer: Evolution 2.2.2 
X-Virus-Scanned: ClamAV version 0.83, clamav-milter version 0.83 on coyote.holtmann.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi Steven,

> The cg-printenv command will print exported git environment variables.

I like that idea. It is much more handy then using env and grep for the
variable names.

Regards

Marcel


