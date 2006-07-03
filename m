From: Eric Wong <normalperson@yhbt.net>
Subject: Re: contrib/ status
Date: Mon, 3 Jul 2006 01:06:25 -0700
Message-ID: <20060703080625.GB29036@hand.yhbt.net>
References: <200607030156.50455.jnareb@gmail.com> <200607030202.55919.jnareb@gmail.com> <7vodw7zgt2.fsf@assigned-by-dhcp.cox.net> <e89ock$gks$1@sea.gmane.org> <7vslljwiat.fsf@assigned-by-dhcp.cox.net> <7vmzbrwi3c.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 03 10:06:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FxJRu-000587-Fp
	for gcvg-git@gmane.org; Mon, 03 Jul 2006 10:06:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750757AbWGCIG1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Jul 2006 04:06:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750795AbWGCIG1
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Jul 2006 04:06:27 -0400
Received: from hand.yhbt.net ([66.150.188.102]:35476 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1750757AbWGCIG0 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Jul 2006 04:06:26 -0400
Received: by hand.yhbt.net (Postfix, from userid 500)
	id B6E6A7DC021; Mon,  3 Jul 2006 01:06:25 -0700 (PDT)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vmzbrwi3c.fsf_-_@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23161>

Junio C Hamano <junkio@cox.net> wrote:
> Junio C Hamano <junkio@cox.net> writes:
> 
> > ... the
> > things under contrib/ are not part of git.git but are there only
> > for convenience....
> 
> This reminds me of something quite different.  I am getting an
> impression that enough people have been helped by git-svn and it
> might be a good idea to have it outside contrib/ area.

That would be great.  IMHO, it puts git in a position to supplant
centralized SVN usage one developer at a time, making it easier
to make a gradual transition to git.  Of course, there's also svk
in a similar position...

-- 
Eric Wong
