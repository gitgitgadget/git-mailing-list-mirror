From: Marco Costalba <mcostalba@yahoo.it>
Subject: qgit-0.4
Date: Fri, 10 Jun 2005 11:35:37 -0700 (PDT)
Message-ID: <20050610183537.39108.qmail@web26301.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Fri Jun 10 20:32:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DgoIA-0000UO-5Q
	for gcvg-git@gmane.org; Fri, 10 Jun 2005 20:31:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261165AbVFJSfo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Jun 2005 14:35:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261167AbVFJSfo
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Jun 2005 14:35:44 -0400
Received: from web26301.mail.ukl.yahoo.com ([217.146.176.12]:57001 "HELO
	web26301.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S261165AbVFJSfi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jun 2005 14:35:38 -0400
Received: (qmail 39110 invoked by uid 60001); 10 Jun 2005 18:35:37 -0000
Received: from [151.38.74.248] by web26301.mail.ukl.yahoo.com via HTTP; Fri, 10 Jun 2005 11:35:37 PDT
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Here is qgit-0.4, a git GUI viewer

New in this version:

- file history

- command line arguments passed to git-rev-list, eg: qgit v2.6.12-rc6 ^v2.6.12-rc4

- complete rewrite of start-up thread, should be faster now, expecially with warm start

You can download from 
http://prdownloads.sourceforge.net/qgit/qgit-0.4.tar.gz?download

To try qgit:

1) Unpack downloaded tar file
2) ./configure
3) make
4) cd bin
5) copy qgit file anywhere in your path

There are also some screenshots:
http://sourceforge.net/project/screenshots.php?group_id=139897&ssid=13524

Have fun
Marco

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
