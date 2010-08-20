From: Charles Brossollet <chbrosso@lltech.fr>
Subject: git diff shows no output
Date: Fri, 20 Aug 2010 15:02:35 +0200
Message-ID: <EBCC0FEA-1FF2-4909-BE80-DE280C9D6487@lltech.fr>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 20 15:10:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OmRMN-0001Fg-6c
	for gcvg-git-2@lo.gmane.org; Fri, 20 Aug 2010 15:10:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751642Ab0HTNKK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Aug 2010 09:10:10 -0400
Received: from zimbra-ne01.network-studio.com ([62.93.225.49]:52579 "EHLO
	zimbra-ne01.network-studio.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751211Ab0HTNKI convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Aug 2010 09:10:08 -0400
X-Greylist: delayed 447 seconds by postgrey-1.27 at vger.kernel.org; Fri, 20 Aug 2010 09:10:08 EDT
Received: from localhost (localhost.localdomain [127.0.0.1])
	by zimbra-ne01.network-studio.com (Postfix) with ESMTP id 8615C86125D
	for <git@vger.kernel.org>; Fri, 20 Aug 2010 15:02:34 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra-ne01.network-studio.com
Received: from zimbra-ne01.network-studio.com ([127.0.0.1])
	by localhost (zimbra-ne01.network-studio.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uxP9vxGYFyQR for <git@vger.kernel.org>;
	Fri, 20 Aug 2010 15:02:34 +0200 (CEST)
Received: from mac-cbrossol3.institut-langevin (babel.loa.espci.fr [193.54.80.96])
	by zimbra-ne01.network-studio.com (Postfix) with ESMTPSA id 5B37E86125A
	for <git@vger.kernel.org>; Fri, 20 Aug 2010 15:02:34 +0200 (CEST)
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154031>

Hello,

I'm a new user of git, and I meet a very strange behaviour with the git diff command.
I have modified stuff in a file, with changes both in the index and the working tree.

"git diff" shows nothing, while "git diff | cat" shows the diff, as well as "git diff>output.txt" puts diff in output.txt.
Quite Weird

I'm on Mac OS X 10.6.4, using git 1.7.2.1, installed via macports.

Best,
-- 
Charles
