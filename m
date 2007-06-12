From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH] Edit user manual for grammar
Date: Tue, 12 Jun 2007 13:54:21 -0400
Message-ID: <20070612175421.GA26767@fieldses.org>
References: <588192970706120518p201b52fdi9ed48896278b9f3e@mail.gmail.com> <200706121643.19837.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 12 19:54:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HyAZV-0005A1-Ey
	for gcvg-git@gmane.org; Tue, 12 Jun 2007 19:54:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755532AbXFLRyY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 12 Jun 2007 13:54:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755416AbXFLRyX
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jun 2007 13:54:23 -0400
Received: from mail.fieldses.org ([66.93.2.214]:46418 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754888AbXFLRyX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jun 2007 13:54:23 -0400
Received: from bfields by fieldses.org with local (Exim 4.67)
	(envelope-from <bfields@fieldses.org>)
	id 1HyAZR-00004v-GY; Tue, 12 Jun 2007 13:54:21 -0400
Content-Disposition: inline
In-Reply-To: <200706121643.19837.andyparkins@gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49980>

On Tue, Jun 12, 2007 at 04:43:19PM +0100, Andy Parkins wrote:
>  - "last-resort" is two words, not a conjoined word, it doesn't require
>    the hyphen

Right, but when you've got a couple words functioning together to modify
a following noun, the hyphen's pretty standard: "rosy-fingered dawn".
Is this case an exception?  I suspect it's fine either way....

>  - "method of" is vulgar, "method for" is nicer

Reference?

>  - "recovery" becomes "recovering" from Steve Hoelzer's original version
>    of this patch
>  - "if you want" is nicer as "if you wish"
>  - "you may" should be "you can"; "you may" is "you have permission to"
>    rather than "you can"'s "it is possible to"

Fair enough, thanks.

What we really need is a complete recovery tutorial to stick in here
someplace.  (One day git complains about a corrupt pack file.  What do
you do?)  What's been stopping me from doing it, besides time, is no
idea how to come up with a good example to work with.

--b.
