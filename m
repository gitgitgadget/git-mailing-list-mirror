From: Darrin Thompson <darrint@progeny.com>
Subject: Re: Patch (apply) vs. Pull
Date: Mon, 20 Jun 2005 18:01:42 -0500
Message-ID: <1119308502.3926.18.camel@localhost.localdomain>
References: <1119284365.3926.15.camel@localhost.localdomain>
	 <7vbr61j631.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 21 06:44:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dkaca-0005Gk-4Y
	for gcvg-git@gmane.org; Tue, 21 Jun 2005 06:44:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261195AbVFUEpE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 21 Jun 2005 00:45:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261616AbVFTW5T
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Jun 2005 18:57:19 -0400
Received: from zealot.progeny.com ([216.37.46.162]:54500 "EHLO
	morimoto.progeny.com") by vger.kernel.org with ESMTP
	id S261574AbVFTW4p (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jun 2005 18:56:45 -0400
Received: from dhcp-2-246.progeny.com (dhcp-2-246.progeny.com [192.168.2.246])
	by morimoto.progeny.com (Postfix) with ESMTP
	id 8788363783; Mon, 20 Jun 2005 17:56:40 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vbr61j631.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Evolution 2.0.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Mon, 2005-06-20 at 10:22 -0700, Junio C Hamano wrote:
>  (6) Throw away my HEAD, making Linus HEAD my HEAD, while
>      preserving changes I have made since I forked from him.  I
>      use "jit-rewind" for this.

When you say it that way it sounds so _bad_. :-)

Would it make sense to come up with a way to make an emailed series of
patches represent a series of commits? Could patches still be
cherrypicked?

--
Darrin


