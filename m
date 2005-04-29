From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
Subject: Re: More problems...
Date: Fri, 29 Apr 2005 22:03:38 +0200
Message-ID: <20050429200338.GL7331@cip.informatik.uni-erlangen.de>
References: <20050429170127.A30010@flint.arm.linux.org.uk> <20050429182708.GB14202@pasky.ji.cz> <20050429195055.GE1233@mythryan2.michonline.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Apr 29 22:02:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRbeg-00048l-NB
	for gcvg-git@gmane.org; Fri, 29 Apr 2005 22:00:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262922AbVD2UFU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Apr 2005 16:05:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262934AbVD2UFU
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Apr 2005 16:05:20 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:39860 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S262922AbVD2UDk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2005 16:03:40 -0400
Received: from faui03.informatik.uni-erlangen.de (faui03.informatik.uni-erlangen.de [131.188.30.103])
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) with ESMTP id j3TK3cS8014864
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Fri, 29 Apr 2005 20:03:39 GMT
Received: (from sithglan@localhost)
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) id j3TK3cLh014863
	for git@vger.kernel.org; Fri, 29 Apr 2005 22:03:38 +0200 (CEST)
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20050429195055.GE1233@mythryan2.michonline.com>
X-URL: http://wwwcip.informatik.uni-erlangen.de/~sithglan/
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hello,

> Why not just use "rsync" for both remote and local synchronization, and
> provide a "relink" command to scan two .git/objects/ repositories and
> hardlink matching files together?

That came to my mind, too. And it is actually the only thing that makes
sense. - In matters of KISS. :-)

	Thomas
