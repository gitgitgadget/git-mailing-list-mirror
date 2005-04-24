From: Kay Sievers <kay.sievers@vrfy.org>
Subject: gitweb.pl
Date: Sun, 24 Apr 2005 17:23:57 +0200
Message-ID: <1114356237.22541.21.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Greg KH <greg@kroah.com>, "H. Peter Anvin" <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Sun Apr 24 17:20:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPitn-0004Ge-6g
	for gcvg-git@gmane.org; Sun, 24 Apr 2005 17:19:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262341AbVDXPYD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Apr 2005 11:24:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262342AbVDXPYD
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Apr 2005 11:24:03 -0400
Received: from soundwarez.org ([217.160.171.123]:29848 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S262341AbVDXPX6 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Apr 2005 11:23:58 -0400
Received: from dhcp-113.off.vrfy.org (c219006.adsl.hansenet.de [213.39.219.6])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	by soundwarez.org (Postfix) with ESMTP id 3A2D224665;
	Sun, 24 Apr 2005 17:23:57 +0200 (CEST)
To: git@vger.kernel.org
X-Mailer: Evolution 2.2.2 (2.2.2-1) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

We have a new improved version of the git web-interface:
  http://ehlo.org/~kay/gitweb.pl

You can download it from:
  ftp://ehlo.org/gitweb.pl


gitweb exports now a simple RSS feed: :)
  http://ehlo.org/~kay/gitweb.pl/linux-2.6/rss

gitweb accepts now a whole path instead of only a name to a project.
Example:
  ftp://kernel.org/pub/scm/linux/kernel/git/gregkh/usb-2.6.git/
gitweb-URL:
  http://kernel.org/cgi-bin/gitweb.pl/pub/scm/linux/kernel/git/gregkh/usb-2.6.git/

Thanks,
Kay

