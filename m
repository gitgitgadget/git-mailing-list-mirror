From: Junio C Hamano <junkio@cox.net>
Subject: Re: 2.6.17-rc6-mm2
Date: Fri, 16 Jun 2006 15:52:17 -0700
Message-ID: <7v3be4d87y.fsf@assigned-by-dhcp.cox.net>
References: <ef5305790606142040r5912ce58kf9f889c3d61b2cc0@mail.gmail.com>
	<ef5305790606151814i252c37c4mdd005f11f06ceac@mail.gmail.com>
	<Pine.LNX.4.64.0606151937360.5498@g5.osdl.org>
	<ef5305790606152249n2702873fy7b708d9c47c78470@mail.gmail.com>
	<Pine.LNX.4.64.0606152335130.5498@g5.osdl.org>
	<44931AFD.4070809@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Sat Jun 17 00:52:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FrNB1-0006D7-G1
	for gcvg-git@gmane.org; Sat, 17 Jun 2006 00:52:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751542AbWFPWwU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Jun 2006 18:52:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751543AbWFPWwU
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Jun 2006 18:52:20 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:58264 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1751541AbWFPWwU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Jun 2006 18:52:20 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060616225218.BZBO11027.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 16 Jun 2006 18:52:18 -0400
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <44931AFD.4070809@zytor.com> (H. Peter Anvin's message of "Fri,
	16 Jun 2006 13:56:29 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21985>

"H. Peter Anvin" <hpa@zytor.com> writes:

> Perhaps we shouldn't rely on stderr, and instead have a backchannel as
> part of the protocol itself.

Concurred.  This was one of the thing I was planning to do
anyway.
