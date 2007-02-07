From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Subject: Re: git-fast-import
Date: Tue, 06 Feb 2007 22:17:16 -0300
Message-ID: <200702070117.l171HGxr023213@laptop13.inf.utfsm.cl>
References: <20070206023111.GB9222@spearce.org> <200702060928.54440.andyparkins@gmail.com> <Pine.LNX.4.64.0702060836180.8424@woody.linux-foundation.org> <20070206164441.GA4949@spearce.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Feb 07 02:17:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEbRG-0001Nv-Fe
	for gcvg-git@gmane.org; Wed, 07 Feb 2007 02:17:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030494AbXBGBRb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Feb 2007 20:17:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030525AbXBGBRb
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Feb 2007 20:17:31 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:45516 "EHLO inti.inf.utfsm.cl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030494AbXBGBRb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Feb 2007 20:17:31 -0500
Received: from laptop13.inf.utfsm.cl (pc-173-245-83-200.cm.vtr.net [200.83.245.173])
	by inti.inf.utfsm.cl (8.13.1/8.13.1) with ESMTP id l171HHRP029518
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Tue, 6 Feb 2007 22:17:17 -0300
Received: from laptop13.inf.utfsm.cl (laptop13.inf.utfsm.cl [127.0.0.1])
	by laptop13.inf.utfsm.cl (8.13.8/8.13.8) with ESMTP id l171HGxr023213;
	Tue, 6 Feb 2007 22:17:16 -0300
In-reply-to: <20070206164441.GA4949@spearce.org>
Comments: In-reply-to "Shawn O. Pearce" <spearce@spearce.org>
   message dated "Tue, 06 Feb 2007 11:44:41 -0500."
X-Mailer: MH-E 7.4.2; nmh 1.2-20070115cvs; XEmacs 21.5  (beta27)
X-Greylist: Delayed for 00:31:26 by milter-greylist-3.0 (inti.inf.utfsm.cl [0.0.0.0]); Tue, 06 Feb 2007 22:17:18 -0300 (CLST)
X-Virus-Scanned: ClamAV 0.88.7/2529/Tue Feb  6 16:25:02 2007 on inti.inf.utfsm.cl
X-Virus-Status: Clean
X-Spam-Status: No, score=-5.6 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00 
	autolearn=ham version=3.0.6
X-Spam-Checker-Version: SpamAssassin 3.0.6 (2005-12-07) on inti.inf.utfsm.cl
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38882>

Shawn O. Pearce <spearce@spearce.org> wrote:

[...]

> What about this language?
> 
> 	The time of the change is specified by `<time>` as the number of
> 	seconds since the UNIX epoc (midnight, Jan 1, 1970, UTC) and is
> 	written in base-10 notation using US-ASCII digits.  The committer's
> 	timezone is specified by `<tz>` as a positive or negative offset
> 	from UTC.  For example EST (which is typically 5 hours behind GMT)
> 	would be expressed in `<tz>` by ``-0500'' while GMT is ``+0000''.

That is /not/ a timezone! Maybe an offset from UTC.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                    Fono: +56 32 2654431
Universidad Tecnica Federico Santa Maria             +56 32 2654239
Casilla 110-V, Valparaiso, Chile               Fax:  +56 32 2797513
