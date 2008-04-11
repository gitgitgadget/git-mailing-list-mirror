From: Bill Lear <rael@zopyra.com>
Subject: Re: edit merge commit message
Date: Fri, 11 Apr 2008 12:50:35 -0500
Message-ID: <18431.42219.921671.875700@lisa.zopyra.com>
References: <20080411171204.GA29738@lapse.madduck.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git discussion list <git@vger.kernel.org>
To: martin f krafft <madduck@madduck.net>
X-From: git-owner@vger.kernel.org Fri Apr 11 19:51:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JkNPW-0004yd-KS
	for gcvg-git-2@gmane.org; Fri, 11 Apr 2008 19:51:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760305AbYDKRuy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Apr 2008 13:50:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760304AbYDKRuy
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Apr 2008 13:50:54 -0400
Received: from mail.zopyra.com ([65.68.225.25]:60633 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759085AbYDKRuy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Apr 2008 13:50:54 -0400
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id m3BHocn08365;
	Fri, 11 Apr 2008 11:50:38 -0600
In-Reply-To: <20080411171204.GA29738@lapse.madduck.net>
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79281>

On Friday, April 11, 2008 at 19:12:04 (+0200) martin f krafft writes:
>Hi folks
>
>Is there any way to edit the message of a merge prior to the commit?
>I see there is an -m option but no --edit or the like. It would also
>make sense to have a config option for this to turn on spawning the
>editor by default, I think...
>
>If there is none, I am willing to take a stab at it. Unless you tell
>me that this will have no chance to go upstream.

% git commit --ammend


Bill
