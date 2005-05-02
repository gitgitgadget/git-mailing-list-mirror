From: Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: description
Date: Mon, 02 May 2005 04:42:20 +0200
Message-ID: <1115001740.3449.30.camel@localhost.localdomain>
References: <4272CDF1.9060207@zytor.com>  <20050430124327.GA8942@vrfy.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 02 04:40:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DSQqk-0005GG-24
	for gcvg-git@gmane.org; Mon, 02 May 2005 04:39:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261768AbVEBCpg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 May 2005 22:45:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261810AbVEBCnm
	(ORCPT <rfc822;git-outgoing>); Sun, 1 May 2005 22:43:42 -0400
Received: from soundwarez.org ([217.160.171.123]:19436 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S261768AbVEBCmW (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 1 May 2005 22:42:22 -0400
Received: from dhcp-113.off.vrfy.org (d009008.adsl.hansenet.de [80.171.9.8])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	by soundwarez.org (Postfix) with ESMTP id 3151929B6D;
	Mon,  2 May 2005 04:42:20 +0200 (CEST)
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <20050430124327.GA8942@vrfy.org>
X-Mailer: Evolution 2.2.2 (2.2.2-1) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sat, 2005-04-30 at 14:43 +0200, Kay Sievers wrote:
> Here is a new gitweb.cgi version that integrates with that page. The
> own project browser is removed now and the top-link points now to your
> link-list.
> 
> !! It already uses the new binaries with the git-* prepended. !!
> 
> See it working here:
>   http://ehlo.org/~kay/git/
> 
> Get the cgi from here:
>   ftp://ehlo.org/git/gitweb.cgi
> 
> !! Just remove lines 26-30, which are the settings to run on my box. !!

We've put a new version online. It's almost complete for a first basic
version and Christian and me can go back to "real" work now. :)

The version running on kernel.org shows a broken commit time, so it
would be nice, if it can be replaced.

Thanks,
Kay

