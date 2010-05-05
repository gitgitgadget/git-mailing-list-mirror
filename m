From: santos2010 <santos.claudia2009@googlemail.com>
Subject: Unable to commit with TortoiseGIT 1.4.4.0 for Windows
Date: Wed, 5 May 2010 01:30:58 -0700 (PDT)
Message-ID: <1273048258216-5007790.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 05 10:32:31 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O9a1v-0000oF-2U
	for gcvg-git-2@lo.gmane.org; Wed, 05 May 2010 10:32:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933732Ab0EEIbE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 May 2010 04:31:04 -0400
Received: from kuber.nabble.com ([216.139.236.158]:37699 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933683Ab0EEIbB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 May 2010 04:31:01 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <santos.claudia2009@googlemail.com>)
	id 1O9a0Q-0004HH-7c
	for git@vger.kernel.org; Wed, 05 May 2010 01:30:58 -0700
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146382>


Hello all,


With cygwin+git i don't have any problems to commit. But if i try to use
TortoiseGIT i got this error:

error: unable to create temporary sha1 filename

I checked the security permissions for the repository and the system user
has full control.
Any ideas?

Thanks in advance.

Santos
-- 
View this message in context: http://git.661346.n2.nabble.com/Unable-to-commit-with-TortoiseGIT-1-4-4-0-for-Windows-tp5007790p5007790.html
Sent from the git mailing list archive at Nabble.com.
