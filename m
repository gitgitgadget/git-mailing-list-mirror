From: Niklas Hoglund <nhoglund@gmail.com>
Subject: Re: [PATCH] The diff-raw format updates.
Date: Sun, 22 May 2005 19:36:45 +0100
Message-ID: <20050522183645.GA1866@localhost.localdomain>
References: <7vwtpsdvgm.fsf@assigned-by-dhcp.cox.net> <7v1x80dluj.fsf@assigned-by-dhcp.cox.net> <7vvf5cc779.fsf_-_@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0505221108000.2307@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun May 22 20:49:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DZvV2-0002so-At
	for gcvg-git@gmane.org; Sun, 22 May 2005 20:48:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261556AbVEVStv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 May 2005 14:49:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261597AbVEVStv
	(ORCPT <rfc822;git-outgoing>); Sun, 22 May 2005 14:49:51 -0400
Received: from host81-153-202-186.range81-153.btcentralplus.com ([81.153.202.186]:967
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id S261556AbVEVSts (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 May 2005 14:49:48 -0400
Received: by localhost.localdomain (Postfix, from userid 1000)
	id 5DFA51BD5C; Sun, 22 May 2005 19:36:45 +0100 (BST)
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0505221108000.2307@ppc970.osdl.org>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sun, May 22, 2005 at 11:35:34AM -0700, Linus Torvalds wrote:
> :000000 100644 0000000000000000000000000000000000000000 25ab9eda939ad92bb746c2419d083b1e52117a56	diffcore-pathspec.c	diffcore-pathspec.c

Don't you think it would be easier to read if the SHA1 field was, say, a
dash and 19 spaces, instead of an obviously bogus SHA1?

This feels a bit like using 0 where NULL would be more appropriate...

Best regards,
Niklas
