From: Miles Bader <miles@gnu.org>
Subject: Re: git-diff should not fire up $PAGER, period!
Date: Mon, 22 Dec 2008 12:27:17 +0900
Message-ID: <buo3aggyjmy.fsf@dhapc248.dev.necel.com>
References: <20081216005658.GB3679@coredump.intra.peff.net>
	<8763lixyps.fsf_-_@jidanni.org>
Reply-To: Miles Bader <miles@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: jidanni@jidanni.org
X-From: git-owner@vger.kernel.org Mon Dec 22 04:28:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LEbTK-00048I-O5
	for gcvg-git-2@gmane.org; Mon, 22 Dec 2008 04:28:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752095AbYLVD12 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Dec 2008 22:27:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752070AbYLVD12
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Dec 2008 22:27:28 -0500
Received: from TYO202.gate.nec.co.jp ([202.32.8.206]:42856 "EHLO
	tyo202.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752028AbYLVD11 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Dec 2008 22:27:27 -0500
Received: from relay31.aps.necel.com ([10.29.19.54])
	by tyo202.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id mBM3PkKD022159;
	Mon, 22 Dec 2008 12:27:18 +0900 (JST)
Received: from relay31.aps.necel.com ([10.29.19.20] [10.29.19.20]) by relay31.aps.necel.com with ESMTP; Mon, 22 Dec 2008 12:27:18 +0900
Received: from dhapc248.dev.necel.com ([10.114.113.195] [10.114.113.195]) by relay31.aps.necel.com with ESMTP; Mon, 22 Dec 2008 12:27:18 +0900
Received: by dhapc248.dev.necel.com (Postfix, from userid 31295)
	id E676F430; Mon, 22 Dec 2008 12:27:17 +0900 (JST)
System-Type: i686-pc-linux-gnu
Blat: Foop
In-Reply-To: <8763lixyps.fsf_-_@jidanni.org> (jidanni@jidanni.org's message of
	"Thu, 18 Dec 2008 05:45:35 +0800")
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103744>

Just (setenv "PAGER" "cat") in .emacs.

[I actually have it set to /bin/cat, not sure if that's meaningful or not.]

-Miles

-- 
.Numeric stability is probably not all that important when you're guessing.
