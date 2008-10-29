From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: exporting the last N days of a repository
Date: Wed, 29 Oct 2008 16:10:57 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0810291610340.22125@pacific.mpi-cbg.de.mpi-cbg.de>
References: <93c3eada0810281801l29253e02g95c7a6851c4c4db3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Geoff Russell <geoffrey.russell@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 29 16:06:34 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvCbQ-0003fh-Cc
	for gcvg-git-2@gmane.org; Wed, 29 Oct 2008 16:04:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753942AbYJ2PDn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Oct 2008 11:03:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753934AbYJ2PDn
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Oct 2008 11:03:43 -0400
Received: from mail.gmx.net ([213.165.64.20]:34719 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753174AbYJ2PDn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Oct 2008 11:03:43 -0400
Received: (qmail invoked by alias); 29 Oct 2008 15:03:40 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp053) with SMTP; 29 Oct 2008 16:03:40 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+raFJvmySruP5zRDukvV7tK6dQ+xHi7AAfEmjjL3
	sxlFcSwdarzEUa
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <93c3eada0810281801l29253e02g95c7a6851c4c4db3@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.76
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99369>

Hi,

On Wed, 29 Oct 2008, Geoff Russell wrote:

> I want to export "the last N days" of a repository to create a copy 
> which has an origin which is the state of the repository N days ago and 
> has all the history between then and now.
> 
> Can fast-export do this?

Yes.  See the --since=... option.

Hth,
Dscho
