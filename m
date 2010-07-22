From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH 1/3] git-instaweb: Fix custom apache log placement
Date: Thu, 22 Jul 2010 16:42:56 -0700
Message-ID: <20100722234256.GA19581@dcvr.yhbt.net>
References: <1277865900-25044-1-git-send-email-dpmcgee@gmail.com> <AANLkTiknXtteX77h8Uy1JuWmGLWSSRkAGkS3INMOHBoJ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Dan McGee <dpmcgee@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 23 01:43:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oc5Pr-0005sR-SO
	for gcvg-git-2@lo.gmane.org; Fri, 23 Jul 2010 01:43:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753361Ab0GVXm7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jul 2010 19:42:59 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:59398 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751777Ab0GVXm6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jul 2010 19:42:58 -0400
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id 200751F547;
	Thu, 22 Jul 2010 23:42:57 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <AANLkTiknXtteX77h8Uy1JuWmGLWSSRkAGkS3INMOHBoJ@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151497>

Dan McGee <dpmcgee@gmail.com> wrote:
> On Tue, Jun 29, 2010 at 9:44 PM, Dan McGee <dpmcgee@gmail.com> wrote:
> > 'CustomLog' is provided by mod_log_config so we need to include the module
> > in our generated config. This was added in d94775e1f9a.
> >
> > Signed-off-by: Dan McGee <dpmcgee@gmail.com>
> 
> I noticed this set of patches didn't go anywhere...at least the first
> two were more bug fixes than improvements so I would have expected
> them to get into 1.7.2. Did they get lost in the shuffle?
> 
> 1: http://marc.info/?l=git&m=127786592330110&w=2
> 2: http://marc.info/?l=git&m=127786592030105&w=2
> 3: http://marc.info/?l=git&m=127791591706076&w=2

Hi Dan, can you address Junio's concerns here?

  http://marc.info/?l=git&m=127791382102449&w=2

Thanks.

-- 
Eric Wong
