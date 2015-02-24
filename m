From: Tom <tdmoretto@hotmail.com>
Subject: assistance with git error
Date: Tue, 24 Feb 2015 20:40:56 +0000 (UTC)
Message-ID: <loom.20150224T213812-434@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 24 21:45:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YQMM2-0006Re-6b
	for gcvg-git-2@plane.gmane.org; Tue, 24 Feb 2015 21:45:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752389AbbBXUpL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Feb 2015 15:45:11 -0500
Received: from plane.gmane.org ([80.91.229.3]:40789 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751908AbbBXUpK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Feb 2015 15:45:10 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1YQMLn-0006IW-Al
	for git@vger.kernel.org; Tue, 24 Feb 2015 21:45:03 +0100
Received: from cpe-098-027-052-193.nc.res.rr.com ([98.27.52.193])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 24 Feb 2015 21:45:03 +0100
Received: from tdmoretto by cpe-098-027-052-193.nc.res.rr.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 24 Feb 2015 21:45:03 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 98.27.52.193 (Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/40.0.2214.115 Safari/537.36)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264345>

Could someone provide me some assistance with troubleshooting the following:

remote: Counting objects: 31654, done.
error: pack-objects died of signal 99568/19585)   
error: git upload-pack: git-pack-objects died with error.
fatal: git upload-pack: aborting due to possible repository
corruption on the remote side.
remote: aborting due to possible repository corruption on the remote side.
fatal: early EOF
fatal: index-pack failed


i know next to nothing about git and was asked to resolve this issue.

thank you.
tom
