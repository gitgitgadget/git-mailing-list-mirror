From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCHv2] Add --reference option to git submodule.
Date: Mon, 4 May 2009 20:57:57 +0300
Message-ID: <20090504175757.GA1144@redhat.com>
References: <20090428123033.GA6839@redhat.com> <49F702C0.8030206@drmicha.warpmail.net> <7vskjslig6.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 04 20:00:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M12Sk-0000aM-91
	for gcvg-git-2@gmane.org; Mon, 04 May 2009 20:00:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757483AbZEDSAE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 May 2009 14:00:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758775AbZEDSAB
	(ORCPT <rfc822;git-outgoing>); Mon, 4 May 2009 14:00:01 -0400
Received: from mx2.redhat.com ([66.187.237.31]:60703 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758771AbZEDSAA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 May 2009 14:00:00 -0400
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.13.8/8.13.8) with ESMTP id n44Hx0nN001393;
	Mon, 4 May 2009 13:59:01 -0400
Received: from ns3.rdu.redhat.com (ns3.rdu.redhat.com [10.11.255.199])
	by int-mx2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id n44HwwZA016807;
	Mon, 4 May 2009 13:58:59 -0400
Received: from redhat.com (vpn-10-18.str.redhat.com [10.32.10.18])
	by ns3.rdu.redhat.com (8.13.8/8.13.8) with ESMTP id n44HwsnK030688;
	Mon, 4 May 2009 13:58:57 -0400
Content-Disposition: inline
In-Reply-To: <7vskjslig6.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Scanned-By: MIMEDefang 2.58 on 172.16.27.26
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118254>

On Tue, Apr 28, 2009 at 11:52:09AM -0700, Junio C Hamano wrote:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
> > Michael S. Tsirkin venit, vidit, dixit 28.04.2009 14:30:
> >> This adds --reference option to git submodule add and
> >> git submodule update commands, which is passed on to git clone.
> >> 
> >> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> >> ---
> >> 
> >> Here's v2. Ack?
> >
> > I don't think it's up to me to Ack but you addressed my remarks.
> 
> You can certainly say "Reviewed-by: me" and/or "Tested-by: me".

So ... Junio, what do you think about the patch?

-- 
MST
