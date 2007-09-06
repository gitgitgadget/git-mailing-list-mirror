From: Miles Bader <miles.bader@necel.com>
Subject: Re: [PATCH] Include a git-push example for creating a remote branch
Date: Thu, 06 Sep 2007 13:54:33 +0900
Message-ID: <buoodggo0l2.fsf@dhapc248.dev.necel.com>
References: <20070906044408.GA588@spearce.org>
Reply-To: Miles Bader <miles@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Sep 06 06:55:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IT9Oe-0005zD-P7
	for gcvg-git@gmane.org; Thu, 06 Sep 2007 06:55:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751308AbXIFEzL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Sep 2007 00:55:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751304AbXIFEzL
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Sep 2007 00:55:11 -0400
Received: from TYO201.gate.nec.co.jp ([202.32.8.193]:38979 "EHLO
	tyo201.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751075AbXIFEzJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2007 00:55:09 -0400
Received: from relay21.aps.necel.com ([10.29.19.50])
	by tyo201.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id l864sFuS000744;
	Thu, 6 Sep 2007 13:54:16 +0900 (JST)
Received: from relay31.aps.necel.com ([10.29.19.24] [10.29.19.24]) by relay21.aps.necel.com with ESMTP; Thu, 6 Sep 2007 13:54:16 +0900
Received: from dhapc248.dev.necel.com ([10.114.98.116] [10.114.98.116]) by relay31.aps.necel.com with ESMTP; Thu, 6 Sep 2007 13:54:16 +0900
Received: by dhapc248.dev.necel.com (Postfix, from userid 31295)
	id C0A0558A; Thu,  6 Sep 2007 13:54:33 +0900 (JST)
System-Type: i686-pc-linux-gnu
Blat: Foop
In-Reply-To: <20070906044408.GA588@spearce.org> (Shawn O. Pearce's message of "Thu\, 6 Sep 2007 00\:44\:08 -0400")
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57816>

"Shawn O. Pearce" <spearce@spearce.org> writes:
> Many users get confused when `git push origin master:foo` works
> when foo already exists on the remote repository but are confused
> when foo doesn't exist as a branch and this form does not create
> the branch foo.

Hmm, what _does_ it do in that case...?

-Miles

-- 
If you can't beat them, arrange to have them beaten.  [George Carlin]
