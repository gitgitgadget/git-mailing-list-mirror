From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: auto-merge after push?
Date: Mon, 11 May 2009 23:17:05 +0300
Message-ID: <20090511201705.GA21045@redhat.com>
References: <20090511142326.GA18260@redhat.com> <alpine.DEB.1.00.0905111714250.4973@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon May 11 22:18:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3bx5-0000T3-Uj
	for gcvg-git-2@gmane.org; Mon, 11 May 2009 22:18:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755499AbZEKUSL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 May 2009 16:18:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755410AbZEKUSK
	(ORCPT <rfc822;git-outgoing>); Mon, 11 May 2009 16:18:10 -0400
Received: from mx2.redhat.com ([66.187.237.31]:58338 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754868AbZEKUSJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 May 2009 16:18:09 -0400
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.13.8/8.13.8) with ESMTP id n4BKI85j021577;
	Mon, 11 May 2009 16:18:08 -0400
Received: from ns3.rdu.redhat.com (ns3.rdu.redhat.com [10.11.255.199])
	by int-mx2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id n4BKI7wI011096;
	Mon, 11 May 2009 16:18:07 -0400
Received: from redhat.com (vpn-10-19.str.redhat.com [10.32.10.19])
	by ns3.rdu.redhat.com (8.13.8/8.13.8) with ESMTP id n4BKI3pp019840;
	Mon, 11 May 2009 16:18:03 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0905111714250.4973@intel-tinevez-2-302>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Scanned-By: MIMEDefang 2.58 on 172.16.27.26
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118842>

On Mon, May 11, 2009 at 05:18:06PM +0200, Johannes Schindelin wrote:
> The thing is, a merge can fail.  And then you already need direct access 
> to the working directory in question.
> 
> If you were actually talking about fast-forward pushes (because you did 
> the merge locally already), this might help you:
> 
> 	http://thread.gmane.org/gmane.comp.version-control.git/110251
> 
> Ciao,
> Dscho

Sounds good. But it looks like this patch is unlikely to be merged,
does it not?

-- 
MST
