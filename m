From: Marco Costalba <mcostalba@yahoo.it>
Subject: qgit-0.5
Date: Sun, 12 Jun 2005 06:35:40 -0700 (PDT)
Message-ID: <20050612133540.20892.qmail@web26304.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Sun Jun 12 15:32:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DhSZK-00012m-2b
	for gcvg-git@gmane.org; Sun, 12 Jun 2005 15:32:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262548AbVFLNgN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Jun 2005 09:36:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262554AbVFLNgN
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Jun 2005 09:36:13 -0400
Received: from web26304.mail.ukl.yahoo.com ([217.146.176.15]:63325 "HELO
	web26304.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S262548AbVFLNft (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Jun 2005 09:35:49 -0400
Received: (qmail 20894 invoked by uid 60001); 12 Jun 2005 13:35:40 -0000
Received: from [151.38.74.248] by web26304.mail.ukl.yahoo.com via HTTP; Sun, 12 Jun 2005 06:35:40 PDT
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Here is qgit-0.5, a git GUI viewer

New in this version:

- selection of diff target: parent (default), HEAD or a choosen SHA;
  SHA to diff with can be inserted manually, with copy/paste or
  directly selected with CTRL + MOUSE PRESS on the log viewer (see screenshots)

- yellow background on tags in log viewer

- alternate background color in log viewer

- thanks to Stanislav Karchebny scons build problems should be
  resolved now


You can download from 
http://prdownloads.sourceforge.net/qgit/qgit-0.5.tar.bz2?download

To try qgit:

1) Unpack downloaded file
2) make
3) cd bin
4) copy qgit bin file anywhere in your path

Tip: try to browse file history with diff viewer open (screenshot below)
http://sourceforge.net/project/screenshots.php?group_id=139897

There are also some (new) screenshots:
http://sourceforge.net/project/screenshots.php?group_id=139897&ssid=13699
http://sourceforge.net/project/screenshots.php?group_id=139897&ssid=13695


Marco

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
