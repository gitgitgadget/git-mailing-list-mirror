From: Gerrit Pape <pape@smarden.org>
Subject: Re: [PATCH 2/2] git-completion.bash: prevent 'git help' from searching for git repository
Date: Fri, 4 Sep 2009 12:49:04 +0000
Message-ID: <20090904124904.22288.qmail@103db479e31ab7.315fe32.mid.smarden.org>
References: <20090902095843.28914.qmail@3cd9dde586d86b.315fe32.mid.smarden.org> <fabb9a1e0909020447p212594cake8c6fe3a43b667ec@mail.gmail.com> <20090904092929.23208.qmail@00cf3567a0e8b4.315fe32.mid.smarden.org> <alpine.DEB.1.00.0909041217370.4605@intel-tinevez-2-302> <20090904110936.6663.qmail@046e1bfbf7e41d.315fe32.mid.smarden.org> <alpine.DEB.1.00.0909041434310.4605@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Sep 04 14:49:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MjYE6-0002q4-VF
	for gcvg-git-2@lo.gmane.org; Fri, 04 Sep 2009 14:49:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756798AbZIDMtG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Sep 2009 08:49:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756792AbZIDMtF
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Sep 2009 08:49:05 -0400
Received: from a.ns.smarden.org ([212.42.242.37]:4186 "HELO a.mx.smarden.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755882AbZIDMtF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Sep 2009 08:49:05 -0400
Received: (qmail 22289 invoked by uid 1000); 4 Sep 2009 12:49:04 -0000
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0909041434310.4605@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127731>

On Fri, Sep 04, 2009 at 02:35:00PM +0200, Johannes Schindelin wrote:
> Hi,
> 
> On Fri, 4 Sep 2009, Gerrit Pape wrote:
> 
> > On Fri, Sep 04, 2009 at 12:22:36PM +0200, Johannes Schindelin wrote:
> > > -- snipsnap --
> > > [PATCH] git help -a: do not look for a repository
> > 
> > Perfect, thanks.
> > 
> > Acked-by: Gerrit Pape <pape@smarden.org>
> 
> Hmm... I haven't checked if 'git help -a' wants to discover the (possibly 
> repository-specific) aliases.  Have you?

Yes, it doesn't.  Regards, Gerrit.
