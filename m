From: Gerhard Wiesinger <lists@wiesinger.com>
Subject: Metadata and checkin file date
Date: Tue, 27 Apr 2010 07:23:57 +0200 (CEST)
Message-ID: <alpine.LFD.2.00.1004270719320.17234@bbs.intern>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 27 07:24:38 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O6dHc-00030f-8W
	for gcvg-git-2@lo.gmane.org; Tue, 27 Apr 2010 07:24:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752049Ab0D0FY2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Apr 2010 01:24:28 -0400
Received: from chello084112167138.7.11.vie.surfer.at ([84.112.167.138]:56293
	"EHLO wiesinger.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750849Ab0D0FY1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Apr 2010 01:24:27 -0400
X-Greylist: delayed 584 seconds by postgrey-1.27 at vger.kernel.org; Tue, 27 Apr 2010 01:24:26 EDT
Received: from bbs.intern (localhost [127.0.0.1])
	by wiesinger.com (8.14.4/8.14.4) with ESMTP id o3R5Nvwc017785
	for <git@vger.kernel.org>; Tue, 27 Apr 2010 07:23:57 +0200
Received: from localhost (gerhard@localhost)
	by bbs.intern (8.14.4/8.14.4/Submit) with ESMTP id o3R5NvfI017781
	for <git@vger.kernel.org>; Tue, 27 Apr 2010 07:23:57 +0200
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-MailScanner-Information-wiesinger-com: Please contact the ISP for more information
X-wiesinger-com-MailScanner-ID: o3R5Nvwc017785
X-MailScanner-wiesinger-com: Found to be clean
X-MailScanner-SpamCheck-wiesinger-com: not spam, SpamAssassin (not cached,
	score=-4.347, required 4.5, autolearn=not spam, ALL_TRUSTED -1.80,
	AWL 0.05, BAYES_00 -2.60)
X-MailScanner-From: lists@wiesinger.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145876>

Hello,

I'm new to git and I'm looking for the following features:
1.) Metadata for
   a.) directory versioning (e.g. add/rm, mv)
   b.) rights (basic: chmod, chow, chgrp, extended: extended attributes 
like ACLs and selinux), necessary for versioning e.g. /etc
2.) Original file dates (checkin date) on clone and pull (and not checkout 
date)

Is this possible? Any plans if missing?

Thnx.

Ciao,
Gerhard

--
http://www.wiesinger.com/
