From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH] User Manual: add a chapter for submodules
Date: Wed, 19 Sep 2007 16:30:14 -0400
Message-ID: <20070919203014.GI5946@fieldses.org>
References: <Pine.LNX.4.64.0709181405120.6203@juice.ott.cti.com> <20070919174250.GC16235@genesis.frugalware.org> <7vbqbyphil.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Miklos Vajna <vmiklos@frugalware.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 19 22:30:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IY6Bt-0004Iq-H9
	for gcvg-git-2@gmane.org; Wed, 19 Sep 2007 22:30:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752467AbXISUa0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Sep 2007 16:30:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751924AbXISUa0
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Sep 2007 16:30:26 -0400
Received: from mail.fieldses.org ([66.93.2.214]:47260 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752555AbXISUaZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Sep 2007 16:30:25 -0400
Received: from bfields by fieldses.org with local (Exim 4.67)
	(envelope-from <bfields@fieldses.org>)
	id 1IY6Ba-0005mG-Da; Wed, 19 Sep 2007 16:30:14 -0400
Content-Disposition: inline
In-Reply-To: <7vbqbyphil.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58732>

On Wed, Sep 19, 2007 at 12:44:18PM -0700, Junio C Hamano wrote:
> Also "submodule" is used consistently in the rest of the
> document but this sentence talks about "subproject".

I never liked the terms "submodule" or "subproject" much--it seems to
focus attention in the wrong place.  it's the "superproject" that's the
new and interesting thing here, while the submodules themselves are all
just standard git projects, right?

But I guess that's kind of a silly complaint, and late besides.

--b.
