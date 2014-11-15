From: Ryan Jacobs <ryan.mjacobs@gmail.com>
Subject: git push --all --tags
Date: Sat, 15 Nov 2014 04:44:19 +0000 (UTC)
Message-ID: <loom.20141115T054352-272@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 15 05:50:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XpVJV-00018u-Q5
	for gcvg-git-2@plane.gmane.org; Sat, 15 Nov 2014 05:50:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754735AbaKOEuK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Nov 2014 23:50:10 -0500
Received: from plane.gmane.org ([80.91.229.3]:51583 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754241AbaKOEuJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Nov 2014 23:50:09 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1XpVJE-00011s-Ta
	for git@vger.kernel.org; Sat, 15 Nov 2014 05:50:05 +0100
Received: from 107-132-54-136.lightspeed.frokca.sbcglobal.net ([107.132.54.136])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 15 Nov 2014 05:50:04 +0100
Received: from ryan.mjacobs by 107-132-54-136.lightspeed.frokca.sbcglobal.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 15 Nov 2014 05:50:04 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 107.132.54.136 (Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/37.0.2062.94 Safari/537.36)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

$ git push --all --tags
error: --all and --tags are incompatible

Why are these flags incompatible? Just wondering 'cause I think that it would 
be a good feature to be able to push all of your branches and all of your 
tags to the server in one quick and simple command.
