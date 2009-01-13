From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-patches list?
Date: Tue, 13 Jan 2009 12:02:24 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901131158500.3586@pacific.mpi-cbg.de>
References: <90bb445a0901121543q29d30d49yaa723b4b913a4b31@mail.gmail.com> <7vr638f5ch.fsf@gitster.siamese.dyndns.org> <496C502A.3070908@op5.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Akira Kitada <akitada@gmail.com>, git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Tue Jan 13 12:03:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMh36-0002bg-Du
	for gcvg-git-2@gmane.org; Tue, 13 Jan 2009 12:03:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752240AbZAMLBh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jan 2009 06:01:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752103AbZAMLBh
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Jan 2009 06:01:37 -0500
Received: from mail.gmx.net ([213.165.64.20]:41659 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752063AbZAMLBg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jan 2009 06:01:36 -0500
Received: (qmail invoked by alias); 13 Jan 2009 11:01:34 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp001) with SMTP; 13 Jan 2009 12:01:34 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+gR1UoRdigH8oNJ5MWWAZcUfVIcTg0TwZX//NtUm
	PBTruLF5YJYEL6
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <496C502A.3070908@op5.se>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.65
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105483>

Hi,

On Tue, 13 Jan 2009, Andreas Ericsson wrote:

> Junio C Hamano wrote:
> > Akira Kitada <akitada@gmail.com> writes:
> > 
> > > Can I propose having another mailing list for posting patches to avoid
> > > daily mail flood to this list?
> > >
> > > Yes, I can filter out the emails but still...
> > 
> > This list has always been the only place where git development happens.
> > It would make the development very awkward to set up another list only for
> > patches, forbid patches to be sent to anywhere but that new list, but
> > still discuss the patches on this list.
> > 
> > It does not make much sense to me.
> > 
> 
> I agree.
> 
> If any new list is to be introduced, it would only make sense to make it
> a read-only "what's new" list, for the various people that want to know
> what might break/be fixed in new versions but really don't care about the
> discussion that lead to that decision.

If that's what you want, I suggest having a look at 

	http://gitrss.q42.co.uk/

I am sure that Julian can be convinced to filter "[PATCH", too.

Ciao,
Dscho
