From: Fredrik Kuivinen <freku045@student.liu.se>
Subject: Re: [PATCH] Enable and fix support for base less merges.
Date: Tue, 4 Oct 2005 08:07:55 +0200
Message-ID: <20051004060755.GA1687@c165.ib.student.liu.se>
References: <7v7jcvxxrl.fsf@assigned-by-dhcp.cox.net> <4340A01F.7040901@gmail.com> <7vfyrjw8qb.fsf@assigned-by-dhcp.cox.net> <20051003061309.GA1712@c165.ib.student.liu.se> <46a038f90510022334k63884c6x377104e7eca29c48@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Fredrik Kuivinen <freku045@student.liu.se>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 04 08:08:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EMfyW-0001O2-6b
	for gcvg-git@gmane.org; Tue, 04 Oct 2005 08:08:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932239AbVJDGIG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Oct 2005 02:08:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932363AbVJDGIF
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Oct 2005 02:08:05 -0400
Received: from [85.8.31.11] ([85.8.31.11]:21411 "EHLO mail6.wasadata.com")
	by vger.kernel.org with ESMTP id S932239AbVJDGIE (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Oct 2005 02:08:04 -0400
Received: from c165 (unknown [85.8.2.189])
	by mail6.wasadata.com (Postfix) with ESMTP
	id CB3C44100; Tue,  4 Oct 2005 08:14:12 +0200 (CEST)
Received: from ksorim by c165 with local (Exim 3.36 #1 (Debian))
	id 1EMfxz-0000Ug-00; Tue, 04 Oct 2005 08:07:55 +0200
To: Martin Langhoff <martin.langhoff@gmail.com>
Content-Disposition: inline
In-Reply-To: <46a038f90510022334k63884c6x377104e7eca29c48@mail.gmail.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9663>

On Mon, Oct 03, 2005 at 07:34:19PM +1300, Martin Langhoff wrote:
> > With this it's possible to use
> >     git merge -s recursive 'merge message' A B
> > to do a base less merge of A and B.
> 
> Would it be possible/useful to teach git-apply about this?
> 

I don't really understand what you mean. In what way could git-apply
use this? Is there a specific use case you are thinking about?

- Fredrik
