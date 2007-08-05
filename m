From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH v2] user-manual: mention git gui citool (commit, amend)
Date: Sun, 5 Aug 2007 18:22:13 -0400
Message-ID: <20070805222213.GA12168@fieldses.org>
References: <20070803125634.GB28323@fieldses.org> <1186318785677-git-send-email-prohaska@zib.de> <Pine.LNX.4.64.0708051457110.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steffen Prohaska <prohaska@zib.de>, gitster@pobox.com,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Aug 06 00:22:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHoUc-0006Eo-Og
	for gcvg-git@gmane.org; Mon, 06 Aug 2007 00:22:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754269AbXHEWWT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Aug 2007 18:22:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754175AbXHEWWT
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Aug 2007 18:22:19 -0400
Received: from mail.fieldses.org ([66.93.2.214]:48625 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753930AbXHEWWS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Aug 2007 18:22:18 -0400
Received: from bfields by fieldses.org with local (Exim 4.67)
	(envelope-from <bfields@fieldses.org>)
	id 1IHoUH-0004v1-VS; Sun, 05 Aug 2007 18:22:13 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0708051457110.14781@racer.site>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55076>

On Sun, Aug 05, 2007 at 02:58:11PM +0100, Johannes Schindelin wrote:
> On Sun, 5 Aug 2007, Steffen Prohaska wrote:
> 
> > git gui is especially useful because it allows to select diff hunks.
> 
> You should give a _big_ _fat_ _red_ warning there.
> 
> If you selectively commit diff hunks, you _never_ tested what you 
> committed.

A big warning would be out of place in what is for now just an isolated
sentence in two different places.  But I agree with you that this would
be worth mentioning in any eventual full-fledged git-gui tutorial.

--b.
