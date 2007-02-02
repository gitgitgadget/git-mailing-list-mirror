From: Matt Mackall <mpm@selenic.com>
Subject: Re: newbie questions about git design and features (some wrt hg)
Date: Fri, 2 Feb 2007 11:37:58 -0600
Message-ID: <20070202173758.GC10108@waste.org>
References: <3c6c07c20701300820l42cfc8dbsb80393fc1469f667@mail.gmail.com> <200702021055.49428.jnareb@gmail.com> <20070202160317.GX10108@waste.org> <200702021818.11368.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: mercurial@selenic.com, git@vger.kernel.org,
	Junio C Hamano <junkio@cox.net>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 02 18:50:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HD2YT-0007Lj-0S
	for gcvg-git@gmane.org; Fri, 02 Feb 2007 18:50:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945989AbXBBRua (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Feb 2007 12:50:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945991AbXBBRua
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Feb 2007 12:50:30 -0500
Received: from waste.org ([66.93.16.53]:40611 "EHLO waste.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1945989AbXBBRu3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Feb 2007 12:50:29 -0500
Received: from waste.org (localhost [127.0.0.1])
	by waste.org (8.13.4/8.13.4/Debian-3sarge3) with ESMTP id l12HbwEC009564
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 2 Feb 2007 11:37:59 -0600
Received: (from oxymoron@localhost)
	by waste.org (8.13.4/8.13.4/Submit) id l12Hbw3m009563;
	Fri, 2 Feb 2007 11:37:58 -0600
Content-Disposition: inline
In-Reply-To: <200702021818.11368.jnareb@gmail.com>
User-Agent: Mutt/1.5.9i
X-Virus-Scanned: by amavisd-new
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38519>

On Fri, Feb 02, 2007 at 06:18:10PM +0100, Jakub Narebski wrote:
> Revision-controlled (in-tree) tags are inane idea. Tags are non-moving
> (and sometimes annotated) pointers to given point in history. They should
> not depend on which branch you are, or what version you have checked out.

And.. they don't!

I'm now officially done correcting your uninformed perceptions. Come
back when you've actually looked at the docs.

-- 
Mathematics is the supreme nostalgia of our time.
