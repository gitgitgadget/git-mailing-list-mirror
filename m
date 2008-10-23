From: Josef Wolf <jw@raven.inka.de>
Subject: Re: How to push to http(s) repository with authentication?
Date: Thu, 23 Oct 2008 19:53:37 +0200
Message-ID: <20081023175336.GA3526@raven.wolf.lan>
References: <20081020182502.GH9707@raven.wolf.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 23 20:01:58 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kt4V5-0002il-E0
	for gcvg-git-2@gmane.org; Thu, 23 Oct 2008 20:01:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754148AbYJWSAQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Oct 2008 14:00:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753693AbYJWSAQ
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Oct 2008 14:00:16 -0400
Received: from quechua.inka.de ([193.197.184.2]:42647 "EHLO mail.inka.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753345AbYJWSAP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Oct 2008 14:00:15 -0400
Received: from raven.inka.de (uucp@[127.0.0.1])
	by mail.inka.de with uucp (rmailwrap 0.5) 
	id 1Kt4Tl-0001wR-69; Thu, 23 Oct 2008 20:00:13 +0200
Received: by raven.inka.de (Postfix, from userid 1000)
	id 08CCF3ABA4; Thu, 23 Oct 2008 19:53:37 +0200 (CEST)
Mail-Followup-To: Josef Wolf <jw@raven.inka.de>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20081020182502.GH9707@raven.wolf.lan>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98978>

On Mon, Oct 20, 2008 at 08:25:02PM +0200, Josef Wolf wrote:

> I have set up a repository as described in
> 
>   http://www.kernel.org/pub/software/scm/git/docs/howto/setup-git-server-over-http.txt
> 
> over SSL with basic authentication.  DAV access works fine with konqueror,
> cadaver and and curl, using this .curlrc:
> [ ... ]

Is nobody interested in this topic?  Or am I in the wrong list?
