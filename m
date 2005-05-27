From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
Subject: Re: More gitweb queries..
Date: Fri, 27 May 2005 21:31:03 +0200
Message-ID: <20050527193103.GF7068@cip.informatik.uni-erlangen.de>
References: <Pine.LNX.4.58.0505271145570.17402@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kay Sievers <kay.sievers@vrfy.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 27 21:34:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DbkaQ-0005BA-SR
	for gcvg-git@gmane.org; Fri, 27 May 2005 21:33:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262558AbVE0TfB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 May 2005 15:35:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261969AbVE0TfB
	(ORCPT <rfc822;git-outgoing>); Fri, 27 May 2005 15:35:01 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:59571 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S262554AbVE0TbP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 May 2005 15:31:15 -0400
Received: from faui03.informatik.uni-erlangen.de (faui03.informatik.uni-erlangen.de [131.188.30.103])
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) with ESMTP id j4RJV3S8004715
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 27 May 2005 19:31:04 GMT
Received: (from sithglan@localhost)
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) id j4RJV3Ef004714;
	Fri, 27 May 2005 21:31:03 +0200 (CEST)
To: Linus Torvalds <torvalds@osdl.org>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Kay Sievers <kay.sievers@vrfy.org>,
	Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0505271145570.17402@ppc970.osdl.org>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hello,

>  - looking around, the ALSA guys aren't the only ones that start off with 
>    an empty line, so it's probably worth fixing the summary etc to ignore 
>    whitespace at the beginning rather than give empty summary reasons.

for me the formatting of an empty commit comment screw up the layout. I
don't know if it already is fixed, if not, I will soon report a patch.

	Thomas
