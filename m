From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: ETA for release of gjit 0.4?
Date: Mon, 8 Dec 2008 08:52:34 -0800
Message-ID: <20081208165234.GI31551@spearce.org>
References: <49393BFC.6010606@wellfleetsoftware.com> <200812061947.27905.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Farrukh Najmi <farrukh@wellfleetsoftware.com>, git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Mon Dec 08 17:54:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L9jMm-0007XG-7s
	for gcvg-git-2@gmane.org; Mon, 08 Dec 2008 17:53:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753417AbYLHQwf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Dec 2008 11:52:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753402AbYLHQwf
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Dec 2008 11:52:35 -0500
Received: from george.spearce.org ([209.20.77.23]:44156 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753341AbYLHQwf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Dec 2008 11:52:35 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 6E8F038200; Mon,  8 Dec 2008 16:52:34 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <200812061947.27905.robin.rosenberg.lists@dewire.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102558>

Robin Rosenberg <robin.rosenberg.lists@dewire.com> wrote:
> It was a long time since we labeled anything. Shawn, how about merging
> my recent close-file-patches, reverting 3ffa47d9294086fbd1cdeb9b1564f922a23e3c6f
> and e7307f14c531d52cf231c39d844841c4adaf5e5a and then just call i 0.4 ?

OK.  I'm not a big fan of reverting code, but I see more value in
doing it and getting a "more stable" 0.4 out.  So I'll do these
reverts and make the 0.4 tag this morning.

-- 
Shawn.
