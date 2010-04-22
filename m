From: Eli Barzilay <eli@barzilay.org>
Subject: diff without num-stat
Date: Thu, 22 Apr 2010 15:02:18 -0400
Message-ID: <19408.40250.102191.314496@winooski.ccs.neu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 23 01:47:23 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O5678-00070j-Jp
	for gcvg-git-2@lo.gmane.org; Fri, 23 Apr 2010 01:47:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754040Ab0DVXrR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Apr 2010 19:47:17 -0400
Received: from winooski.ccs.neu.edu ([129.10.115.117]:35314 "EHLO barzilay.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754028Ab0DVXrQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Apr 2010 19:47:16 -0400
Received: from eli by barzilay.org with local (Exim 4.66)
	(envelope-from <eli@barzilay.org>)
	id 1O51fG-0005o3-3g
	for git@vger.kernel.org; Thu, 22 Apr 2010 15:02:18 -0400
X-Mailer: VM 8.0.12 under 23.1.1 (x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145580>

`git diff' has a `--numstat' flag, but is there any way to *avoid* the
numstat?  (I'm using `--stat' but want to void the summary line, and
I'd like to avoid piping it to `head'.)
-- 
          ((lambda (x) (x x)) (lambda (x) (x x)))          Eli Barzilay:
                    http://barzilay.org/                   Maze is Life!
