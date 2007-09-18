From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [rfc] git submodules howto
Date: Tue, 18 Sep 2007 09:29:40 -0400
Message-ID: <20070918132940.GC12120@fieldses.org>
References: <20070918105538.GL19019@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Tue Sep 18 15:29:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXd9A-0003z8-5m
	for gcvg-git-2@gmane.org; Tue, 18 Sep 2007 15:29:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755160AbXIRN3n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2007 09:29:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755068AbXIRN3n
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Sep 2007 09:29:43 -0400
Received: from mail.fieldses.org ([66.93.2.214]:42785 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754968AbXIRN3m (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2007 09:29:42 -0400
Received: from bfields by fieldses.org with local (Exim 4.67)
	(envelope-from <bfields@fieldses.org>)
	id 1IXd92-0003nG-Ni; Tue, 18 Sep 2007 09:29:40 -0400
Content-Disposition: inline
In-Reply-To: <20070918105538.GL19019@genesis.frugalware.org>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58608>

On Tue, Sep 18, 2007 at 12:55:38PM +0200, Miklos Vajna wrote:
> 1) is this correct? :) i use it and it seem to do what i except, but
> maybe it's not correct

I'm not able to answer that question.

> 2) does this worth adding to the documentation? maybe to a .txt under
> Documentation/howto? or to git-submodule.txt?

Could you add it as a new chapter to user-manual.txt (probably just
after the "git concepts" chapter), and then add links to that chapter
from git-submodule(1) and gitmodules(5)?

--b.
