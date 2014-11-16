From: Yoni Tsafir <yonix85@gmail.com>
Subject: Re: [PATCH/RFC v2 1/2] submodule: add ability to shallowly clone any branch in a repo as a submodule
Date: Sun, 16 Nov 2014 09:55:47 +0000 (UTC)
Message-ID: <loom.20141116T105506-725@post.gmane.org>
References: <1410777721-602-1-git-send-email-cole.minnaar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 16 11:00:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xpwcy-0001Ho-HF
	for gcvg-git-2@plane.gmane.org; Sun, 16 Nov 2014 11:00:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755148AbaKPKAJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Nov 2014 05:00:09 -0500
Received: from plane.gmane.org ([80.91.229.3]:60493 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754825AbaKPKAH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Nov 2014 05:00:07 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Xpwcm-0001Ds-Nl
	for git@vger.kernel.org; Sun, 16 Nov 2014 11:00:04 +0100
Received: from bzq-213-168-31-104.red.bezeqint.net ([31.168.213.104])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 16 Nov 2014 11:00:04 +0100
Received: from yonix85 by bzq-213-168-31-104.red.bezeqint.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 16 Nov 2014 11:00:04 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 31.168.213.104 (Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10) AppleWebKit/600.1.25 (KHTML, like Gecko) Version/8.0 Safari/600.1.25)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Was this accepted?
I am also interested at this behavior or some kind of other solution to 
git submodule --depth combined with a branch.
