From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH 2/3] Documentation: Add definition of "evil merge" to GIT Glossary
Date: Fri, 25 May 2007 20:14:23 -0400
Message-ID: <20070526001423.GF32073@fieldses.org>
References: <11801326601014-git-send-email-jnareb@gmail.com> <1180132662719-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 26 02:14:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HrjvT-0005KW-Vg
	for gcvg-git@gmane.org; Sat, 26 May 2007 02:14:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752928AbXEZAOZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 25 May 2007 20:14:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753032AbXEZAOZ
	(ORCPT <rfc822;git-outgoing>); Fri, 25 May 2007 20:14:25 -0400
Received: from mail.fieldses.org ([66.93.2.214]:57390 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752910AbXEZAOY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 May 2007 20:14:24 -0400
Received: from bfields by fieldses.org with local (Exim 4.67)
	(envelope-from <bfields@fieldses.org>)
	id 1HrjvL-0002Lb-Bz; Fri, 25 May 2007 20:14:23 -0400
Content-Disposition: inline
In-Reply-To: <1180132662719-git-send-email-jnareb@gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48433>

On Sat, May 26, 2007 at 12:37:39AM +0200, Jakub Narebski wrote:
> +[[def_evil_merge]]evil merge::
> +	An evil merge is a <<def_merge,merge>> that introduces changes that
> +	do not appear in any <<def_parent,parent>>.
> +

I'm a little skeptical.  This term doesn't appear to be used anywhere in
the current documentation, for example--are you sure it's worth
including at this point?  I don't know--I just don't want to end up with
an entry for every piece of cute jargon that's been used as shorthand on
the mailing list a few times.  But if you think it's sufficiently useful
and well-established, then OK.

--b.
