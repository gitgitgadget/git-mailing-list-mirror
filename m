From: Daniel Phillips <phillips@istop.com>
Subject: Re: Mercurial 0.3 vs git benchmarks
Date: Mon, 25 Apr 2005 21:49:50 -0400
Message-ID: <200504252149.50735.phillips@istop.com>
References: <20050426004111.GI21897@waste.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: linux-kernel <linux-kernel@vger.kernel.org>, git@vger.kernel.org,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Tue Apr 26 03:45:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQF88-0001L9-D7
	for gcvg-git@gmane.org; Tue, 26 Apr 2005 03:44:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261260AbVDZBts (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Apr 2005 21:49:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261255AbVDZBts
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Apr 2005 21:49:48 -0400
Received: from smtp.istop.com ([66.11.167.126]:47536 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S261204AbVDZBtl (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Apr 2005 21:49:41 -0400
Received: from pulsar (phillips.tor.istop.com [66.11.182.115])
	by smtp.istop.com (Postfix) with ESMTP
	id 700342B3F8; Mon, 25 Apr 2005 21:52:36 -0400 (EDT)
To: Matt Mackall <mpm@selenic.com>
User-Agent: KMail/1.7
In-Reply-To: <20050426004111.GI21897@waste.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Monday 25 April 2005 20:41, Matt Mackall wrote:
> Despite the above, it compares pretty well to git in speed and is
> quite a bit better in terms of storage space. By reducing the zlib
> compression level, it could probably win across the board.

Hi Matt,

Congratulations on an impressive demo!  How about actually checking the 
compression vs wall clock theory?  And I probably don't have to mention 
psyco...

Regards,

Daniel
