From: Chris Wedgwood <cw@f00f.org>
Subject: Re: git full diff output issues..
Date: Thu, 26 May 2005 16:34:43 -0700
Message-ID: <faf0d98cb35ad4b51c55d23d851093b5.ANY@taniwha.stupidest.org>
References: <Pine.LNX.4.58.0505261214140.2307@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 27 01:33:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DbRqI-0007i4-M5
	for gcvg-git@gmane.org; Fri, 27 May 2005 01:32:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261848AbVEZXeq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 May 2005 19:34:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261849AbVEZXeq
	(ORCPT <rfc822;git-outgoing>); Thu, 26 May 2005 19:34:46 -0400
Received: from ylpvm43-ext.prodigy.net ([207.115.57.74]:15336 "EHLO
	ylpvm43.prodigy.net") by vger.kernel.org with ESMTP id S261848AbVEZXep
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2005 19:34:45 -0400
Received: from pimout2-ext.prodigy.net (pimout2-int.prodigy.net [207.115.4.217])
	by ylpvm43.prodigy.net (8.12.10 outbound/8.12.10) with ESMTP id j4QNYqKh017658
	for <git@vger.kernel.org>; Thu, 26 May 2005 19:34:52 -0400
X-ORBL: [63.202.173.158]
Received: from taniwha.stupidest.org (adsl-63-202-173-158.dsl.snfc21.pacbell.net [63.202.173.158])
	by pimout2-ext.prodigy.net (8.12.10 milter /8.12.10) with ESMTP id j4QNYhM3430408;
	Thu, 26 May 2005 19:34:43 -0400
Received: by taniwha.stupidest.org (Postfix, from userid 38689)
	id 3DDB8528F22; Thu, 26 May 2005 16:34:43 -0700 (PDT)
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0505261214140.2307@ppc970.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, May 26, 2005 at 12:19:21PM -0700, Linus Torvalds wrote:

> 	deleted file mode 100644 arch/um/kernel/checksum.c

why do we care about the mode here?
