From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: 2.6.17-rc6-mm2
Date: Fri, 16 Jun 2006 17:22:01 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606161720590.5498@g5.osdl.org>
References: <ef5305790606142040r5912ce58kf9f889c3d61b2cc0@mail.gmail.com> 
 <ef5305790606151814i252c37c4mdd005f11f06ceac@mail.gmail.com> 
 <Pine.LNX.4.64.0606151937360.5498@g5.osdl.org>
 <ef5305790606152249n2702873fy7b708d9c47c78470@mail.gmail.com>
 <Pine.LNX.4.64.0606152335130.5498@g5.osdl.org> <44931AFD.4070809@zytor.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Goo GGooo <googgooo@gmail.com>, linux-kernel@vger.kernel.org,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 17 02:22:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FrOZr-0002MC-0U
	for gcvg-git@gmane.org; Sat, 17 Jun 2006 02:22:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751568AbWFQAWG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Jun 2006 20:22:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932491AbWFQAWG
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Jun 2006 20:22:06 -0400
Received: from smtp.osdl.org ([65.172.181.4]:49558 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751568AbWFQAWE (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Jun 2006 20:22:04 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k5H0M2gt003487
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 16 Jun 2006 17:22:02 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k5H0M1Wv003290;
	Fri, 16 Jun 2006 17:22:02 -0700
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <44931AFD.4070809@zytor.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.76__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21989>



On Fri, 16 Jun 2006, H. Peter Anvin wrote:
> 
> Perhaps we shouldn't rely on stderr, and instead have a backchannel as part of
> the protocol itself.

Absolutely. I'm just irritated at myself for not going that way in the 
first place, but when I originally wrote it, I had my eyes on other 
issues, and the nice status updates got added later..

		Linus
