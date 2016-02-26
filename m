From: Kevin Daudt <me@ikke.info>
Subject: Re: Restore Question
Date: Fri, 26 Feb 2016 18:13:33 +0100
Message-ID: <20160226171333.GB19120@ikke.info>
References: <loom.20160226T151716-809@post.gmane.org>
 <20160226164406.GA19120@ikke.info>
 <CY1PR06MB2155A1C2369E836CF8A34839CCA70@CY1PR06MB2155.namprd06.prod.outlook.com>
Reply-To: git@lists.ikke.info
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Gerald McKinley <gmckinley@ventureforth.com>
X-From: git-owner@vger.kernel.org Fri Feb 26 18:13:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZLxT-00056j-4n
	for gcvg-git-2@plane.gmane.org; Fri, 26 Feb 2016 18:13:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754702AbcBZRNf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Feb 2016 12:13:35 -0500
Received: from ikke.info ([178.21.113.177]:40018 "EHLO vps892.directvps.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754513AbcBZRNe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Feb 2016 12:13:34 -0500
Received: by vps892.directvps.nl (Postfix, from userid 1008)
	id 203C94400B2; Fri, 26 Feb 2016 18:13:33 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <CY1PR06MB2155A1C2369E836CF8A34839CCA70@CY1PR06MB2155.namprd06.prod.outlook.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287594>

On Fri, Feb 26, 2016 at 04:53:35PM +0000, Gerald  McKinley wrote:
> I have git running on a vm.  One of the repos got messed up.  I restored the
> vm from the previous day.  I gave the vm a different ip address and hostname.
> I did not see all my files in the repo.
> 
> -----Original Message-----
> From: Kevin Daudt [mailto:me@ikke.info] 
> Sent: Friday, February 26, 2016 11:44 AM
> To: Gerald McKinley <gmckinley@ventureforth.com>
> Cc: git@vger.kernel.org
> Subject: Re: Restore Question
> 
> On Fri, Feb 26, 2016 at 02:18:16PM +0000, Gerald wrote:
> > I have git running on a VMware virtual machine.  I backup the virtual 
> > machine every day.  How do I restore git from a restore of the
> > virtual machine?
> > 
> 
> Can you explain what you mean exactly with restoring git? It's unclear
> what you want to achieve.
> 
> Retrieving a git repository is just a matter of copying the entiry
> repository directory (including .git dir).

Please don't remove the gist mailing list from the CC (use reply all).

Is this VM used to host the repositories, meaning, are they bare
repositories? 

You have to be a little more verbose, it's hard for us to guess what is
going on.

If you have restored the VM, it's just a matter of copying the
repository directory from the backup vm to the current VM..
