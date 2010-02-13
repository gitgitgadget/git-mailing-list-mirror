From: Sebastian Celis <sebastian@sebastiancelis.com>
Subject: 'git svn log' no longer uses the pager
Date: Sat, 13 Feb 2010 15:14:54 -0600
Message-ID: <462027ff1002131314k62069160h63760fc8316aa43b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 13 22:15:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NgPKP-00017g-Fm
	for gcvg-git-2@lo.gmane.org; Sat, 13 Feb 2010 22:15:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758029Ab0BMVOz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Feb 2010 16:14:55 -0500
Received: from mail-iw0-f201.google.com ([209.85.223.201]:64102 "EHLO
	mail-iw0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753408Ab0BMVOz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Feb 2010 16:14:55 -0500
Received: by iwn39 with SMTP id 39so1042204iwn.1
        for <git@vger.kernel.org>; Sat, 13 Feb 2010 13:14:54 -0800 (PST)
Received: by 10.231.190.204 with SMTP id dj12mr1968540ibb.9.1266095694159; 
	Sat, 13 Feb 2010 13:14:54 -0800 (PST)
X-Originating-IP: [75.73.9.129]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139831>

Hello,

Ever since upgrading to git 1.6.6.1 I have noticed that 'git svn log'
no longer uses the pager. It definitely used to in git 1.6.5.X, but it
no longer does.

Is this a recent bug that was introduced? Or was this changed on
purpose? I definitely preferred the old behavior.

Thank you,

Sebastian
