From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] gitk: Take only numeric version components when
 computing $git_version
Date: Wed, 19 Jan 2011 20:35:18 +1100
Message-ID: <20110119093518.GB5728@brick.ozlabs.ibm.com>
References: <4D231646.5080005@debugon.org>
 <1294360953.21006.2.camel@fixed-disk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Mathias Lafeldt <misfire@debugon.org>, git@vger.kernel.org
To: Anders Kaseorg <andersk@MIT.EDU>
X-From: git-owner@vger.kernel.org Wed Jan 19 10:35:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PfURx-0007Q2-Sl
	for gcvg-git-2@lo.gmane.org; Wed, 19 Jan 2011 10:35:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753935Ab1ASJf0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Jan 2011 04:35:26 -0500
Received: from ozlabs.org ([203.10.76.45]:43366 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753834Ab1ASJfZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Jan 2011 04:35:25 -0500
Received: by ozlabs.org (Postfix, from userid 1003)
	id E0798B70A9; Wed, 19 Jan 2011 20:35:23 +1100 (EST)
Content-Disposition: inline
In-Reply-To: <1294360953.21006.2.camel@fixed-disk>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165249>

On Thu, Jan 06, 2011 at 05:42:33PM -0700, Anders Kaseorg wrote:

> This fixes errors running with release candidate versions of Git:
>   Error in startup script: expected version number but got "1.7.4-rc0"

Thanks, applied.

Junio, you could do a pull from my gitk repository at your convenience.

Paul.
