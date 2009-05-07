From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCHv3] Add --reference option to git submodule.
Date: Thu, 7 May 2009 17:16:56 +0300
Message-ID: <20090507141656.GA1770@redhat.com>
References: <20090504193001.GA13719@redhat.com> <49FFE771.1030208@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu May 07 16:20:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M24SC-0000Sj-Ce
	for gcvg-git-2@gmane.org; Thu, 07 May 2009 16:20:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757677AbZEGOT4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2009 10:19:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757035AbZEGOTz
	(ORCPT <rfc822;git-outgoing>); Thu, 7 May 2009 10:19:55 -0400
Received: from mx2.redhat.com ([66.187.237.31]:38092 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756135AbZEGOTz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2009 10:19:55 -0400
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.13.8/8.13.8) with ESMTP id n47EI0SD030460;
	Thu, 7 May 2009 10:18:00 -0400
Received: from ns3.rdu.redhat.com (ns3.rdu.redhat.com [10.11.255.199])
	by int-mx2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id n47EHxMP002862;
	Thu, 7 May 2009 10:17:59 -0400
Received: from redhat.com (dhcp-0-223.tlv.redhat.com [10.35.0.223])
	by ns3.rdu.redhat.com (8.13.8/8.13.8) with ESMTP id n47EHsiF002264;
	Thu, 7 May 2009 10:17:55 -0400
Content-Disposition: inline
In-Reply-To: <49FFE771.1030208@drmicha.warpmail.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Scanned-By: MIMEDefang 2.58 on 172.16.27.26
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118480>

On Tue, May 05, 2009 at 09:14:57AM +0200, Michael J Gruber wrote:
> Michael S. Tsirkin venit, vidit, dixit 04.05.2009 21:30:
> > This adds --reference option to git submodule add and
> > git submodule update commands, which is passed to git clone.
> > 
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> > 
> > I think it's ready now :) Comments?
> 
> Please don't expect Junio to look at this now, shortly before 1.6.3.

Hey Junio, now that 1.6.3 is out, could you please give this patch
a consideration? Should I repost?

-- 
MST
