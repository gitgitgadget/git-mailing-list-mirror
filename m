From: Gilbert Liddell <gliddell@totalrepair.co.uk>
Subject: svn clone Checksum mismatch question
Date: Thu, 26 Mar 2009 03:31:53 -0700 (PDT)
Message-ID: <22719363.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 26 11:33:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lmmu0-0006kL-Jf
	for gcvg-git-2@gmane.org; Thu, 26 Mar 2009 11:33:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752121AbZCZKb5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Mar 2009 06:31:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751401AbZCZKb5
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Mar 2009 06:31:57 -0400
Received: from kuber.nabble.com ([216.139.236.158]:34578 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751175AbZCZKb4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Mar 2009 06:31:56 -0400
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists@nabble.com>)
	id 1LmmsL-0005zj-U0
	for git@vger.kernel.org; Thu, 26 Mar 2009 03:31:53 -0700
X-Nabble-From: gliddell@totalrepair.co.uk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114769>


Hi,

I've just started using GIT this week, currently the project i'm working on
is held in subversion. I tested git svn clone with a small test project
(about 10 files) which worked a treat.

This morning i decided to test the clone with the full project i'm working
on (11,000 files) and I get the error message Checksum mismatch: vn2.sln
0f7a82f1d38b819 expected: fde799e5ba0d1d07e6b539016bea3260
got: e71db1010a0da06ea76d4163c452df72

Can someone help with why this error is happening? Is there an issue with
the GIT clone and large repositories?

Thanks in advance for your help,
Gilbert.
-- 
View this message in context: http://www.nabble.com/svn-clone-Checksum-mismatch-question-tp22719363p22719363.html
Sent from the git mailing list archive at Nabble.com.
