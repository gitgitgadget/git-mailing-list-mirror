From: Petr Baudis <pasky@suse.cz>
Subject: Re: Hackontest ideas?
Date: Tue, 29 Jul 2008 10:35:22 +0200
Message-ID: <20080729083522.GJ10151@machine.or.cz>
References: <20080729000103.GH32184@machine.or.cz> <20080729001016.GT32057@genesis.frugalware.org> <20080729053110.GD11947@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Miklos Vajna <vmiklos@frugalware.org>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Jul 29 10:36:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNkgy-0007F8-OO
	for gcvg-git-2@gmane.org; Tue, 29 Jul 2008 10:36:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753289AbYG2IfZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2008 04:35:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753281AbYG2IfZ
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jul 2008 04:35:25 -0400
Received: from w241.dkm.cz ([62.24.88.241]:44856 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753230AbYG2IfY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2008 04:35:24 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 3A993393B31B; Tue, 29 Jul 2008 10:35:22 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080729053110.GD11947@spearce.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90600>

On Mon, Jul 28, 2008 at 10:31:10PM -0700, Shawn O. Pearce wrote:
> How about smart fetch/push over HTTP?  E.g. a CGI (or extension to
> gitweb) that does native pack transport over HTTP rather than dumb
> object traversal with GET and WebDAV LOCK/PUT.  Note that the push
> side doesn't need to support tell-me-more extension, making it a
> fairly trivial GET, POST (or PUT) sequence.

Ah, thanks for reminding me about this, nice!

Thanks all for their suggestions so far, I have added all of them plus
an extra. Now, if you want them implemented, some of you need to join as
implementers and the features need to get a lot of votes quickly! ;-))

(Frankly, I don't think there is really any chance to make it, but I
think having such a list of mid-size self-contained tasks might be
useful for other occasions, so I will haul it over to the wiki after the
deadline.)

				Petr "Pasky" Baudis
