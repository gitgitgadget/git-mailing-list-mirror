From: Christian Meder <chris@absolutegiganten.org>
Subject: wit 0.0.2 - a web interface for git available
Date: Tue, 19 Apr 2005 23:15:32 +0200
Message-ID: <1113945332.3309.15.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Apr 19 23:13:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DO01B-00058c-TZ
	for gcvg-git@gmane.org; Tue, 19 Apr 2005 23:12:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261688AbVDSVQI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Apr 2005 17:16:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261686AbVDSVQI
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Apr 2005 17:16:08 -0400
Received: from shadow.prohost.de ([216.71.84.228]:40440 "EHLO
	shadow.prohost.de") by vger.kernel.org with ESMTP id S261692AbVDSVPs
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2005 17:15:48 -0400
Received: from blue (p54A251DB.dip.t-dialin.net [84.162.81.219])
	by shadow.prohost.de (8.11.6/8.11.6) with ESMTP id j3JLFZW25656
	for <git@vger.kernel.org>; Tue, 19 Apr 2005 23:15:35 +0200
To: git@vger.kernel.org
X-Mailer: Evolution 2.0.4 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi,

I've uploaded a new wit to http://www.absolutegiganten.org/wit

Wit is a web interface for git. Right now it includes: views of blob,
commit and tree objects, generating patches for the commits, downloading
of gz or bzip2 tarballs of trees.

It's easy to setup and a simple stand alone server configuration is
included.

Changes:

* the html doesn't look like total crap anymore
* generates patches against one parent on the fly
* generates gz or bzip2 tarballs on the fly

Feedback is greatly appreciated.

Greetings,


				Christian
  
-- 
Christian Meder, email: chris@absolutegiganten.org

The Way-Seeking Mind of a tenzo is actualized 
by rolling up your sleeves.

                (Eihei Dogen Zenji)

