From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] gitk: Add mouse right-click options
Date: Sun, 17 May 2015 10:56:57 +1000
Message-ID: <20150517005657.GB21039@iris.ozlabs.ibm.com>
References: <1431052160-82758-1-git-send-email-rappazzo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Rappazzo <rappazzo@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 17 06:22:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ytq5i-0000C9-Ia
	for gcvg-git-2@plane.gmane.org; Sun, 17 May 2015 06:22:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750901AbbEQEWG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 May 2015 00:22:06 -0400
Received: from ozlabs.org ([103.22.144.67]:59438 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751203AbbEQEWD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 May 2015 00:22:03 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 131F6140CEB; Sun, 17 May 2015 14:22:00 +1000 (AEST)
Content-Disposition: inline
In-Reply-To: <1431052160-82758-1-git-send-email-rappazzo@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269206>

On Thu, May 07, 2015 at 10:29:19PM -0400, Michael Rappazzo wrote:
> I work in a large and deep codebase, and found it useful to have these additional features in gitk.  
> 
> First, in the commit list, a right click on a branch name will add an option ('Copy branch name') to put that name on the system clipboard.
> 
> Second, in the file list of a commit, a right click on a file will add an option ('Copy path') to put the file path on the system clipboard.

Thanks, applied.

Paul.
