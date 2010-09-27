From: Casey Dahlin <cdahlin@redhat.com>
Subject: Re: GIT and Cloning Remote Repositories into "Local Remote"
 Repositories
Date: Mon, 27 Sep 2010 11:18:08 -0400
Message-ID: <20100927151807.GE31809@foucault.redhat.com>
References: <20100921013700.GC8380@foucault.redhat.com>
 <C8C53EC9.1E621%gerickson@nuovations.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Grant Erickson <gerickson@nuovations.com>
X-From: git-owner@vger.kernel.org Mon Sep 27 17:18:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0FTF-0001Cu-3U
	for gcvg-git-2@lo.gmane.org; Mon, 27 Sep 2010 17:18:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759589Ab0I0PSP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Sep 2010 11:18:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36047 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756157Ab0I0PSO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Sep 2010 11:18:14 -0400
Received: from int-mx02.intmail.prod.int.phx2.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id o8RFIDoj009617
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Mon, 27 Sep 2010 11:18:13 -0400
Received: from foucault.redhat.com (vpn-11-203.rdu.redhat.com [10.11.11.203])
	by int-mx02.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id o8RFI8iu014775
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Mon, 27 Sep 2010 11:18:12 -0400
Content-Disposition: inline
In-Reply-To: <C8C53EC9.1E621%gerickson@nuovations.com>
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157339>

On Sun, Sep 26, 2010 at 06:17:45PM -0700, Grant Erickson wrote:
> On 9/20/10 6:37 PM, Casey Dahlin wrote:
> > On Mon, Sep 20, 2010 at 06:22:09PM -0700, Grant Erickson wrote:
> >> Perhaps 'submodules' are what I am looking for?
> >> 
> > 
> > Yup, exactly :) the manpage git submodule should get you going.
> 
> Casey:
> 
> Thanks for the prompt reply.
> 
> I spent some time over the weekend playing with the various submodule
> tutorials and I wasn't left feeling convinced that it's the right solution,
> particularly with the added complexity around commits and pushes (trailing
> slashes, etc.) that I am sure my users are going to get wrong more often
> than right.
> 
*snip*
> 
> And so on for the linux subtree as well. Any further tips or course
> corrections you can offer, particularly relative to subtree merges?
> 

Unfortunately I'm not an expert here. I know what submodules do but I haven't
used them much (in fact I last looked at them just after they were introduced.
They were even rougher back then).

I may have missed it but if you haven't I'd update the list on all of this
again.

--CJD
