From: Neil Schemenauer <nas@arctrix.com>
Subject: Re: New converstion tool: svn2git.py
Date: Wed, 19 Nov 2008 14:40:33 -0600
Message-ID: <20081119204032.GA21441@arctrix.com>
References: <20081119191320.GA20870@arctrix.com> <7e3605160811191139t34c5de7q1912475f778386e8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Kevin Menard <nirvdrum@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 19 21:41:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L2ts1-0006pb-Ae
	for gcvg-git-2@gmane.org; Wed, 19 Nov 2008 21:41:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752825AbYKSUke (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Nov 2008 15:40:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752589AbYKSUke
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Nov 2008 15:40:34 -0500
Received: from vapor.arctrix.com ([66.220.1.99]:59634 "HELO vapor.arctrix.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752433AbYKSUkd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Nov 2008 15:40:33 -0500
Received: (qmail 21788 invoked by uid 1000); 19 Nov 2008 20:40:33 -0000
Content-Disposition: inline
In-Reply-To: <7e3605160811191139t34c5de7q1912475f778386e8@mail.gmail.com>
X-PGP-Fingerprint: 9B3B 987B F40E 9320 0619  0A17 A366 302E B1DE 86CE
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101374>

On Wed, Nov 19, 2008 at 02:39:26PM -0500, Kevin Menard wrote:
> You may want to look at this Ruby implementation for more ideas:
> 
> http://github.com/nirvdrum/svn2git/
> 

Hi Kevin,

Thanks for the link.   I see that git-svn does most of the heavy
lifting and now I see that it does try to intelligently handle
branches and tags by looking for a suitable parent commit.  I will
have to look closer at what it's doing.  Maybe it is sufficient for
my task.

Regards,

  Neil
