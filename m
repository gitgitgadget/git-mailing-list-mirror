From: Jeff Epler <jepler@unpythonic.net>
Subject: Re: Git gui error RenderBadPicture
Date: Sun, 5 Jul 2009 19:16:58 -0500
Message-ID: <20090706001658.GA3745@unpythonic.net>
References: <d4cf37a60907051640k215595a1n95b720201243fc89@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Wink Saville <wink@saville.com>
X-From: git-owner@vger.kernel.org Mon Jul 06 02:18:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MNbuN-0007Lx-7b
	for gcvg-git-2@gmane.org; Mon, 06 Jul 2009 02:18:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756663AbZGFAQ6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Jul 2009 20:16:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756637AbZGFAQ5
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Jul 2009 20:16:57 -0400
Received: from dsl.unpythonic.net ([206.222.212.217]:50987 "EHLO
	unpythonic.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756596AbZGFAQ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Jul 2009 20:16:57 -0400
Received: by unpythonic.net (Postfix, from userid 1000)
	id 7C51011511A; Sun,  5 Jul 2009 19:16:58 -0500 (CDT)
Content-Disposition: inline
In-Reply-To: <d4cf37a60907051640k215595a1n95b720201243fc89@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122768>

This is likely due to a bug in Tk, the widget toolkit of 'git gui'.  The
bug was set to "obsolete" back in 2007, but there's no indication the
problem was fixed.

https://sourceforge.net/tracker/?func=detail&atid=112997&aid=1821174&group_id=12997

Jeff
