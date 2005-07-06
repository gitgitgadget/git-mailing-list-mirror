From: Greg KH <greg@kroah.com>
Subject: Re: git-pull-script hates me
Date: Wed, 6 Jul 2005 13:54:42 -0700
Message-ID: <20050706205442.GA19653@kroah.com>
References: <20050706203139.GA19198@kroah.com> <Pine.LNX.4.58.0507061335100.4159@g5.osdl.org> <20050706204627.GA19481@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 06 22:58:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DqGyZ-0002m3-7k
	for gcvg-git@gmane.org; Wed, 06 Jul 2005 22:58:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261718AbVGFU5b (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Jul 2005 16:57:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262509AbVGFU5a
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jul 2005 16:57:30 -0400
Received: from mail.kroah.org ([69.55.234.183]:64984 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262516AbVGFUyv (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Jul 2005 16:54:51 -0400
Received: from [192.168.0.10] (c-24-22-115-24.hsd1.or.comcast.net [24.22.115.24])
	(authenticated)
	by perch.kroah.org (8.11.6/8.11.6) with ESMTP id j66KsPq06514;
	Wed, 6 Jul 2005 13:54:25 -0700
Received: from greg by echidna.kroah.org with local (masqmail 0.2.19)
 id 1DqGuo-57M-00; Wed, 06 Jul 2005 13:54:42 -0700
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <20050706204627.GA19481@kroah.com>
User-Agent: Mutt/1.5.8i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 06, 2005 at 01:46:27PM -0700, Greg KH wrote:
> Ok, below is a patch for this.  It works, but then errors out with:
> 	bash: git-upload-pack: command not found
> 	fatal: unexpected EOF
> 
> So I'm guessing that I have to convince the server owner to update their
> version of git too?

Ok, so they did that, and the pull now works, sorry for the noise.

thanks,

greg k-h
