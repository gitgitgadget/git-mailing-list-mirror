From: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
Subject: most commonly used git commands?
Date: Mon, 25 Jun 2007 09:40:17 +0300
Message-ID: <20070625064017.GA2839@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 25 08:40:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2iF9-000391-GD
	for gcvg-git@gmane.org; Mon, 25 Jun 2007 08:40:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753678AbXFYGkK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Jun 2007 02:40:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753644AbXFYGkK
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jun 2007 02:40:10 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:10509 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753484AbXFYGkI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jun 2007 02:40:08 -0400
Received: by ug-out-1314.google.com with SMTP id j3so1224720ugf
        for <git@vger.kernel.org>; Sun, 24 Jun 2007 23:40:07 -0700 (PDT)
Received: by 10.66.243.2 with SMTP id q2mr4950045ugh.1182753606967;
        Sun, 24 Jun 2007 23:40:06 -0700 (PDT)
Received: from ?127.0.0.1? ( [194.90.237.34])
        by mx.google.com with ESMTP id o1sm232407uge.2007.06.24.23.40.05
        (version=SSLv3 cipher=OTHER);
        Sun, 24 Jun 2007 23:40:06 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50865>

I did this by mistake:

$git fet linux-2.6
git: 'fet' is not a git-command

The most commonly used git commands are:
   add     Add file contents to the changeset to be committed next
   apply   Apply a patch on a git index file and a working tree
(use 'git help -a' to get a list of all installed git commands)

why does git say that add and apply are most commonly used git commands?

-- 
MST
