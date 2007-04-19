From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH] user-manual.txt: Some doc updates
Date: Thu, 19 Apr 2007 13:01:57 -0400
Message-ID: <20070419170157.GF9101@fieldses.org>
References: <87hcrcjre3.fsf@gmail.com> <20070419160235.GE9101@fieldses.org> <alpine.LFD.0.98.0704191205420.4504@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Santi =?iso-8859-1?Q?B=E9jar?= <sbejar@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Thu Apr 19 19:02:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hea1H-00081L-Sa
	for gcvg-git@gmane.org; Thu, 19 Apr 2007 19:02:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1766881AbXDSRCD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Apr 2007 13:02:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1766882AbXDSRCD
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Apr 2007 13:02:03 -0400
Received: from mail.fieldses.org ([66.93.2.214]:43877 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1766881AbXDSRCA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Apr 2007 13:02:00 -0400
Received: from bfields by fieldses.org with local (Exim 4.63)
	(envelope-from <bfields@fieldses.org>)
	id 1Hea17-00040A-JJ; Thu, 19 Apr 2007 13:01:57 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.98.0704191205420.4504@xanadu.home>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45031>

On Thu, Apr 19, 2007 at 12:07:01PM -0400, Nicolas Pitre wrote:
> On Thu, 19 Apr 2007, J. Bruce Fields wrote:
> 
> > It was a conscious decision to use a mixture of the two techniques; see,
> > e.g.,
> > 
> > 	http://marc.info/?l=git&m=116994435503452&w=2
> > 
> > and followups.
> 
> Maybe it should be said more explicitly that both are fine.

Yes.  If I were to do that I'd do it by first rewriting the DESCRIPTION
section of git-config.txt to make this point clearer, then making sure
there's a gitlink:git-config[1] everywhere there should be in the
manual.  But we could also add a sentence in the manual here.

--b.
