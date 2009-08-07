From: Boyd Lynn Gerber <gerberb@zenez.com>
Subject: Problem compiling git-1.6.4 on OpenServer 6.0
Date: Fri, 7 Aug 2009 13:27:51 -0600
Message-ID: <alpine.LNX.2.00.0908071326250.13290@suse104.zenez.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 07 21:34:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZVCw-0007MC-LN
	for gcvg-git-2@gmane.org; Fri, 07 Aug 2009 21:34:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933119AbZHGTeN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Aug 2009 15:34:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933090AbZHGTeN
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Aug 2009 15:34:13 -0400
Received: from suse104.zenez.com ([198.60.105.164]:55995 "EHLO
	suse104.zenez.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933057AbZHGTeN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Aug 2009 15:34:13 -0400
X-Greylist: delayed 380 seconds by postgrey-1.27 at vger.kernel.org; Fri, 07 Aug 2009 15:34:12 EDT
Received: by suse104.zenez.com (Postfix, from userid 1000)
	id E7B506C10EB; Fri,  7 Aug 2009 13:27:51 -0600 (MDT)
Received: from localhost (localhost [127.0.0.1])
	by suse104.zenez.com (Postfix) with ESMTP id D201193852B
	for <git@vger.kernel.org>; Fri,  7 Aug 2009 13:27:51 -0600 (MDT)
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125211>

Hello,

I just tried to compile the latest git and I get this error.

CC builtin-pack-objects.o
UX:acomp: ERROR: "builtin-pack-objects.c", line 1602: integral constant 
expression expected
gmake: *** [builtin-pack-objects.o] Error 1

I will look into it when I have a bit more time, but this is a heads up.

Thanks,

-- 
Boyd Gerber <gerberb@zenez.com> 801 849-0213
ZENEZ	1042 East Fort Union #135, Midvale Utah  84047
