From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] Add --reference option to git submodule
Date: Tue, 28 Apr 2009 14:25:19 +0300
Message-ID: <20090428112519.GB27513@redhat.com>
References: <20090428065237.GA5972@redhat.com> <49F6E419.1020308@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Apr 28 13:27:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LylSN-0006B5-Nx
	for gcvg-git-2@gmane.org; Tue, 28 Apr 2009 13:26:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758274AbZD1L01 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Apr 2009 07:26:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758268AbZD1L01
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Apr 2009 07:26:27 -0400
Received: from mx2.redhat.com ([66.187.237.31]:57052 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756747AbZD1L00 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Apr 2009 07:26:26 -0400
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.13.8/8.13.8) with ESMTP id n3SBQLki024523;
	Tue, 28 Apr 2009 07:26:22 -0400
Received: from ns3.rdu.redhat.com (ns3.rdu.redhat.com [10.11.255.199])
	by int-mx2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id n3SBQK0M012266;
	Tue, 28 Apr 2009 07:26:21 -0400
Received: from redhat.com (vpn-10-44.str.redhat.com [10.32.10.44])
	by ns3.rdu.redhat.com (8.13.8/8.13.8) with ESMTP id n3SBQIR7031450;
	Tue, 28 Apr 2009 07:26:19 -0400
Content-Disposition: inline
In-Reply-To: <49F6E419.1020308@drmicha.warpmail.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Scanned-By: MIMEDefang 2.58 on 172.16.27.26
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117764>

On Tue, Apr 28, 2009 at 01:10:17PM +0200, Michael J Gruber wrote:
> > +
> >  <path>...::
> >  	Paths to submodule(s). When specified this will restrict the command
> 
> Either "Path(s) to submodule(s)" or "Paths to submodules". I prefer the
> latter.
> 
> >  	to only operate on the submodules found at the specified paths.
> 
> ..to operate on... paths only.
> 

I didn't touch these lines, so ... patch?

-- 
MST
