From: Wilbert van Dolleweerd <wilbert@arentheym.com>
Subject: [ANNOUNCE] New version of TFS2Git script
Date: Wed, 5 Jan 2011 09:58:43 +0100
Message-ID: <AANLkTik_xv6Yf53AU4Vc_iW18g3W4OUa0F=8VmMmJswO@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 05 09:58:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PaPCk-000887-5e
	for gcvg-git-2@lo.gmane.org; Wed, 05 Jan 2011 09:58:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751296Ab1AEI6o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Jan 2011 03:58:44 -0500
Received: from mail-yi0-f46.google.com ([209.85.218.46]:39003 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750895Ab1AEI6o (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Jan 2011 03:58:44 -0500
Received: by yib18 with SMTP id 18so3722997yib.19
        for <git@vger.kernel.org>; Wed, 05 Jan 2011 00:58:43 -0800 (PST)
Received: by 10.100.196.20 with SMTP id t20mr923129anf.208.1294217923321; Wed,
 05 Jan 2011 00:58:43 -0800 (PST)
Received: by 10.100.254.4 with HTTP; Wed, 5 Jan 2011 00:58:43 -0800 (PST)
X-Originating-IP: [188.205.87.234]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164557>

Hello,

I've released a new version of my TFS2Git script. With this script you
can convert Microsoft Team Foundation Server repositories to Git.

You can find the script at https://github.com/WilbertOnGithub/TFS2GIT.
See the readme there for instructions about its usage.

New features:
- The ability to import only part of the history
- An option to map TFS accounts to Git usernames

Needed:
- Powershell
- MsysGit
- Access to the commandline tools of Team Foundation Server.

Tested with Microsoft Team Foundation Server 2008, but should also
work with 2005/2010.

Hope it is useful for other people. Patches and contributions are
welcomed through the usual Github channels.

-- 
Kind regards,

Wilbert van Dolleweerd
Blog: http://walkingthestack.wordpress.com/
Twitter: http://www.twitter.com/wvandolleweerd
