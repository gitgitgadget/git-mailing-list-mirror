From: Nick Hengeveld <nickh@reactrix.com>
Subject: [PATCH 0/3] http-fetch enhancements
Date: Mon, 26 Sep 2005 10:51:49 -0700
Message-ID: <20050926175148.GA9410@reactrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Sep 26 19:54:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EJx8v-0005js-1w
	for gcvg-git@gmane.org; Mon, 26 Sep 2005 19:51:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932444AbVIZRvy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Sep 2005 13:51:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932445AbVIZRvy
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Sep 2005 13:51:54 -0400
Received: from 195.37.26.69.virtela.com ([69.26.37.195]:62711 "EHLO
	teapot.corp.reactrix.com") by vger.kernel.org with ESMTP
	id S932444AbVIZRvx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Sep 2005 13:51:53 -0400
Received: from teapot.corp.reactrix.com (localhost.localdomain [127.0.0.1])
	by teapot.corp.reactrix.com (8.12.11/8.12.11) with ESMTP id j8QHpnts009429
	for <git@vger.kernel.org>; Mon, 26 Sep 2005 10:51:49 -0700
Received: (from nickh@localhost)
	by teapot.corp.reactrix.com (8.12.11/8.12.11/Submit) id j8QHpnKY009427
	for git@vger.kernel.org; Mon, 26 Sep 2005 10:51:49 -0700
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9314>

The following series contains some http-fetch enhancements, based on
our requirements for use of SSL client certificates and partial HTTP
transfers.

-- 
For a successful technology, reality must take precedence over public
relations, for nature cannot be fooled.
