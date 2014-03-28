From: Thomas Ackermann <th.acker@arcor.de>
Subject: Re: Problems with git 1.8.5.3 on HP-UX 11.11
Date: Fri, 28 Mar 2014 11:48:00 +0000 (UTC)
Message-ID: <loom.20140328T124555-537@post.gmane.org>
References: <9D24AD27564FAE4CB8D0C15D080DEFCB0106A89226@m4ukex08.intranet.macro4.com> <8FDD21D28EC16844948E2A773083574A03363EBC@m4ukex08.intranet.macro4.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 28 12:48:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WTVGw-0007au-Qc
	for gcvg-git-2@plane.gmane.org; Fri, 28 Mar 2014 12:48:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751638AbaC1Ls0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Mar 2014 07:48:26 -0400
Received: from plane.gmane.org ([80.91.229.3]:39828 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751073AbaC1Ls0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Mar 2014 07:48:26 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1WTVGq-0007Xs-II
	for git@vger.kernel.org; Fri, 28 Mar 2014 12:48:24 +0100
Received: from proxy45.sbs.de ([194.138.39.59])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 28 Mar 2014 12:48:24 +0100
Received: from th.acker by proxy45.sbs.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 28 Mar 2014 12:48:24 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 194.138.39.59 (Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.154 Safari/537.36)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245382>

Gerhard Grimm <gerhard.grimm <at> detec.com> writes:

> 
> In order to set up automated builds and tests of the CMake toolchain 
(www.cmake.org) on HP-UX 11.11 (hppa)
> and 11.23 (ia64), I needed to install git on those platforms.
> The latest binary package available from hpux.connect.org.uk is version 
1.8.5.3, which I installed with
> all of its dependencies.

Did you try to build the most current version v1.9.1 by using
autoconf as described in 'INSTALL'?

---
Thomas
