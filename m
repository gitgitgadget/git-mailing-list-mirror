From: Bharani Prasad <bharaniprasadvs@gmail.com>
Subject: How to create branches above master
Date: Wed, 4 Aug 2010 00:22:01 -0700 (PDT)
Message-ID: <29342864.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 04 09:22:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OgYIl-0000Mo-L6
	for gcvg-git-2@lo.gmane.org; Wed, 04 Aug 2010 09:22:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757875Ab0HDHWF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Aug 2010 03:22:05 -0400
Received: from kuber.nabble.com ([216.139.236.158]:35790 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756188Ab0HDHWE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Aug 2010 03:22:04 -0400
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists@nabble.com>)
	id 1OgYIb-00049q-Oz
	for git@vger.kernel.org; Wed, 04 Aug 2010 00:22:01 -0700
X-Nabble-From: bharaniprasadvs@gmail.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152563>


Hi,

I am using git-repository along with gerrit server for code review, I want
to create branches called "Integration" branch & "Release" branch 

I got different projects which I need to integrate in "integrate" branch and
give it to testing and once the bugs are fixed it should go to "release"
branch. 

Currently we are using master and private branches...

Please do help me with this issue, as it is critical...

And also can you suggest me what can I use for Continuous build system in
Linux Fedora  

-- 
View this message in context: http://old.nabble.com/How-to-create-branches-above-master-tp29342864p29342864.html
Sent from the git mailing list archive at Nabble.com.
