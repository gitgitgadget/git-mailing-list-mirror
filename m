From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: merge renamed files/directories?
Date: Mon, 5 May 2008 19:19:24 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0805051918200.32269@woody.linux-foundation.org>
References: <4819CF50.2020509@tikalk.com> <481D52CC.1030503@tikalk.com>  <32541b130805050940x1297e907ofc67ee65494897eb@mail.gmail.com>  <200805052349.35867.robin.rosenberg.lists@dewire.com>  <alpine.LFD.1.10.0805051512060.32269@woody.linux-foundation.org>
 <32541b130805051838k367c44bau715774b46f7894cb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	Ittay Dror <ittayd@tikalk.com>, git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 06 04:21:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JtCnU-0000Uy-S8
	for gcvg-git-2@gmane.org; Tue, 06 May 2008 04:20:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755200AbYEFCUE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 May 2008 22:20:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754491AbYEFCUE
	(ORCPT <rfc822;git-outgoing>); Mon, 5 May 2008 22:20:04 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:59471 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753939AbYEFCUD (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 May 2008 22:20:03 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m462JPAx008545
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 5 May 2008 19:19:26 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m462JOO5017022;
	Mon, 5 May 2008 19:19:24 -0700
In-Reply-To: <32541b130805051838k367c44bau715774b46f7894cb@mail.gmail.com>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.423 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81323>



On Mon, 5 May 2008, Avery Pennarun wrote:
>
> I general I agree with your point here, but I still find it surprising
> how hard the directory-rename problem is made out to be.

I do agree that it's probably not that hard.

But I disagree with people who whine about pointless stuff, and don't send 
patches.

		Linus
