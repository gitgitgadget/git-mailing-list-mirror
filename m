From: walt <wa1ter@myrealbox.com>
Subject: Problem with Linus's git repository?
Date: Tue, 26 Jun 2007 07:45:23 -0700
Organization: none
Message-ID: <f5r8q5$pbr$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 26 17:21:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I3CrL-0000rU-42
	for gcvg-git@gmane.org; Tue, 26 Jun 2007 17:21:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755154AbXFZPVh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Jun 2007 11:21:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755870AbXFZPVh
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Jun 2007 11:21:37 -0400
Received: from main.gmane.org ([80.91.229.2]:36262 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755154AbXFZPVg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jun 2007 11:21:36 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1I3Ccd-0003lk-7F
	for git@vger.kernel.org; Tue, 26 Jun 2007 17:06:27 +0200
Received: from adsl-69-234-208-182.dsl.irvnca.pacbell.net ([69.234.208.182])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 26 Jun 2007 17:06:27 +0200
Received: from wa1ter by adsl-69-234-208-182.dsl.irvnca.pacbell.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 26 Jun 2007 17:06:27 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: adsl-69-234-208-182.dsl.irvnca.pacbell.net
User-Agent: Thunderbird 3.0a1pre (X11/20070626)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50964>

For two days I've been unable to pull from Linus's kernel
git repository.  The reason seems to be that HEAD is a
symlink to refs/heads/master, which appears to be missing.

I'm wondering if Linus's personal version of git is broken ;o)
