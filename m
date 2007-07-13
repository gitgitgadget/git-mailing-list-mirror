From: Gerrit Pape <pape@smarden.org>
Subject: Re: pull-fetch-param.txt
Date: Fri, 13 Jul 2007 05:53:46 +0000
Message-ID: <20070713055346.634.qmail@1e54e4f4e1041d.315fe32.mid.smarden.org>
References: <tkrat.4532d38d43e16a62@s5r6.in-berlin.de> <7vhcymt07a.fsf@assigned-by-dhcp.cox.net> <452211C2.8020402@s5r6.in-berlin.de> <7vven1rfpj.fsf@assigned-by-dhcp.cox.net> <45222B18.1090305@s5r6.in-berlin.de> <20070712130631.13667.qmail@594d46613ccd9b.315fe32.mid.smarden.org> <7vvecps2rz.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 13 07:53:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I9E5r-0005Fb-RN
	for gcvg-git@gmane.org; Fri, 13 Jul 2007 07:53:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932122AbXGMFx2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Jul 2007 01:53:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751827AbXGMFx1
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jul 2007 01:53:27 -0400
Received: from a.ns.smarden.org ([212.42.242.37]:41402 "HELO a.mx.smarden.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932910AbXGMFx1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jul 2007 01:53:27 -0400
Received: (qmail 635 invoked by uid 1000); 13 Jul 2007 05:53:46 -0000
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vvecps2rz.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52362>

On Thu, Jul 12, 2007 at 02:58:08PM -0700, Junio C Hamano wrote:
> Gerrit Pape <pape@smarden.org> writes:
> > Hi, this still is a problem, at least on Debian/unstable; with asciidoc
> > 8.2.1, the git-push(1) and git-fetch(1) man pages have this 'broken'
> > refspec description[0].
> 
> Quick question.  Is the build done with "make
> ASCIIDOC8=YesPlease"?

No, must have missed that.  This solves the first issue with the refspec
in git-push(1), git-fetch(1), but not the second one with callout lists.

Thanks, Gerrit.
