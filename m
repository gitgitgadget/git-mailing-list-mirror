From: James Bottomley <James.Bottomley@SteelEye.com>
Subject: Re: [PATCH] make file merging respect permissions
Date: Sat, 23 Apr 2005 19:09:09 -0400
Message-ID: <1114297749.5264.3.camel@mulgrave>
References: <1114280570.5068.5.camel@mulgrave>
	 <Pine.LNX.4.58.0504231311300.2344@ppc970.osdl.org>
	 <1114292680.4799.4.camel@mulgrave>  <20050423230238.GD13222@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Apr 24 01:04:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPTfw-0002Jl-Sv
	for gcvg-git@gmane.org; Sun, 24 Apr 2005 01:04:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262093AbVDWXJY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Apr 2005 19:09:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262160AbVDWXJY
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Apr 2005 19:09:24 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:20700 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S262093AbVDWXJW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Apr 2005 19:09:22 -0400
Received: from midgard.sc.steeleye.com (midgard.sc.steeleye.com [172.17.6.40])
	by hancock.sc.steeleye.com (8.11.6/8.11.6) with ESMTP id j3NN9AA16731;
	Sat, 23 Apr 2005 19:09:11 -0400
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050423230238.GD13222@pasky.ji.cz>
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sun, 2005-04-24 at 01:02 +0200, Petr Baudis wrote:
> > +	if [ $ -ne 0 ]; then
> 
> *cough*

You're kidding me?

Well ... it's correct in my repository ... I'll investigate my diff
script

James


