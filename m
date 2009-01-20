From: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>
Subject: Re: [PATCH] Fix naming scheme for configure cache variables.
Date: Tue, 20 Jan 2009 08:08:52 +0100
Organization: Department of Numerical Simulation, University of Bonn
Message-ID: <20090120070852.GE5561@ins.uni-bonn.de>
References: <20090119203436.GB3539@ins.uni-bonn.de> <7vljt6mqv0.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 20 08:10:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPAke-0007rY-39
	for gcvg-git-2@gmane.org; Tue, 20 Jan 2009 08:10:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754175AbZATHI4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jan 2009 02:08:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754083AbZATHIz
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jan 2009 02:08:55 -0500
Received: from merkur.ins.uni-bonn.de ([131.220.223.13]:48143 "EHLO
	merkur.ins.uni-bonn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751657AbZATHIz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jan 2009 02:08:55 -0500
Received: from localhost.localdomain (xdsl-87-78-160-12.netcologne.de [87.78.160.12])
	by merkur.ins.uni-bonn.de (Postfix) with ESMTP id 8829F40003E4A;
	Tue, 20 Jan 2009 08:08:53 +0100 (CET)
Received: from ralf by localhost.localdomain with local (Exim 4.69)
	(envelope-from <Ralf.Wildenhues@gmx.de>)
	id 1LPAjE-0001e7-MV; Tue, 20 Jan 2009 08:08:52 +0100
Mail-Followup-To: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vljt6mqv0.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106451>

* Junio C Hamano wrote on Tue, Jan 20, 2009 at 07:30:27AM CET:
> Ralf Wildenhues <Ralf.Wildenhues@gmx.de> writes:
> 
> > In order to be cached, configure variables need to contain the
> > string '_cv_', and they should begin with a package-specific
> > prefix in order to avoid interfering with third-party macros.
> > Rename ld_dashr, ld_wl_rpath, ld_rpath to git_cv_ld_dashr etc.

> We require every patch we accept to be accompanied with a sign-off.
> 
> Can you certify that ... [see Documentation/SubmittingPatches and look for
> (4) Sign your work] ... please?

Signed-off-by: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>

Sorry about that.

Cheers,
Ralf
