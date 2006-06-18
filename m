From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
Subject: Re: [PATCH] Fix git to be (more) ANSI C99 compliant.
Date: Sun, 18 Jun 2006 10:14:40 +0200
Message-ID: <20060618081440.GD22641@cip.informatik.uni-erlangen.de>
References: <1150609831500-git-send-email-octo@verplant.org> <20060618110749.e6fb9030.tihirvon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: octo@verplant.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 18 10:15:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FrsQk-0005Zd-TU
	for gcvg-git@gmane.org; Sun, 18 Jun 2006 10:14:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932139AbWFRIOo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Jun 2006 04:14:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932144AbWFRIOo
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jun 2006 04:14:44 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:60870 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S932139AbWFRIOn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jun 2006 04:14:43 -0400
Received: by faui03.informatik.uni-erlangen.de (Postfix, from userid 31401)
	id 26D9630DEA; Sun, 18 Jun 2006 10:14:41 +0200 (CEST)
To: Timo Hirvonen <tihirvon@gmail.com>
Content-Disposition: inline
In-Reply-To: <20060618110749.e6fb9030.tihirvon@gmail.com>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22056>

Hello,

> 'A'...'Z' is more readable.  Does some compiler fail to compile it?

yes, it is GCC (GNU) specific IIRC. So for example the Sun Compiler will
choke on this one.

        Thomas
