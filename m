From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: Volume of commits
Date: Thu, 12 Jul 2007 18:21:47 +0200
Message-ID: <20070712162147.GA31743@diana.vm.bytemark.co.uk>
References: <m3ps2xu5hc.fsf@pc7.dolda2000.com> <20070712140304.GB28310@diana.vm.bytemark.co.uk> <m3ir8pu133.fsf@pc7.dolda2000.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Fredrik Tolf <fredrik@dolda2000.com>
X-From: git-owner@vger.kernel.org Thu Jul 12 18:22:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I91Qq-000720-VA
	for gcvg-git@gmane.org; Thu, 12 Jul 2007 18:22:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758988AbXGLQVz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 12 Jul 2007 12:21:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759974AbXGLQVz
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jul 2007 12:21:55 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1280 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758820AbXGLQVy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jul 2007 12:21:54 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1I91QJ-0008Nt-00; Thu, 12 Jul 2007 17:21:47 +0100
Content-Disposition: inline
In-Reply-To: <m3ir8pu133.fsf@pc7.dolda2000.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52300>

On 2007-07-12 16:51:44 +0200, Fredrik Tolf wrote:

> I see. Initially, it sounds like a lot of work, but the more I think
> about it, the more I realize that it probably isn't that bad.

You're right that it isn't that much work, but it still is work. The
point is that just like investing time in making code nice and
readable, investing time in making the history nice and readable is a
net win. Others can follow what you do, which makes reviewing the
changes much cheaper, and you can look back six months and actually
understand what you were thinking back then.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
