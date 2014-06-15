From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] gitk: switch to patch mode when searching for line origin
Date: Sun, 15 Jun 2014 14:56:11 +1000
Message-ID: <20140615045611.GB21978@iris.ozlabs.ibm.com>
References: <20140405203850.GA20967@wheezy.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Max Kirillov <max@max630.net>
X-From: git-owner@vger.kernel.org Sun Jun 15 06:58:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ww2WR-00037O-9Q
	for gcvg-git-2@plane.gmane.org; Sun, 15 Jun 2014 06:58:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752082AbaFOE6M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Jun 2014 00:58:12 -0400
Received: from ozlabs.org ([103.22.144.67]:51965 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751853AbaFOE57 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jun 2014 00:57:59 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id C8BE614009B; Sun, 15 Jun 2014 14:57:55 +1000 (EST)
Content-Disposition: inline
In-Reply-To: <20140405203850.GA20967@wheezy.local>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251668>

On Sat, Apr 05, 2014 at 11:38:50PM +0300, Max Kirillov wrote:
> If the "Show origin of this line" is started from tree mode,
> it still shows the result in tree mode, which I suppose not
> what user expects to see.

Thanks, applied.

Paul.
