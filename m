From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Only filter "#" comments from commits if the editor is
	used
Date: Fri, 21 Dec 2007 00:43:41 +0100
Message-ID: <20071220234341.GE3052@steel.home>
References: <20071220211835.GA3052@steel.home> <alpine.LFD.0.9999.0712201324270.21557@woody.linux-foundation.org> <20071220233324.GB3052@steel.home> <20071220233539.GC3052@steel.home> <20071220233714.GD3052@steel.home> <7vtzmdlyva.fsf@gitster.siamese.dyndns.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 21 00:44:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J5V3l-0008Nb-DX
	for gcvg-git-2@gmane.org; Fri, 21 Dec 2007 00:44:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755408AbXLTXnt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Dec 2007 18:43:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755403AbXLTXnt
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Dec 2007 18:43:49 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:19053 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755361AbXLTXns (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Dec 2007 18:43:48 -0500
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaGCTvznCE=
Received: from tigra.home (Fca98.f.strato-dslnet.de [195.4.202.152])
	by post.webmailer.de (mrclete mo19) (RZmta 14.6)
	with ESMTP id C069aejBKMdDjS ; Fri, 21 Dec 2007 00:43:41 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 901F6277AE;
	Fri, 21 Dec 2007 00:43:41 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id 74F9F56D22; Fri, 21 Dec 2007 00:43:41 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7vtzmdlyva.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69027>

Junio C Hamano, Fri, Dec 21, 2007 00:39:37 +0100:
> Thanks.

Please hold on. The test fails.
