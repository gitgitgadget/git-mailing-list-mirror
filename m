From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
Subject: Re: Git-commits mailing list feed.
Date: Sat, 23 Apr 2005 20:39:09 +0200
Message-ID: <20050423183909.GC7100@cip.informatik.uni-erlangen.de>
References: <200504210422.j3L4Mo8L021495@hera.kernel.org> <42674724.90005@ppp0.net> <20050422002922.GB6829@kroah.com> <426A4669.7080500@ppp0.net> <1114266083.3419.40.camel@localhost.localdomain> <426A5BFC.1020507@ppp0.net> <1114266907.3419.43.camel@localhost.localdomain> <Pine.LNX.4.58.0504231010580.2344@ppc970.osdl.org> <20050423175422.GA7100@cip.informatik.uni-erlangen.de> <Pine.LNX.4.58.0504231125330.2344@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Woodhouse <dwmw2@infradead.org>,
	Jan Dittmer <jdittmer@ppp0.net>, Greg KH <greg@kroah.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Apr 23 20:45:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPPcr-0004Ns-V2
	for gcvg-git@gmane.org; Sat, 23 Apr 2005 20:45:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261701AbVDWStX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Apr 2005 14:49:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261698AbVDWSr1
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Apr 2005 14:47:27 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:3542 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S261697AbVDWSqs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Apr 2005 14:46:48 -0400
Received: from faui03.informatik.uni-erlangen.de (faui03.informatik.uni-erlangen.de [131.188.30.103])
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) with ESMTP id j3NIdAS8000298
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 23 Apr 2005 18:39:10 GMT
Received: (from sithglan@localhost)
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) id j3NId99E000297;
	Sat, 23 Apr 2005 20:39:09 +0200 (CEST)
To: Linus Torvalds <torvalds@osdl.org>
Mail-Followup-To: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
	Linus Torvalds <torvalds@osdl.org>,
	David Woodhouse <dwmw2@infradead.org>,
	Jan Dittmer <jdittmer@ppp0.net>, Greg KH <greg@kroah.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0504231125330.2344@ppc970.osdl.org>
X-URL: http://wwwcip.informatik.uni-erlangen.de/~sithglan/
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hello,

> 	commit ....
> 	tag ...

> 	here goes comment
> 	here goes signature

# This creates only the signature in Ascii Armor.
gpg -a --detach-sign < to_sign > signature

	Thomas
