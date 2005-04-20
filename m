From: Christian Meder <chris@absolutegiganten.org>
Subject: wit 0.0.3 - a web interface for git available
Date: Wed, 20 Apr 2005 02:29:11 +0200
Message-ID: <1113956951.3309.22.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Apr 20 02:25:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DO322-0000bP-OW
	for gcvg-git@gmane.org; Wed, 20 Apr 2005 02:25:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261257AbVDTA3h (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Apr 2005 20:29:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261253AbVDTA33
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Apr 2005 20:29:29 -0400
Received: from shadow.prohost.de ([216.71.84.228]:6244 "EHLO shadow.prohost.de")
	by vger.kernel.org with ESMTP id S261207AbVDTA3R (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Apr 2005 20:29:17 -0400
Received: from blue (p54A251DB.dip.t-dialin.net [84.162.81.219])
	by shadow.prohost.de (8.11.6/8.11.6) with ESMTP id j3K0TFG14800
	for <git@vger.kernel.org>; Wed, 20 Apr 2005 02:29:15 +0200
To: git@vger.kernel.org
X-Mailer: Evolution 2.0.4 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi,

ok it's starting to look like spam ;-)

I uploaded a new version of wit to http://www.absolutegiganten.org/wit

Wit is a web interface for git. Right now it includes: views of blob,
commit and tree objects, generating patches for the commits, downloading
of gz or bzip2 tarballs of trees.

It's easy to setup and a simple stand alone server configuration is
included.

Changes:
* first release which is tested on the current kernel.git archive
* fix diffTree output by using -r
* enhance the patch generation to work against multiple parents
* remove temporary files after diff generation
* fix the tar generation by using the recursive ls-tree variant
* disable colored link on tree objects

I still hope that I'll get feedback someday ;-)



				Christian

-- 
Christian Meder, email: chris@absolutegiganten.org

The Way-Seeking Mind of a tenzo is actualized 
by rolling up your sleeves.

                (Eihei Dogen Zenji)

