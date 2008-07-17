From: Heikki Orsila <shdl@zakalwe.fi>
Subject: Re: [PATCHv2] Documentation/git-submodule.txt: Add Description section
Date: Thu, 17 Jul 2008 13:41:24 +0300
Message-ID: <20080717104124.GE4379@zakalwe.fi>
References: <20080715183705.GD4379@zakalwe.fi> <20080716184248.6524.38463.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: gitster@pobox.com, git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Thu Jul 17 12:42:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJQwL-0007vK-Ux
	for gcvg-git-2@gmane.org; Thu, 17 Jul 2008 12:42:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755424AbYGQKl0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jul 2008 06:41:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755340AbYGQKl0
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jul 2008 06:41:26 -0400
Received: from zakalwe.fi ([80.83.5.154]:55115 "EHLO zakalwe.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755309AbYGQKl0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2008 06:41:26 -0400
Received: by zakalwe.fi (Postfix, from userid 1023)
	id B75892BC39; Thu, 17 Jul 2008 13:41:24 +0300 (EEST)
Content-Disposition: inline
In-Reply-To: <20080716184248.6524.38463.stgit@localhost>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88830>

On Wed, Jul 16, 2008 at 08:44:12PM +0200, Petr Baudis wrote:
> I have adjusted the description a bit; however, I believe mentioning
> remotes in
> the description would only raise the danger of confusion - I emphasized the
> level of separation, though.

I think not doing a comparison actually creates confusion. My immediate 
thought about submodules was "how does this differ from remotes? why do 
submodules exist rather than just remotes?"

-- 
Heikki Orsila
heikki.orsila@iki.fi
http://www.iki.fi/shd
