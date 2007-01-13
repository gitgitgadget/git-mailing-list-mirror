From: Peter Baumann <siprbaum@stud.informatik.uni-erlangen.de>
Subject: Re: [PATCH] gitk errors out if launched in a subdirectory
Date: Sat, 13 Jan 2007 17:10:57 +0100
Message-ID: <20070113161057.GA28354@xp.machine.xx>
References: <20070109143019.GA24688@xp.machine.xx> <20070112174340.GA6262@xp.machine.xx> <17832.20086.20532.159295@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Peter Baumann <Peter.B.Baumann@informatik.stud.uni-erlangen.de>,
	git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Jan 13 17:10:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H5lSU-0005Bk-UK
	for gcvg-git@gmane.org; Sat, 13 Jan 2007 17:10:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422710AbXAMQKF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 13 Jan 2007 11:10:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422706AbXAMQKF
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Jan 2007 11:10:05 -0500
Received: from matlock.hofmann.stw.uni-erlangen.de ([131.188.24.35]:43155 "HELO
	mail.hofmann.stw.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1422710AbXAMQKD (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 13 Jan 2007 11:10:03 -0500
Received: (qmail 7511 invoked by uid 0); 13 Jan 2007 16:10:00 -0000
Received: from p54aaa36b.dip0.t-ipconnect.de (HELO localhost) (p.b@hofmann.stw.uni-erlangen.de@84.170.163.107)
  by mail.hofmann.stw.uni-erlangen.de with SMTP; 13 Jan 2007 16:10:00 -0000
To: Paul Mackerras <paulus@samba.org>
Mail-Followup-To: Paul Mackerras <paulus@samba.org>,
	Peter Baumann <Peter.B.Baumann@informatik.stud.uni-erlangen.de>,
	git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <17832.20086.20532.159295@cargo.ozlabs.ibm.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36753>

On Sat, Jan 13, 2007 at 02:13:58PM +1100, Paul Mackerras wrote:
> Peter Baumann writes:
> 
> > Is there something obviously wrong with this patch? It is the second
> > time I send this (or a slight variant; last time I even removed the
> > enviroment checking) and nobody answered.
> > 
> > Please say so if it is NAKed.
> 
> No, it looks fine.  It's just that gitk takes a lower priority than
> some other things in my life.
> 
> Paul.
> 

Ok. No problem then. I just felt a little bit stupid after posting the
this simple fix the second time and nobody carred.

-Peter
