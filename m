From: Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: gitweb on kernel.org lies?
Date: Tue, 03 May 2005 12:52:17 +0200
Message-ID: <1115117537.21105.53.camel@localhost.localdomain>
References: <1115109604.8508.34.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 03 12:48:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DSuun-0005Op-22
	for gcvg-git@gmane.org; Tue, 03 May 2005 12:46:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261446AbVECKwV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 May 2005 06:52:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261449AbVECKwV
	(ORCPT <rfc822;git-outgoing>); Tue, 3 May 2005 06:52:21 -0400
Received: from soundwarez.org ([217.160.171.123]:6862 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S261446AbVECKwT (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 May 2005 06:52:19 -0400
Received: from dhcp-113.off.vrfy.org (c169067.adsl.hansenet.de [213.39.169.67])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	by soundwarez.org (Postfix) with ESMTP id 93AB22BE95;
	Tue,  3 May 2005 12:52:16 +0200 (CEST)
To: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1115109604.8508.34.camel@localhost.localdomain>
X-Mailer: Evolution 2.2.2 (2.2.2-1) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, 2005-05-03 at 09:40 +0100, David Woodhouse wrote:
> http://www.kernel.org/git/gitweb.cgi?p=linux%2Fkernel%2Fgit%2Fdwmw2%2Faudit-2.6.git;a=log
> doesn't seem to show the commits which were just put there. Why?

The HEAD:
  ftp://kernel.org/pub/scm/linux/kernel/git/dwmw2/audit-2.6.git/HEAD

points to:
  42d4dc3f4e1ec1396371aac89d0dccfdd977191b
  authorBenjamin Herrenschmidt <benh@kernel.crashing.org>
  Fri, 29 Apr 2005 14:40:12 +0000 (07:40 -0700)

which is 3 days old, right?

Kay

