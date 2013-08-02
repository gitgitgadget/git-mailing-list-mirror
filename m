From: Kumar Appaiah <a.kumar@alumni.iitm.ac.in>
Subject: Re: [TIG][PATCH] Scroll diff with arrow keys in log view
Date: Thu, 01 Aug 2013 23:12:56 -0400
Message-ID: <20130802031256.GA28920@bluemoon.alumni.iitm.ac.in>
References: <CAFuPQ1LMJNhY-Lxx9-TnB+Z8hQXGEAY_xK8afZeSsHnG1JMoLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git <git@vger.kernel.org>
To: Jonas Fonseca <fonseca@diku.dk>
X-From: git-owner@vger.kernel.org Fri Aug 02 05:13:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V55nb-00045E-BP
	for gcvg-git-2@plane.gmane.org; Fri, 02 Aug 2013 05:13:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754556Ab3HBDM7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Aug 2013 23:12:59 -0400
Received: from mta3.srv.hcvlny.cv.net ([167.206.4.198]:37723 "EHLO
	mta3.srv.hcvlny.cv.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753358Ab3HBDM6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Aug 2013 23:12:58 -0400
Received: from odessa (ool-18bb429a.dyn.optonline.net [24.187.66.154])
 by mta3.srv.hcvlny.cv.net
 (Sun Java System Messaging Server 6.2-8.04 (built Feb 28 2007))
 with ESMTPA id <0MQV00KIYVLK7VW0@mta3.srv.hcvlny.cv.net> for
 git@vger.kernel.org; Thu, 01 Aug 2013 23:12:57 -0400 (EDT)
Received: from kumar by odessa with local (Exim 4.80)
	(envelope-from <a.kumar@alumni.iitm.ac.in>)	id 1V55nU-0007b6-AY; Thu,
 01 Aug 2013 23:12:56 -0400
In-reply-to: <CAFuPQ1LMJNhY-Lxx9-TnB+Z8hQXGEAY_xK8afZeSsHnG1JMoLQ@mail.gmail.com>
Mail-followup-to: Jonas Fonseca <fonseca@diku.dk>, git <git@vger.kernel.org>
Content-disposition: inline
X-OS: Linux odessa 3.3.0-trunk-amd64 x86_64
X-Operating-System: Linux odessa 3.3.0-trunk-amd64 x86_64
X-Editor: GNU Emacs 24.3.1
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231514>

On Thu, Aug 01, 2013 at 10:01:58PM -0400, Jonas Fonseca wrote:
> On Wed, Jul 31, 2013 at 11:11 PM, Kumar Appaiah
> <a.kumar@alumni.iitm.ac.in> wrote:
> > This commit introduces the VIEW_NO_PARENT_NAV flag and adds it to the
> > log view. This allows the scrolling commands to fall through from the
> > pager to the diff when the diff is viewed in the log mode.
> 
> Thanks, works like a charm.
> 
> BTW, please remember to label tig related patches by adding '[TIG]' or
> something similar in the subject so people on this list won't get
> confused.

Noted, and thanks!

Kumar
-- 
Kumar Appaiah
