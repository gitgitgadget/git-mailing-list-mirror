From: "Joakim Tjernlund" <joakim.tjernlund@transmode.se>
Subject: Backing git repos to tape?
Date: Sun, 25 Nov 2007 11:58:41 +0100
Message-ID: <027601c82f52$2433fdf0$5267a8c0@Jocke>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Nov 25 11:59:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IwFCd-0004zx-8R
	for gcvg-git-2@gmane.org; Sun, 25 Nov 2007 11:59:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752336AbXKYK6s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Nov 2007 05:58:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752273AbXKYK6r
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Nov 2007 05:58:47 -0500
Received: from mail.transmode.se ([83.241.175.147]:53906 "EHLO
	tmnt04.transmode.se" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752032AbXKYK6r (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Nov 2007 05:58:47 -0500
Received: from Jocke ([84.217.8.168]) by tmnt04.transmode.se with Microsoft SMTPSVC(5.0.2195.6713);
	 Sun, 25 Nov 2007 11:58:44 +0100
X-Mailer: Microsoft Office Outlook 11
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.3198
thread-index: AcgvUiPeX8Ot9ZYXSV+igB35RiPYYw==
X-OriginalArrivalTime: 25 Nov 2007 10:58:44.0117 (UTC) FILETIME=[2563A450:01C82F52]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65966>

Is there a preferred way to do the above?

To do a full backup I could just copy the whole repo, but how
do I do inrecmental backups(and restore)?

 Jocke 
