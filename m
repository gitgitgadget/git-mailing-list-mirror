From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH] add --remote option to git-clone.
Date: Thu, 1 Feb 2007 17:06:57 -0500
Message-ID: <20070201220657.GB19271@fieldses.org>
References: <20070201220122.GF17617@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
X-From: git-owner@vger.kernel.org Thu Feb 01 23:07:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCk5D-0002Db-Rc
	for gcvg-git@gmane.org; Thu, 01 Feb 2007 23:07:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751409AbXBAWHD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Feb 2007 17:07:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751616AbXBAWHD
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Feb 2007 17:07:03 -0500
Received: from mail.fieldses.org ([66.93.2.214]:53123 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751409AbXBAWHB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Feb 2007 17:07:01 -0500
Received: from bfields by fieldses.org with local (Exim 4.63)
	(envelope-from <bfields@fieldses.org>)
	id 1HCk53-0005b0-61; Thu, 01 Feb 2007 17:06:57 -0500
Content-Disposition: inline
In-Reply-To: <20070201220122.GF17617@mellanox.co.il>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38414>

On Fri, Feb 02, 2007 at 12:01:22AM +0200, Michael S. Tsirkin wrote:
> I'm often annoyed by the fact that when I clone from this repository,
> I get a copy of all topic branches and origin tracking master
> by default, when I actually might only want to work on a different
> topic. And getting all extra branches is annoying on a slow connection.

Can you quantify "annoying"?

Not a challenge, I'm just curious--I would've thought that, for most
projects, even with long-lived topic branches, it wouldn't be that
expensive to get a second branch once you'd gotten one.

--b.
