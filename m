From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [ANNOUNCE] GIT 1.0.0b quickfix
Date: Thu, 22 Dec 2005 09:46:29 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0512220945450.4827@g5.osdl.org>
References: <7vpsnq3wrg.fsf@assigned-by-dhcp.cox.net>  <43A9E15F.1060808@zytor.com>
 <1135244363.10035.185.camel@gaston>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "H. Peter Anvin" <hpa@zytor.com>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org, linux-kernel@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 22 18:47:19 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EpUX3-0000M6-HP
	for gcvg-git@gmane.org; Thu, 22 Dec 2005 18:47:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030180AbVLVRrK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Dec 2005 12:47:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030237AbVLVRrK
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Dec 2005 12:47:10 -0500
Received: from smtp.osdl.org ([65.172.181.4]:35013 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030180AbVLVRrI (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Dec 2005 12:47:08 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jBMHkYDZ014957
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 22 Dec 2005 09:46:35 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jBMHkTWx014930;
	Thu, 22 Dec 2005 09:46:31 -0800
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1135244363.10035.185.camel@gaston>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.57__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13958>



On Thu, 22 Dec 2005, Benjamin Herrenschmidt wrote:
> > 
> > Wouldn't it make more sense for the maintenance release to be 1.0.1?
> 
> Seconded. letters in versions are bad. With my MacOS background, for me,
> "b" means "beta" :)

FWIW, thirded. The kernel used to use letters too, and it's cute, but just 
using multiple levels of release numbers is much more common.

		Linus
