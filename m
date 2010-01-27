From: Johan Herland <johan@herland.net>
Subject: Re: git notes: notes
Date: Wed, 27 Jan 2010 12:55:20 +0100
Message-ID: <201001271255.20848.johan@herland.net>
References: <20100120050343.GA12860@gnu.kitenet.net>
 <alpine.DEB.1.00.1001210457380.4985@pacific.mpi-cbg.de>
 <20100121040533.GA13597@gnu.kitenet.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-15
Content-Transfer-Encoding: 7BIT
Cc: Joey Hess <joey@kitenet.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 27 12:55:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Na6UZ-0001IK-Bj
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jan 2010 12:55:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753879Ab0A0LzY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jan 2010 06:55:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752168Ab0A0LzX
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Jan 2010 06:55:23 -0500
Received: from smtp.getmail.no ([84.208.15.66]:60871 "EHLO
	get-mta-out01.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752118Ab0A0LzX (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Jan 2010 06:55:23 -0500
Received: from smtp.getmail.no ([10.5.16.4]) by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KWW00FJUMGAFU60@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Wed, 27 Jan 2010 12:55:22 +0100 (MET)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KWW00M31MG9RH00@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Wed, 27 Jan 2010 12:55:22 +0100 (MET)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2010.1.27.114527
User-Agent: KMail/1.12.4 (Linux/2.6.32-ARCH; KDE/4.3.4; x86_64; ; )
In-reply-to: <20100121040533.GA13597@gnu.kitenet.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138155>

On Thursday 21 January 2010, Joey Hess wrote:
> Johannes Schindelin wrote:
> > I do not really care as long as there is a nice way to edit the
> > complete note interactively.
> >
> > Of course, I _do_ expect people to get confused just like they do with
> > the current inconsistencies: "git commit -m" does not really append,
> > but set the commit message, even if you amend a commit.
> >
> > So maybe you want to use a different command line option for that.
> 
> Maybe: git notes add [-m|-F]

Thanks for the suggestion. I've added this to the new iteration of the 
jh/notes series.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
