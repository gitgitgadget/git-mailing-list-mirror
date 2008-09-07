From: Boyd Lynn Gerber <gerberb@zenez.com>
Subject: Re: What's in git.git (Sep 2008, #01; Sat, 06)
Date: Sun, 7 Sep 2008 08:14:52 -0600
Message-ID: <alpine.LNX.1.10.0809070812350.6003@suse104.zenez.com>
References: <7vtzcso58c.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 07 16:16:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KcL3d-0007m8-DI
	for gcvg-git-2@gmane.org; Sun, 07 Sep 2008 16:16:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751049AbYIGOO5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Sep 2008 10:14:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751107AbYIGOO5
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Sep 2008 10:14:57 -0400
Received: from suse104.zenez.com ([198.60.105.164]:22124 "EHLO
	suse104.zenez.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750919AbYIGOO4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Sep 2008 10:14:56 -0400
Received: by suse104.zenez.com (Postfix, from userid 1000)
	id 9B5A6A7C28E; Sun,  7 Sep 2008 08:14:52 -0600 (MDT)
Received: from localhost (localhost [127.0.0.1])
	by suse104.zenez.com (Postfix) with ESMTP id 854CCA7C28C;
	Sun,  7 Sep 2008 08:14:52 -0600 (MDT)
In-Reply-To: <7vtzcso58c.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.10 (LNX 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95143>

On Sat, 6 Sep 2008, Junio C Hamano wrote:
> Quite a many minor fixes appeared on 'maint'.  1.6.0.2 needs to happen
> soon.  Any favorite fixes (not feature enhancements) not on the list here?

I would really like to see this graduate to master before 1.6.0.2

* jc/setlinebuf-setvbuf (Wed Sep 3 20:33:29 2008 -0700) 1 commit
  + daemon.c: avoid setlinebuf()


--
Boyd Gerber <gerberb@zenez.com>
ZENEZ	1042 East Fort Union #135, Midvale Utah  84047
