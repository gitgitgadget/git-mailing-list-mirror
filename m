From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] fmt-merge-msg: avoid open "-|" list form for Perl 5.6
Date: Thu, 23 Feb 2006 00:45:51 -0800
Message-ID: <7vwtfmihts.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0602201934270.28957@wbgn013.biozentrum.uni-wuerzburg.de>
	<20060220191011.GA18085@hand.yhbt.net>
	<7vr75xbs8w.fsf_-_@assigned-by-dhcp.cox.net>
	<81b0412b0602210930w5c1a71aage12bad2079dd515a@mail.gmail.com>
	<43FB79E2.1040307@vilain.net> <20060221215742.GA5948@steel.home>
	<43FB9656.8050308@vilain.net>
	<81b0412b0602220835p4c4243edm145ee827eb706121@mail.gmail.com>
	<Pine.LNX.4.63.0602222259480.6682@wbgn013.biozentrum.uni-wuerzburg.de>
	<81b0412b0602230000t58a88af6na1aa7e323dc0179d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 23 09:46:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FCC7M-0003nm-U9
	for gcvg-git@gmane.org; Thu, 23 Feb 2006 09:46:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750976AbWBWIpy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Feb 2006 03:45:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751648AbWBWIpy
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Feb 2006 03:45:54 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:63945 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1750976AbWBWIpx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Feb 2006 03:45:53 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060223084215.RKYF20050.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 23 Feb 2006 03:42:15 -0500
To: "Alex Riesen" <raa.lkml@gmail.com>
In-Reply-To: <81b0412b0602230000t58a88af6na1aa7e323dc0179d@mail.gmail.com>
	(Alex Riesen's message of "Thu, 23 Feb 2006 09:00:24 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16634>

"Alex Riesen" <raa.lkml@gmail.com> writes:

> I'll keep that in mind. But there are places where a safe pipe is unavoidable
> (filenames. No amount of careful quoting will save you).

Huh?
