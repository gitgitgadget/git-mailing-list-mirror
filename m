From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re:
Date: Thu, 7 May 2009 14:33:37 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0905071433250.4983@localhost.localdomain>
References: <454B76988CBF42F5BCACA5061125D263@caottdt504> <81b0412b0905071013y241f7eas8417127e51ff52fa@mail.gmail.com> <D75C0FA80F7041FFAAC50B314788AD6F@caottdt504> <alpine.LFD.2.01.0905071148500.4983@localhost.localdomain> <A07C3E66E84D46ACB37EDC7D396CCA62@caottdt504>
 <alpine.LFD.2.01.0905071248250.4983@localhost.localdomain> <alpine.LFD.2.01.0905071312000.4983@localhost.localdomain> <7v63gcejad.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Bevan Watkiss <bevan.watkiss@cloakware.com>,
	"'Alex Riesen'" <raa.lkml@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 07 23:37:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M2BGi-0005Ga-3K
	for gcvg-git-2@gmane.org; Thu, 07 May 2009 23:36:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753083AbZEGVga (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2009 17:36:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751481AbZEGVga
	(ORCPT <rfc822;git-outgoing>); Thu, 7 May 2009 17:36:30 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:52780 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751298AbZEGVga (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 May 2009 17:36:30 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n47LXbl7031251
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 7 May 2009 14:34:13 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n47LXbxb010282;
	Thu, 7 May 2009 14:33:37 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <7v63gcejad.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.462 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118525>



On Thu, 7 May 2009, Junio C Hamano wrote:
>
> I do not think you mean CE_VALID; CE_UPTODATE isn't it?

Yes, sorry.

		Linus
