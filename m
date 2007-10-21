From: Steffen Prohaska <prohaska@zib.de>
Subject: How to run git-gui always in English?
Date: Sun, 21 Oct 2007 08:47:10 +0200
Message-ID: <CCAD0DE0-65D4-4FEC-B02F-658010FECD04@zib.de>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Oct 21 08:46:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IjUZW-0005KY-DG
	for gcvg-git-2@gmane.org; Sun, 21 Oct 2007 08:46:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751118AbXJUGpr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Oct 2007 02:45:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751263AbXJUGpr
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Oct 2007 02:45:47 -0400
Received: from mailer.zib.de ([130.73.108.11]:50690 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750927AbXJUGpq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Oct 2007 02:45:46 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l9L6jghf018616;
	Sun, 21 Oct 2007 08:45:42 +0200 (CEST)
Received: from [192.168.178.21] (brln-4db1b164.pool.einsundeins.de [77.177.177.100])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l9L6jfcH002149
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Sun, 21 Oct 2007 08:45:42 +0200 (MEST)
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61883>

There are a lot of efforts going on to localize git-gui,
including technical terms like "push". Personally I don't
understand what this should be useful for. The command is called
"git push"s. So, why should it be named differently in the gui.

Anyway, I can switch it off, right? So here's my question.

How can I switch msysgit's git-gui to English, independently of
the language selected for Windows? I recognized that git-gui
adjusts to the 'language selection' of Windows. How can I
disable this? I want git-gui to always display English. Nothing
else, never! I can't help people who use a different language
in the gui, because I'll not understand what they are talking
about and they'll not understand me.

Can I set an option in git-gui's option menu? I haven't
found one.

	Steffen
