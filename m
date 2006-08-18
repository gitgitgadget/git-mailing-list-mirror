From: Fredrik Kuivinen <freku045@student.liu.se>
Subject: Another git-mv bug
Date: Fri, 18 Aug 2006 09:23:28 +0200
Message-ID: <20060818072328.GA5255@c165.ib.student.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Aug 18 09:23:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GDyha-0001OI-84
	for gcvg-git@gmane.org; Fri, 18 Aug 2006 09:23:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750955AbWHRHXb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Aug 2006 03:23:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750982AbWHRHXb
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Aug 2006 03:23:31 -0400
Received: from mxfep01.bredband.com ([195.54.107.70]:62177 "EHLO
	mxfep01.bredband.com") by vger.kernel.org with ESMTP
	id S1750955AbWHRHXa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Aug 2006 03:23:30 -0400
Received: from c165 ([213.114.27.99] [213.114.27.99])
          by mxfep01.bredband.com with ESMTP
          id <20060818072328.VRBH5813.mxfep01.bredband.com@c165>
          for <git@vger.kernel.org>; Fri, 18 Aug 2006 09:23:28 +0200
Received: from ksorim by c165 with local (Exim 3.36 #1 (Debian))
	id 1GDyhU-0001ry-00
	for <git@vger.kernel.org>; Fri, 18 Aug 2006 09:23:28 +0200
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25634>

Hi,

In a Git repository:

    $ git mv templates/info--exclude .
    fatal: renaming templates/info--exclude failed: No such file or directory

- Fredrik
