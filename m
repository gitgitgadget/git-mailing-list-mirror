From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] gitk: Allow displaying time zones from author and commit
 timestamps
Date: Sun, 15 Jun 2014 14:56:37 +1000
Message-ID: <20140615045637.GC21978@iris.ozlabs.ibm.com>
References: <alpine.DEB.2.02.1405120722570.44324@all-night-tool.MIT.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Schwab <schwab@linux-m68k.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Tim Guirgies <lt.infiltrator@gmail.com>, git@vger.kernel.org
To: Anders Kaseorg <andersk@MIT.EDU>
X-From: git-owner@vger.kernel.org Sun Jun 15 06:58:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ww2WH-0002wx-7x
	for gcvg-git-2@plane.gmane.org; Sun, 15 Jun 2014 06:58:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751992AbaFOE6A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Jun 2014 00:58:00 -0400
Received: from ozlabs.org ([103.22.144.67]:55268 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751231AbaFOE56 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jun 2014 00:57:58 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id AEF4F140099; Sun, 15 Jun 2014 14:57:55 +1000 (EST)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.02.1405120722570.44324@all-night-tool.MIT.EDU>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251667>

On Mon, May 12, 2014 at 07:25:58AM -0400, Anders Kaseorg wrote:
> Now gitk can be configured to display author and commit dates in their
> original timezone, by putting %z into datetimeformat in ~/.gitk.
> 
> Signed-off-by: Anders Kaseorg <andersk@mit.edu>

Thanks, applied.

Paul.
