From: "Joakim Tjernlund" <joakim.tjernlund@transmode.se>
Subject: GIT_DIR/--git-dir question
Date: Thu, 8 Nov 2007 20:06:07 +0100
Message-ID: <007c01c8223a$6af2e550$5267a8c0@Jocke>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Nov 08 20:06:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqCiB-0001Vl-8K
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 20:06:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760893AbXKHTG1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2007 14:06:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754674AbXKHTG1
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 14:06:27 -0500
Received: from mail.transmode.se ([83.241.175.147]:59214 "EHLO
	tmnt04.transmode.se" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759203AbXKHTG0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2007 14:06:26 -0500
Received: from Jocke ([84.217.6.238]) by tmnt04.transmode.se with Microsoft SMTPSVC(5.0.2195.6713);
	 Thu, 8 Nov 2007 20:06:23 +0100
X-Mailer: Microsoft Office Outlook 11
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.3198
Thread-Index: AcgiOmpXgYH1i1WZTmCGoqrtwVdiIA==
X-OriginalArrivalTime: 08 Nov 2007 19:06:23.0349 (UTC) FILETIME=[743A6250:01C8223A]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64064>

I just started to look at having multiple work trees, each working on a separate branch,
using the same git repo.

GIT_DIR/--git-dir seems to be what I am looking for but I wonder if there
is a way to store the value of GIT_DIR/--git-dir in the working tree
somehow?

  Jocke
