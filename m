From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Be more careful about updating refs
Date: Tue, 15 Jan 2008 16:42:02 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0801151640530.2806@woody.linux-foundation.org>
References: <alpine.LFD.1.00.0801151546560.2806@woody.linux-foundation.org> <7vd4s2d33x.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 16 01:42:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JEwMZ-0006y4-SP
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 01:42:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754084AbYAPAmK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2008 19:42:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753406AbYAPAmK
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jan 2008 19:42:10 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:41376 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751379AbYAPAmJ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Jan 2008 19:42:09 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0G0g3uJ000696
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 15 Jan 2008 16:42:04 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0G0g2dv011793;
	Tue, 15 Jan 2008 16:42:02 -0800
In-Reply-To: <7vd4s2d33x.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-2.719 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70586>



On Tue, 15 Jan 2008, Junio C Hamano wrote:
> 
> Does "Signed-off-by:" line mean something different for you than
> for other people these days?

I intentionally don't tend to sign off stuff that I just send out as trial 
balloons, not meant to "really" be applied.

Of course, then I *also* forget to sign off emails that I do intend to be 
applied, so that rule-of-thumb is pretty weak ;)

		Linus
