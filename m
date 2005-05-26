From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH Cogito] Fix cg-log -f behavior
Date: Thu, 26 May 2005 22:35:40 +0200
Message-ID: <1117139740.12036.59.camel@pegasus>
References: <1117137826.12036.57.camel@pegasus>
	 <7vk6llbv1j.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Petr Baudis <pasky@ucw.cz>, GIT Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 26 22:34:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DbP3H-0002wz-2L
	for gcvg-git@gmane.org; Thu, 26 May 2005 22:33:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261725AbVEZUfv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 May 2005 16:35:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261726AbVEZUfv
	(ORCPT <rfc822;git-outgoing>); Thu, 26 May 2005 16:35:51 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:65464 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S261725AbVEZUfr
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2005 16:35:47 -0400
Received: from pegasus (p5487D46C.dip.t-dialin.net [84.135.212.108])
	by mail.holtmann.net (8.12.3/8.12.3/Debian-7.1) with ESMTP id j4QKbLId019744
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NO);
	Thu, 26 May 2005 22:37:23 +0200
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vk6llbv1j.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Evolution 2.2.2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi Junio,

> Doesn't that still break one-tree case (i.e. [ -z $tree2 ])?

I am not sure, because I never tried it. Does it use a different format?

Regards

Marcel


