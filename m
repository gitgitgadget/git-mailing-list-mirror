From: Xavier Maillard <zedek@gnu.org>
Subject: git-blame.el won't run
Date: Wed, 14 Feb 2007 23:35:35 +0100
Message-ID: <13283.1171492535@localhost>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 14 23:38:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHSlh-0006BM-8E
	for gcvg-git@gmane.org; Wed, 14 Feb 2007 23:38:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932670AbXBNWiX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Feb 2007 17:38:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932668AbXBNWiX
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Feb 2007 17:38:23 -0500
Received: from smtp1-g19.free.fr ([212.27.42.27]:59649 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932670AbXBNWiW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Feb 2007 17:38:22 -0500
Received: from localhost.localdomain (chn51-3-88-163-173-156.fbx.proxad.net [88.163.173.156])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 3A9589B71F
	for <git@vger.kernel.org>; Wed, 14 Feb 2007 23:38:21 +0100 (CET)
Received: from localhost (IDENT:1001@localhost [127.0.0.1])
	by localhost.localdomain (8.13.8/8.13.8) with ESMTP id l1EMZZu4013284
	for <git@vger.kernel.org>; Wed, 14 Feb 2007 23:35:35 +0100
X-Mailer: MH-E 8.0.2; nmh 1.2; GNU Emacs 22.0.51
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39767>

Hi,

I was happy to see that latest git's git included an emacs mode
for git-blame.

Sadly, when trying it, I just have this displayed into *Messages*
buffer: 

Setting up indent for shell type bash
setting up indent stuff
Indentation variable are now local.
Indentation setup for shell type bash
let: Process git-blame not running

If I launch git-blame manually onto the file from command line,
it works.

It is on a emacs 22 (aka CVS version).

Xavier
