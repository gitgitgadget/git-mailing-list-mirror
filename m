From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: What's cooking in git.git (Nov 2009, #06; Wed, 25)
Date: Fri, 27 Nov 2009 14:17:36 -0500 (EST)
Message-ID: <alpine.LNX.2.00.0911271417010.14365@iabervon.org>
References: <7v8wduksgq.fsf@alter.siamese.dyndns.org> <fabb9a1e0911251715u661ce0aem79a4d700d552e105@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1547844168-1469828165-1259349456=:14365"
Cc: Junio C Hamano <gitster@pobox.com>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 27 20:44:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NE6jv-0001Th-4C
	for gcvg-git-2@lo.gmane.org; Fri, 27 Nov 2009 20:44:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752179AbZK0ToL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Nov 2009 14:44:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751741AbZK0ToK
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Nov 2009 14:44:10 -0500
Received: from iabervon.org ([66.92.72.58]:36388 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751907AbZK0ToK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Nov 2009 14:44:10 -0500
Received: (qmail 26662 invoked by uid 1000); 27 Nov 2009 19:17:36 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 27 Nov 2009 19:17:36 -0000
In-Reply-To: <fabb9a1e0911251715u661ce0aem79a4d700d552e105@mail.gmail.com>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133926>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1547844168-1469828165-1259349456=:14365
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT

On Thu, 26 Nov 2009, Sverre Rabbelier wrote:

> Heya,
> 
> On Thu, Nov 26, 2009 at 02:03, Junio C Hamano <gitster@pobox.com> wrote:
> > * sr/vcs-helper (2009-11-18) 12 commits
> >  - Add Python support library for remote helpers
> >  - Basic build infrastructure for Python scripts
> >  - Allow helpers to report in "list" command that the ref is unchanged
> >  - Fix various memory leaks in transport-helper.c
> >  - Allow helper to map private ref names into normal names
> >  - Add support for "import" helper command
> >  - Allow specifying the remote helper in the url
> >  - Add a config option for remotes to specify a foreign vcs
> >  - Allow fetch to modify refs
> >  - Use a function to determine whether a remote is valid
> >  - Allow programs to not depend on remotes having urls
> >  - Fix memory leak in helper method for disconnect
> >
> > Replaced again, and looking good.  Perhaps Daniel has some comments?
> 
> Indeed, Johan, Daniel, is the current version good for next?

Looks good to me.

	-Daniel
*This .sig left intentionally blank*
--1547844168-1469828165-1259349456=:14365--
