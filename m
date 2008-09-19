From: Boyd Lynn Gerber <gerberb@zenez.com>
Subject: Re: [PATCH v2 1/4] diff.c: return pattern entry pointer rather than
 just the hunk header pattern
Date: Fri, 19 Sep 2008 12:14:11 -0600
Message-ID: <alpine.LNX.1.10.0809191209450.10710@suse104.zenez.com>
References: <7vskry1485.fsf@gitster.siamese.dyndns.org> <hvD4CKeY-shT7TB0JLaQn02KLTvzB720kcwBxBfYbo3S2ySzNzsn9g@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Arjen Laarhoven <arjen@yaph.org>,
	Mike Ralphson <mike.ralphson@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Jeff King <peff@peff.net>,
	Git Mailing List <git@vger.kernel.org>,
	Avery Pennarun <apenwarr@gmail.com>,
	Johan Herland <johan@herland.net>,
	Andreas Ericsson <ae@op5.se>, Kirill Smelkov <kirr@mns.spb.ru>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
	Gustaf Hendeby <hendeby@isy.liu.se>,
	Jonathan del Strother <maillist@steelskies.com>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Fri Sep 19 20:15:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KgkVl-0002qt-HG
	for gcvg-git-2@gmane.org; Fri, 19 Sep 2008 20:15:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753099AbYISSON (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Sep 2008 14:14:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753044AbYISSON
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Sep 2008 14:14:13 -0400
Received: from suse104.zenez.com ([198.60.105.164]:1219 "EHLO
	suse104.zenez.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752258AbYISSOM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Sep 2008 14:14:12 -0400
Received: by suse104.zenez.com (Postfix, from userid 1000)
	id 9E289A7C97C; Fri, 19 Sep 2008 12:14:11 -0600 (MDT)
Received: from localhost (localhost [127.0.0.1])
	by suse104.zenez.com (Postfix) with ESMTP id 8C29EA7C892;
	Fri, 19 Sep 2008 12:14:11 -0600 (MDT)
In-Reply-To: <hvD4CKeY-shT7TB0JLaQn02KLTvzB720kcwBxBfYbo3S2ySzNzsn9g@cipher.nrlssc.navy.mil>
User-Agent: Alpine 1.10 (LNX 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96305>

So on these patches,
What do you want me to do?  I applied them and things kinda worked.  The 
problem is pine/alpine messes them up a bit and it is not easy to manually 
fix them.  It would be easier to git clone/pull them from either a site or 
the trees.  I do think that on some we should use the actual charact vers 
the C-syntax.  "\t" for example.

--
Boyd Gerber <gerberb@zenez.com>
ZENEZ	1042 East Fort Union #135, Midvale Utah  84047
