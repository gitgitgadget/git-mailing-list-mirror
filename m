From: Nick Hengeveld <nickh@reactrix.com>
Subject: Re: binary safe?
Date: Thu, 3 Nov 2005 15:05:21 -0800
Message-ID: <20051103230521.GA3001@reactrix.com>
References: <86br115r0z.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 04 00:06:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EXo99-0003aH-Lm
	for gcvg-git@gmane.org; Fri, 04 Nov 2005 00:05:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030407AbVKCXFY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 3 Nov 2005 18:05:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030499AbVKCXFY
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Nov 2005 18:05:24 -0500
Received: from 194.37.26.69.virtela.com ([69.26.37.194]:47393 "EHLO
	teapot.corp.reactrix.com") by vger.kernel.org with ESMTP
	id S1030407AbVKCXFX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Nov 2005 18:05:23 -0500
Received: from teapot.corp.reactrix.com (localhost.localdomain [127.0.0.1])
	by teapot.corp.reactrix.com (8.12.11/8.12.11) with ESMTP id jA3N5MqC024738;
	Thu, 3 Nov 2005 15:05:22 -0800
Received: (from nickh@localhost)
	by teapot.corp.reactrix.com (8.12.11/8.12.11/Submit) id jA3N5LrY024672;
	Thu, 3 Nov 2005 15:05:21 -0800
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
Content-Disposition: inline
In-Reply-To: <86br115r0z.fsf@blue.stonehenge.com>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11109>

On Thu, Nov 03, 2005 at 02:02:20PM -0800, Randal L. Schwartz wrote:

> What problems, if any, will I have using git to manage the binary
> files for my site, like the custom icons?  CVS is doing that just fine
> now.

We're now using git in production to distribute content, of which well
over 90% is binary files.  Works great.

-- 
For a successful technology, reality must take precedence over public
relations, for nature cannot be fooled.
