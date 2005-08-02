From: Sebastian Kuzminsky <seb@highlab.com>
Subject: cogito missing asciidoc.conf?
Date: Tue, 02 Aug 2005 16:40:35 -0600
Message-ID: <E1E05R5-0005Pz-J9@highlab.com>
X-From: git-owner@vger.kernel.org Wed Aug 03 00:42:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E05RT-0008OL-Vu
	for gcvg-git@gmane.org; Wed, 03 Aug 2005 00:41:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261864AbVHBWj7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 2 Aug 2005 18:39:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261895AbVHBWj7
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Aug 2005 18:39:59 -0400
Received: from rwcrmhc11.comcast.net ([216.148.227.117]:60815 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S261864AbVHBWix (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Aug 2005 18:38:53 -0400
Received: from highlab.com ([67.165.222.77])
          by comcast.net (rwcrmhc11) with ESMTP
          id <200508022238520130029k32e>; Tue, 2 Aug 2005 22:38:52 +0000
Received: from seb (helo=highlab.com)
	by highlab.com with local-esmtp (Exim 4.50)
	id 1E05R5-0005Pz-J9
	for git@vger.kernel.org; Tue, 02 Aug 2005 16:40:35 -0600
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Or am I missing something?

The most recent commit to cogito makes the documentation depend on
asciidoc.conf, but it looks like the actual config file was not added.

-- 
Sebastian Kuzminsky
