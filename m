From: Richard Lee <richard@webdezign.co.uk>
Subject: Moving git
Date: Fri, 16 Oct 2009 07:58:47 -0700 (PDT)
Message-ID: <25926819.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 16 17:03:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MyoL0-0005Lv-86
	for gcvg-git-2@lo.gmane.org; Fri, 16 Oct 2009 17:03:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760592AbZJPO7X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Oct 2009 10:59:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760581AbZJPO7X
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Oct 2009 10:59:23 -0400
Received: from kuber.nabble.com ([216.139.236.158]:38022 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759560AbZJPO7X (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Oct 2009 10:59:23 -0400
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists@nabble.com>)
	id 1MyoGV-0000fk-4F
	for git@vger.kernel.org; Fri, 16 Oct 2009 07:58:47 -0700
X-Nabble-From: richard@webdezign.co.uk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130501>


Hi Git forum,

I've just started using git yesterday, so I'm very new. So please excuse if
I've done something the wrong way.

I cloned a git directory/repository? and then moved it. I'm trying to prune
branches and it gives

]fatal: '/var/www/vhosts/mydomain.co.uk/b2.git': unable to chdir or not a
git archive
fatal: The remote end hung up unexpectedly
ls-remote --heads /var/www/vhosts/mydomain.co.uk/b2.git: command returned
error: 1

b2.git was the cloned bare thing I create following the instruction here:

http://book.git-scm.com/4_setting_up_a_private_repository.html

Is there someway I can get git to update the git base directory?

Richard

-- 
View this message in context: http://www.nabble.com/Moving-git-tp25926819p25926819.html
Sent from the git mailing list archive at Nabble.com.
