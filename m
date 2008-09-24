From: pasky@suse.cz
Subject: [PATCH 0/5] git-gui: Remotes manipulation enhancements
Date: Wed, 24 Sep 2008 22:43:58 +0200
Message-ID: <20080924204358.144077183@suse.cz>
Cc: spearce@spearce.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 24 22:47:43 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KibGq-0002ed-8i
	for gcvg-git-2@gmane.org; Wed, 24 Sep 2008 22:47:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752539AbYIXUq0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Sep 2008 16:46:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752444AbYIXUq0
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Sep 2008 16:46:26 -0400
Received: from [212.249.11.140] ([212.249.11.140]:46827 "EHLO pixie.suse.cz"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752202AbYIXUqZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Sep 2008 16:46:25 -0400
Received: by pixie.suse.cz (Postfix, from userid 2001)
	id 3A4FE2AC8FA; Wed, 24 Sep 2008 22:46:13 +0200 (CEST)
User-Agent: quilt/0.46_cvs20080326-19.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96690>

This patch series implements various remotes manipulation enhancements,
hopefully eliminating the main remaining gap in git-gui functionality.

I hope this will go ok... the general atrocity of git send-email forced me to
actually send out this TopGit patch queue using quilt mail for now.
