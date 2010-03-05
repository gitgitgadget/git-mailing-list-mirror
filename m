From: Andreas Krey <a.krey@gmx.de>
Subject: Re: Question about scm security holes
Date: Fri, 5 Mar 2010 08:36:42 +0100
Message-ID: <20100305073642.GA16131@inner.home.ulmdo.de>
References: <hmp427$d6h$1@dough.gmane.org> <32541b131003041803q9abf6baq4cf9ffcca990b51c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: walt <w41ter@gmail.com>, git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 05 09:34:38 2010
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NnSAy-0005JB-Mt
	for gcvg-git-2@lo.gmane.org; Fri, 05 Mar 2010 08:42:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752224Ab0CEHgs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Mar 2010 02:36:48 -0500
Received: from continuum.iocl.org ([213.146.114.200]:62741 "EHLO
	continuum.iocl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751626Ab0CEHgr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Mar 2010 02:36:47 -0500
Received: (from krey@localhost)
	by continuum.iocl.org (8.11.3/8.9.3) id o257ahA18477;
	Fri, 5 Mar 2010 08:36:43 +0100
Content-Disposition: inline
In-Reply-To: <32541b131003041803q9abf6baq4cf9ffcca990b51c@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
X-message-flag: What did you expect to see here?
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141561>

On Thu, 04 Mar 2010 21:03:08 +0000, Avery Pennarun wrote:
...
> where every single developer workstation has a complete copy of the
> entire project history anyway.

It's the point of a dev workstation to have access to the code,
so McAfees whining about SCMs letting that happen is moot.

What would be helping here is a separation between internet-facing
and local work into separate machines.

> least.  Traceable, not so much, because you can create a commit with
> whatever committer/author names you want and then push them in.

You can still log who pushed what into your blessed repo,
and hold that person accountable.

Andreas
