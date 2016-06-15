From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] gitk: Enable mouse horizontal scrolling in diff pane
Date: Sun, 22 Mar 2015 14:37:17 +1100
Message-ID: <20150322033717.GA14271@iris.ozlabs.ibm.com>
References: <1416060306-4048-1-git-send-email-gabriele.mzt@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Gabriele Mazzotta <gabriele.mzt@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 22 04:41:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZWlk-0005O6-Go
	for gcvg-git-2@plane.gmane.org; Sun, 22 Mar 2015 04:41:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751803AbbCVDli (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Mar 2015 23:41:38 -0400
Received: from ozlabs.org ([103.22.144.67]:55577 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751604AbbCVDlb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Mar 2015 23:41:31 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 04F441401AD; Sun, 22 Mar 2015 14:41:29 +1100 (AEDT)
Content-Disposition: inline
In-Reply-To: <1416060306-4048-1-git-send-email-gabriele.mzt@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266046>

On Sat, Nov 15, 2014 at 03:05:06PM +0100, Gabriele Mazzotta wrote:
> Currently it's required to hold Shift and scroll up and down to move
> horizontally. Listen to Button-6 and Button-7 events too to make
> horizontal scrolling handier with touchpads and some mice.
> 
> Signed-off-by: Gabriele Mazzotta <gabriele.mzt@gmail.com>

Thanks, applied.

Paul.
