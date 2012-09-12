From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] gitk: Rename 'tagcontents' to 'cached_tagcontent'
Date: Wed, 12 Sep 2012 22:37:56 +1000
Message-ID: <20120912123756.GA26593@bloggs.ozlabs.ibm.com>
References: <1347130993-69863-1-git-send-email-davvid@gmail.com>
 <1347133996-70908-1-git-send-email-davvid@gmail.com>
 <7v392ru6ex.fsf@alter.siamese.dyndns.org>
 <7v8vcffv93.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Aguilar <davvid@gmail.com>,
	Tim McCormack <cortex@brainonfire.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 12 14:37:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TBmCU-0007bD-K5
	for gcvg-git-2@plane.gmane.org; Wed, 12 Sep 2012 14:37:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757722Ab2ILMhg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Sep 2012 08:37:36 -0400
Received: from ozlabs.org ([203.10.76.45]:42377 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754776Ab2ILMhd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Sep 2012 08:37:33 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 75CFC2C0092; Wed, 12 Sep 2012 22:37:32 +1000 (EST)
Content-Disposition: inline
In-Reply-To: <7v8vcffv93.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205283>

On Wed, Sep 12, 2012 at 02:25:28AM -0700, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > I've applied these two, on top of Paul's master branch at
> >
> >     git://ozlabs.org/~paulus/gitk.git
> >
> > and tentatively queued in 'pu', but I would prefer to see it
> > eyeballed by and queued in his tree first.
> >
> > Thanks.
> 
> Pinging Paul...
> 
> The following changes since commit a135f214e371311f13807da637d492fd9642a2e3:
> 
>   gitk: Avoid Meta1-F5 (2012-04-25 13:44:31 +1000)
> 
> are available in the git repository at:
> 
>   git://github.com/gitster/git da/gitk-reload-tag-contents
> 
> for you to fetch changes up to 587277fea3bf3bfc4302480178bd88a277a69f05:
> 
>   gitk: Rename 'tagcontents' to 'cached_tagcontent' (2012-09-08 20:25:09 -0700)

Thanks, pulled and pushed out.  I had one other commit queued up, so
if you pull from git://ozlabs.org/~paulus/gitk.git you will get that
plus a merge.

Paul.
