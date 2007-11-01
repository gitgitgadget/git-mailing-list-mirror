From: Sergei Organov <osv@javad.com>
Subject: Where man git-format-patch sends me?
Date: Thu, 01 Nov 2007 16:58:43 +0300
Message-ID: <87lk9i2hkc.fsf@osv.gnss.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 01 14:59:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InaZd-0000kQ-HK
	for gcvg-git-2@gmane.org; Thu, 01 Nov 2007 14:59:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753541AbXKAN6v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Nov 2007 09:58:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753421AbXKAN6v
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Nov 2007 09:58:51 -0400
Received: from javad.com ([216.122.176.236]:4718 "EHLO javad.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753419AbXKAN6u (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Nov 2007 09:58:50 -0400
Received: from osv ([87.236.81.130])
	by javad.com (8.11.6/8.11.0) with ESMTP id lA1Dwmm50339
	for <git@vger.kernel.org>; Thu, 1 Nov 2007 13:58:49 GMT
	(envelope-from s.organov@javad.com)
Received: from osv by osv with local (Exim 4.63)
	(envelope-from <s.organov@javad.com>)
	id 1InaZH-00023A-6Z
	for git@vger.kernel.org; Thu, 01 Nov 2007 16:58:43 +0300
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62960>

$ man git-format-patch
[...]
OPTIONS
       -p     Generate patch (see section on generating patches)

       -u     Synonym for "-p".
[...]
$

1. Saying "-p generates patch" suggests that without -p git-format-patch
   will generate something else. It's rather confusing.

2. Where is this "section on generating patches"? I thought it could be
   in man git-diff, but it is not.

-- 
Sergei.
