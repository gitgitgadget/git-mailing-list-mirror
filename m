From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git-gui translation pushed
Date: Mon, 10 Aug 2009 08:44:29 -0700
Message-ID: <20090810154429.GU1033@spearce.org>
References: <1245870671.5526.14.camel@blob>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jimmy Angelakos <vyruss@hellug.gr>
X-From: git-owner@vger.kernel.org Mon Aug 10 17:45:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MaX3u-0006aC-4q
	for gcvg-git-2@gmane.org; Mon, 10 Aug 2009 17:45:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755368AbZHJPo2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2009 11:44:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755352AbZHJPo2
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Aug 2009 11:44:28 -0400
Received: from george.spearce.org ([209.20.77.23]:59643 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755257AbZHJPo1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Aug 2009 11:44:27 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 20895381FD; Mon, 10 Aug 2009 15:44:29 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1245870671.5526.14.camel@blob>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125466>

Jimmy Angelakos <vyruss@hellug.gr> wrote:
> I have pushed a Greek translation for git-gui on repo.or.cz's
> git-gui-i18n (mob branch).

Thanks, I have cherry-picked this through to master.  The charset
was set wrong in the files, it was "CHARSET", which isn't a valid
charset.  I modified to UTF-8 before applying.  I suspect something
is up with your PO editor.

-- 
Shawn.
