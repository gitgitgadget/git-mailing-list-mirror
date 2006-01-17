From: Junio C Hamano <junkio@cox.net>
Subject: Re: [kernel.org users] [RFC] "clone --naked"?
Date: Tue, 17 Jan 2006 00:17:19 -0800
Message-ID: <7v1wz7clps.fsf@assigned-by-dhcp.cox.net>
References: <1137402365.3034.5.camel@laptopd505.fenrus.org>
	<43CCB1D3.10309.35645D@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 17 09:18:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eym1t-0006jC-K3
	for gcvg-git@gmane.org; Tue, 17 Jan 2006 09:17:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932312AbWAQIRV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Jan 2006 03:17:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932317AbWAQIRV
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jan 2006 03:17:21 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:44463 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S932314AbWAQIRU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jan 2006 03:17:20 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060117081512.ENVY26964.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 17 Jan 2006 03:15:12 -0500
To: "Ulrich Windl" <ulrich.windl@rz.uni-regensburg.de>
In-Reply-To: <43CCB1D3.10309.35645D@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
	(Ulrich Windl's message of "Tue, 17 Jan 2006 08:58:59 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14787>

"Ulrich Windl" <ulrich.windl@rz.uni-regensburg.de> writes:

> ...  My original intention was that I
> thought them to be little descriptive regarding their
> function.  You seem to have "--bare" and "--naked". Hard to
> guess what they really do.

True.  "A repository without an associated working tree".  I do
not know a short and sweet phrase to describe that (well, except
"bare" and "naked", which I kind of already got used to).

Whatever word we choose to describe that, it should go to the
glossary document.
