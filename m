From: Junio C Hamano <junkio@cox.net>
Subject: Re: gitweb wishlist
Date: Tue, 24 May 2005 17:06:10 -0700
Message-ID: <7vk6lotbil.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0505201604460.2206@ppc970.osdl.org>
	<428E745C.30304@zytor.com>
	<Pine.LNX.4.58.0505201702170.2206@ppc970.osdl.org>
	<4292A08A.5050108@cobite.com>
	<Pine.LNX.4.58.0505232048190.2307@ppc970.osdl.org>
	<Pine.LNX.4.58.0505240110580.2307@ppc970.osdl.org>
	<20050524161745.GA9537@cip.informatik.uni-erlangen.de>
	<Pine.LNX.4.58.0505240929051.2307@ppc970.osdl.org>
	<Pine.LNX.4.58.0505240943080.2307@ppc970.osdl.org>
	<Pine.LNX.4.58.0505241017510.2307@ppc970.osdl.org>
	<20050524184612.GA23637@cip.informatik.uni-erlangen.de>
	<Pine.LNX.4.58.0505241212190.2307@ppc970.osdl.org>
	<20050525003917.40700d19.froese@gmx.de>
	<Pine.LNX.4.58.0505241602330.2307@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Edgar Toernig <froese@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 25 02:05:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DajOK-0001Yy-Ik
	for gcvg-git@gmane.org; Wed, 25 May 2005 02:04:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262172AbVEYAGS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 May 2005 20:06:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262169AbVEYAGS
	(ORCPT <rfc822;git-outgoing>); Tue, 24 May 2005 20:06:18 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:22240 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S262172AbVEYAGN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2005 20:06:13 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050525000610.HVPW22430.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 24 May 2005 20:06:10 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505241602330.2307@ppc970.osdl.org> (Linus
 Torvalds's message of "Tue, 24 May 2005 16:05:56 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:

LT> On Wed, 25 May 2005, Edgar Toernig wrote:
>> 
>> Nothing is expanded when you quote the EOF-word:

LT> Oh, wow.

Test scripts in your t/ uses <<\EOF all over the place.

