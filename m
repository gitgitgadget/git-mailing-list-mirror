From: Marc Weber <marco-oweber@gmx.de>
Subject: Re: Feature Request: Branch Annotations
Date: Wed, 8 Oct 2008 14:08:47 +0200
Message-ID: <20081008120847.GD9428@gmx.de>
References: <d2115f4f0810080341m27c4ca9bv9b1e9b66704ef3fa@mail.gmail.com> <d2115f4f0810080348t62e18b14x1dfe798974332b05@mail.gmail.com> <d2115f4f0810080349o30b6bc2labc2745b8d981e0d@mail.gmail.com> <18071eea0810080355g743c7bbfq9d7d39c9a76eb59d@mail.gmail.com> <2faad3050810080441sdb1b29bxe92c467c2dd9a908@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 08 14:10:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KnXrf-00034V-Jr
	for gcvg-git-2@gmane.org; Wed, 08 Oct 2008 14:10:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751343AbYJHMIx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Oct 2008 08:08:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751299AbYJHMIx
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Oct 2008 08:08:53 -0400
Received: from mail.gmx.net ([213.165.64.20]:57833 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751191AbYJHMIw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Oct 2008 08:08:52 -0400
Received: (qmail invoked by alias); 08 Oct 2008 12:08:48 -0000
Received: from pD9E099F4.dip.t-dialin.net (EHLO nixos) [217.224.153.244]
  by mail.gmx.net (mp063) with SMTP; 08 Oct 2008 14:08:48 +0200
X-Authenticated: #9006135
X-Provags-ID: V01U2FsdGVkX1907ckz7wR0fWLnaCH2XyebRR00UMEEYBqR7O3hTR
	VLrX5aXKDTnlDC
Received: by nixos (sSMTP sendmail emulation); Wed, 08 Oct 2008 14:08:47 +0200
Mail-Followup-To: Marc Weber <marco-oweber@gmx.de>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <2faad3050810080441sdb1b29bxe92c467c2dd9a908@mail.gmail.com>
User-Agent: Mutt/1.5.15 (2007-04-06)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.66
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97796>

On Wed, Oct 08, 2008 at 12:41:43PM +0100, Baz wrote:
> 2008/10/8 Thomas Adam <thomas.adam22@gmail.com>:
> > 2008/10/8 Rotem Yaari <vmalloc@gmail.com>:
> >> Hi,
> >>
> >> I usually work with many branches in git, each of which represents a
> >> different state of development/stability, but also development tasks
> >> assigned to me.
> >> Sometimes, besides the name of the branch, it could be useful to have
> >> a short description of a branch which quickly reminds me what that
> >> branch is intended for.
> >>
> >> Currently I see no way in git to achieve this (there's a description
> >> for a repository, but not for individual branches).
> >>
> >> Any opinions on this?
[...]
Probably I've missed something. but doesn't top git add some special
files to remember branch relations?
I guess it removes them before merging upstream ?
I would have to reread the README or topGit source to confirm this.

Marc Weber
