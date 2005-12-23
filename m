From: Ingo Oeser <ioe-lkml@rameria.de>
Subject: Re: [ANNOUNCE] GIT 1.0.0b quickfix
Date: Fri, 23 Dec 2005 17:12:38 +0100
Message-ID: <200512231712.40621.ioe-lkml@rameria.de>
References: <7vpsnq3wrg.fsf@assigned-by-dhcp.cox.net> <1135244363.10035.185.camel@gaston> <Pine.LNX.4.64.0512220945450.4827@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	"H. Peter Anvin" <hpa@zytor.com>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
X-From: linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1030564AbVLWQMx@vger.kernel.org Fri Dec 23 17:13:15 2005
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1030564AbVLWQMx@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EppXe-0006AC-PQ
	for glk-linux-kernel-3@gmane.org; Fri, 23 Dec 2005 17:13:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030564AbVLWQMx (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Fri, 23 Dec 2005 11:12:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932503AbVLWQMw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Dec 2005 11:12:52 -0500
Received: from smtprelay02.ispgateway.de ([80.67.18.14]:34773 "EHLO
	smtprelay02.ispgateway.de") by vger.kernel.org with ESMTP
	id S932499AbVLWQMw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Dec 2005 11:12:52 -0500
Received: (qmail 11562 invoked from network); 23 Dec 2005 16:12:46 -0000
Received: from unknown (HELO p5483d71e.dip.t-dialin.net) (696817@[84.131.215.30])
          (envelope-sender <ioe-lkml@rameria.de>)
          by smtprelay02.ispgateway.de (qmail-ldap-1.03) with RC4-MD5 encrypted SMTP
          for <linux-kernel@vger.kernel.org>; 23 Dec 2005 16:12:46 -0000
To: linux-kernel@vger.kernel.org
User-Agent: KMail/1.7.2
In-Reply-To: <Pine.LNX.4.64.0512220945450.4827@g5.osdl.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13994>

On Thursday 22 December 2005 18:46, Linus Torvalds wrote:
> On Thu, 22 Dec 2005, Benjamin Herrenschmidt wrote:
> > > Wouldn't it make more sense for the maintenance release to be 1.0.1?
> > Seconded. letters in versions are bad. With my MacOS background, for me,
> > "b" means "beta" :)
> FWIW, thirded. The kernel used to use letters too, and it's cute, but just 
> using multiple levels of release numbers is much more common.

Also sucks because letters after numbers a read as "units".

Just compare 5h, 3kg, 20cm, 9in, 1.3h

Also putting letters after version numbers usally gives me
a feeling that the author is not sure about what he does.
But this is just me, I guess

I hope util-linux is going to learn all that one day :-)


Regards

Ingo Oeser
