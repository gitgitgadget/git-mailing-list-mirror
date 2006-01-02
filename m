From: Gerrit Pape <pape@smarden.org>
Subject: Re: [PATCH] debian/ directory
Date: Mon, 2 Jan 2006 11:31:38 +0100
Message-ID: <20060102103138.3414.qmail@e631ec7a6a8b9a.315fe32.mid.smarden.org>
References: <7v64pbc4fh.fsf@assigned-by-dhcp.cox.net> <20051228112018.19646.qmail@c226d15586b0bf.315fe32.mid.smarden.org> <87oe31urge.kvalo.fsf@purkki.valo.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Jan 02 11:32:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EtMyp-00034O-Vg
	for gcvg-git@gmane.org; Mon, 02 Jan 2006 11:31:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932250AbWABKbb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 Jan 2006 05:31:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932251AbWABKbb
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jan 2006 05:31:31 -0500
Received: from a.mx.smarden.org ([212.21.76.77]:51889 "HELO a.mx.smarden.org")
	by vger.kernel.org with SMTP id S932250AbWABKba (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Jan 2006 05:31:30 -0500
Received: (qmail 3415 invoked by uid 1000); 2 Jan 2006 10:31:38 -0000
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <87oe31urge.kvalo.fsf@purkki.valo.iki.fi>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14137>

On Wed, Dec 28, 2005 at 06:17:05PM +0200, Kalle Valo wrote:
> Gerrit Pape <pape@smarden.org> writes:
> > Below is the diff for reference, I think though it might be better if
> > you don't include the debian/ directory in the upstream package at all.
> 
> One upside in Junio's debian packages is that they[1] work also in
> sarge[2]. If he stops building them, we sarge users will miss them.
> Any volunteers to maintain them, for example, through backports.org?

Thanks to Norbert Tretkowski, the git* and cogito packages are now
available for Debian sarge through http://backports.org/.

Regards, Gerrit.
