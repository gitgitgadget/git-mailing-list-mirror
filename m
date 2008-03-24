From: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
Subject: Re: [ANNOUNCE] Stacked GIT 0.14.2
Date: Mon, 24 Mar 2008 19:55:34 -0400
Message-ID: <20080324235534.GE32221@josefsipek.net>
References: <b0943d9e0803241259s5280cdc1o255a4412b3fa7bfc@mail.gmail.com> <alpine.LNX.1.10.0803242113070.9368@fbirervta.pbzchgretzou.qr> <47E81037.5030808@keyaccess.nl> <7vlk47ua3v.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Rene Herman <rene.herman@keyaccess.nl>,
	Catalin Marinas <catalin.marinas@gmail.com>,
	Jan Engelhardt <jengelh@computergmbh.de>,
	git <git@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 25 00:56:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdwWy-0004wi-DR
	for gcvg-git-2@gmane.org; Tue, 25 Mar 2008 00:56:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754581AbYCXXzv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Mar 2008 19:55:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754477AbYCXXzv
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Mar 2008 19:55:51 -0400
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:44382 "EHLO
	filer.fsl.cs.sunysb.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754209AbYCXXzu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Mar 2008 19:55:50 -0400
Received: from josefsipek.net (baal.fsl.cs.sunysb.edu [130.245.126.78])
	by filer.fsl.cs.sunysb.edu (8.12.11.20060308/8.13.1) with ESMTP id m2ONtWvr015933;
	Mon, 24 Mar 2008 19:55:32 -0400
Received: by josefsipek.net (Postfix, from userid 1000)
	id 44EAF1C00124; Mon, 24 Mar 2008 19:55:34 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7vlk47ua3v.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78131>

On Mon, Mar 24, 2008 at 01:43:00PM -0700, Junio C Hamano wrote:
> Rene Herman <rene.herman@keyaccess.nl> writes:
> 
> > On 24-03-08 21:15, Jan Engelhardt wrote:
> >
> >> On Monday 2008-03-24 20:59, Catalin Marinas wrote:
> >>
> >>> Stacked GIT 0.14.2 release is available from
> >>> http://www.procode.org/stgit/.
> >>>
> >>> StGIT is a Python application providing similar functionality to Quilt
> >>> (i.e. pushing/popping patches to/from a stack) on top of GIT.
> >>
> >> I always wondered what the difference between stgit and guilt is.
> >> Does anyone have a comparison up?
> >
> > And I remember some mumblings about git growing quilt-like
> > functionality itself. Anything on that?
> 
> Not my mumbling, but I am quite open to slurp in guilt as a subdirectory
> in git.git at some point in the future just like we bundle git-gui and
> gitk if asked by the maintainer.
 
Junio,

That'd be great!  Is there anything special you want me to do?  Well, I want
to finish up a merge I've been working on first.

Josef 'Jeff' Sipek.

-- 
Once you have their hardware. Never give it back.
(The First Rule of Hardware Acquisition)
