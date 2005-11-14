From: Joel Becker <Joel.Becker@oracle.com>
Subject: Re: ./configure script prototype
Date: Mon, 14 Nov 2005 10:19:58 -0800
Message-ID: <20051114181958.GD20749@ca-server1.us.oracle.com>
References: <43788078.4040403@op5.se> <437880AC.3040101@op5.se> <20051114132956.GT30496@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Ericsson <ae@op5.se>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Nov 14 19:23:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EbiwW-0002U0-5p
	for gcvg-git@gmane.org; Mon, 14 Nov 2005 19:20:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751218AbVKNSUK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Nov 2005 13:20:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751220AbVKNSUK
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Nov 2005 13:20:10 -0500
Received: from rgminet01.oracle.com ([148.87.122.30]:39506 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1751218AbVKNSUI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Nov 2005 13:20:08 -0500
Received: from rgmsgw01.us.oracle.com (rgmsgw01.us.oracle.com [138.1.186.51])
	by rgminet01.oracle.com (Switch-3.1.6/Switch-3.1.6) with ESMTP id jAEIJxwp012483;
	Mon, 14 Nov 2005 11:20:00 -0700
Received: from rgmsgw01.us.oracle.com (localhost.localdomain [127.0.0.1])
	by rgmsgw01.us.oracle.com (Switch-3.1.7/Switch-3.1.7) with ESMTP id jAEIJxI7028351;
	Mon, 14 Nov 2005 11:19:59 -0700
Received: from ca-server1.us.oracle.com (ca-server1.us.oracle.com [139.185.118.41])
	by rgmsgw01.us.oracle.com (Switch-3.1.7/Switch-3.1.7) with ESMTP id jAEIJwQc028328
	(version=TLSv1/SSLv3 cipher=DES-CBC3-SHA bits=168 verify=NO);
	Mon, 14 Nov 2005 11:19:59 -0700
Received: from jlbec by ca-server1.us.oracle.com with local (Exim 4.53)
	id 1Ebivu-0007nN-Nu; Mon, 14 Nov 2005 10:19:58 -0800
To: Petr Baudis <pasky@suse.cz>
Content-Disposition: inline
In-Reply-To: <20051114132956.GT30496@pasky.or.cz>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
User-Agent: Mutt/1.5.11
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11831>

On Mon, Nov 14, 2005 at 02:29:56PM +0100, Petr Baudis wrote:
> Dear diary, on Mon, Nov 14, 2005 at 01:18:52PM CET, I got a letter
> where Andreas Ericsson <ae@op5.se> said that...
> > 		--prefix=*)
> > 			prefix=${1##*=}

	${i# and ${i% are POSIX, iirc.

Joel

-- 

Life's Little Instruction Book #197

	"Don't forget, a person's greatest emotional need is to 
	 feel appreciated."

Joel Becker
Principal Software Developer
Oracle
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
