From: Alan Chandler <alan@chandlerfamily.org.uk>
Subject: Re: Cogito Tutorial If It Helps
Date: Thu, 28 Apr 2005 06:40:19 +0100
Message-ID: <200504280640.19543.alan@chandlerfamily.org.uk>
References: <1114548747.3083.1.camel@kryten> <20050427193227.GF22956@pasky.ji.cz> <200504272315.22939.alan@chandlerfamily.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: James Purser <purserj@winnsw.com.au>
X-From: git-owner@vger.kernel.org Thu Apr 28 07:35:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DR1g1-00015A-6G
	for gcvg-git@gmane.org; Thu, 28 Apr 2005 07:35:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262016AbVD1FkX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Apr 2005 01:40:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262023AbVD1FkX
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Apr 2005 01:40:23 -0400
Received: from 82-44-22-127.cable.ubr06.croy.blueyonder.co.uk ([82.44.22.127]:61921
	"EHLO home.chandlerfamily.org.uk") by vger.kernel.org with ESMTP
	id S262016AbVD1FkT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2005 01:40:19 -0400
Received: from kanger.home ([192.168.0.21])
	by home.chandlerfamily.org.uk with esmtp (Exim 4.50)
	id 1DR1l4-0006pQ-8p; Thu, 28 Apr 2005 06:40:18 +0100
To: git@vger.kernel.org
User-Agent: KMail/1.8
In-Reply-To: <200504272315.22939.alan@chandlerfamily.org.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wednesday 27 April 2005 23:15, Alan Chandler wrote:
> On Wednesday 27 April 2005 20:32, Petr Baudis wrote:

> > You didn't do make install and you don't have the cogito tree in your
> > $PATH.
>
> I DID do a make install - which put everything in ~/bin (including
> cg-Xdiffdo) and ~/bin is the first item in my $PATH.

Thanks to James Purser its fixed.

I needed the full path to ~/bin rather than just using the ~ in $PATH.
-- 
Alan Chandler
http://www.chandlerfamily.org.uk
