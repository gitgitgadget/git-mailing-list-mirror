From: Miles Bader <miles.bader@necel.com>
Subject: Re: [PATCH] When a remote is added but not fetched, tell the user.
Date: Tue, 15 Apr 2008 12:15:06 +0900
Message-ID: <buoabjvrepx.fsf@dhapc248.dev.necel.com>
References: <20080409101428.GA2637@elte.hu>
	<1207869946-17013-1-git-send-email-g2p.code@gmail.com>
	<alpine.DEB.1.00.0804111621080.31025@eeepc-johanness>
	<20080411203501.7095b866@localhost> <20080411190816.GA17277@mithlond>
Reply-To: Miles Bader <miles@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Gabriel <g2p.code@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Teemu Likonen <tlikonen@iki.fi>
X-From: git-owner@vger.kernel.org Tue Apr 15 05:16:18 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JlbeY-0002WE-6e
	for gcvg-git-2@gmane.org; Tue, 15 Apr 2008 05:16:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764275AbYDODPb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Apr 2008 23:15:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764265AbYDODPb
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Apr 2008 23:15:31 -0400
Received: from TYO201.gate.nec.co.jp ([202.32.8.193]:62474 "EHLO
	tyo201.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761823AbYDODPa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Apr 2008 23:15:30 -0400
Received: from relay31.aps.necel.com ([10.29.19.54])
	by tyo201.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id m3F3F5bS027321;
	Tue, 15 Apr 2008 12:15:07 +0900 (JST)
Received: from relay21.aps.necel.com ([10.29.19.24] [10.29.19.24]) by relay31.aps.necel.com with ESMTP; Tue, 15 Apr 2008 12:15:07 +0900
Received: from dhapc248.dev.necel.com ([10.114.112.215] [10.114.112.215]) by relay21.aps.necel.com with ESMTP; Tue, 15 Apr 2008 12:15:07 +0900
Received: by dhapc248.dev.necel.com (Postfix, from userid 31295)
	id D172E4D9; Tue, 15 Apr 2008 12:15:06 +0900 (JST)
System-Type: i686-pc-linux-gnu
Blat: Foop
In-Reply-To: <20080411190816.GA17277@mithlond> (Teemu Likonen's message of
	"Fri, 11 Apr 2008 22:08:16 +0300")
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79562>

Teemu Likonen <tlikonen@iki.fi> writes:
> Hmm, I'm quite newbie but I have never expected "git remote add" to
> fetch anything. I wouldn't want it to do it automatically.

I agree.

An automatic fetch would be ... surprising.

-Miles

-- 
"Don't just question authority,
Don't forget to question me."
-- Jello Biafra
