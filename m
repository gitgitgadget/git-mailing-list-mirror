From: Pavel Roskin <proski@gnu.org>
Subject: Re: Quick merge status updates.
Date: Sat, 08 Jul 2006 03:36:08 -0400
Message-ID: <1152344168.26627.10.camel@dv>
References: <7vodwe5dr8.fsf@assigned-by-dhcp.cox.net>
	 <1151471040.4940.17.camel@dv> <7v7j3164xd.fsf@assigned-by-dhcp.cox.net>
	 <1151489103.28036.6.camel@dv>  <20060702204906.GG29115@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 08 09:36:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fz7Mo-0004d2-Ce
	for gcvg-git@gmane.org; Sat, 08 Jul 2006 09:36:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750901AbWGHHgY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 8 Jul 2006 03:36:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751260AbWGHHgY
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Jul 2006 03:36:24 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:169 "EHLO fencepost.gnu.org")
	by vger.kernel.org with ESMTP id S1750901AbWGHHgX (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 8 Jul 2006 03:36:23 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1Fz7MP-00087e-Cm
	for git@vger.kernel.org; Sat, 08 Jul 2006 03:36:22 -0400
Received: from proski by dv.roinet.com with local (Exim 4.62)
	(envelope-from <proski@dv.roinet.com>)
	id 1Fz7MG-0006wE-5W; Sat, 08 Jul 2006 03:36:08 -0400
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20060702204906.GG29115@pasky.or.cz>
X-Mailer: Evolution 2.7.3 (2.7.3-7) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23480>

On Sun, 2006-07-02 at 22:49 +0200, Petr Baudis wrote:
> Dear diary, on Wed, Jun 28, 2006 at 12:05:03PM CEST, I got a letter
> where Pavel Roskin <proski@gnu.org> said that...

> I feel that it is time for another stupid question of mine - why can't
> you just use lib?
> 
> 	use lib ('@@INSTLIBDIR@@');
> 
> Looks a lot better than some @INC unshifting, and it should be
> equivalent.

I honestly have no idea.  I think whatever gets you closer to the
satisfaction of the "three conditions" should be used.

-- 
Regards,
Pavel Roskin
