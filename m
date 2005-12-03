From: Fredrik Kuivinen <freku045@student.liu.se>
Subject: [PATCH 0/4] Merge test cases
Date: Sat, 3 Dec 2005 11:32:55 +0100
Message-ID: <20051203103255.GA4896@c165.ib.student.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 03 11:33:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EiUhn-0002go-EV
	for gcvg-git@gmane.org; Sat, 03 Dec 2005 11:33:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751230AbVLCKdE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Dec 2005 05:33:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751210AbVLCKdD
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Dec 2005 05:33:03 -0500
Received: from [85.8.31.11] ([85.8.31.11]:51133 "EHLO mail6.wasadata.com")
	by vger.kernel.org with ESMTP id S1751230AbVLCKdD (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 3 Dec 2005 05:33:03 -0500
Received: from c165 (unknown [85.8.2.189])
	by mail6.wasadata.com (Postfix) with ESMTP
	id 7DBDC4116; Sat,  3 Dec 2005 11:42:46 +0100 (CET)
Received: from ksorim by c165 with local (Exim 3.36 #1 (Debian))
	id 1EiUhL-0000JU-00; Sat, 03 Dec 2005 11:32:55 +0100
To: junkio@cox.net
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13149>

This series adds two test cases for merge strategies. The first one
test that something sensible is done in case of directory/file
conflicts, the second one tests a criss-cross merge.

- Fredrik
