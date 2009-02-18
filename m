From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What's cooking in git.git (Feb 2009, #05; Mon, 16)
Date: Wed, 18 Feb 2009 13:05:29 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902181304590.6274@intel-tinevez-2-302>
References: <7vfxid8phr.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 18 13:07:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZlCy-0005vo-Nb
	for gcvg-git-2@gmane.org; Wed, 18 Feb 2009 13:07:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753409AbZBRMFe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Feb 2009 07:05:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753351AbZBRMFd
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Feb 2009 07:05:33 -0500
Received: from mail.gmx.net ([213.165.64.20]:38569 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753368AbZBRMFc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Feb 2009 07:05:32 -0500
Received: (qmail invoked by alias); 18 Feb 2009 12:05:30 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp018) with SMTP; 18 Feb 2009 13:05:30 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/uGdkCce7uFU4t+OVf3wgfJxK+2HMjvAo3Dn+AEr
	J3kIsJ67rJrwq1
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <7vfxid8phr.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.61
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110529>

Hi,

On Mon, 16 Feb 2009, Junio C Hamano wrote:

> * js/notes (Sat Feb 14 21:23:25 2009 +0100) 13 commits
>  - notes: refuse to edit notes outside refs/notes/
>  - t3301: use test_must_fail instead of !
>  - t3301: fix confusing quoting in test for valid notes ref
>  - notes: use GIT_EDITOR and core.editor over VISUAL/EDITOR
>  - notes: only clean up message file when editing
>  - handle empty notes gracefully
>  + git notes show: test empty notes
>  + git-notes: fix printing of multi-line notes
>  + notes: fix core.notesRef documentation
>  + Add an expensive test for git-notes
>  + Speed up git notes lookup
>  + Add a script to edit/inspect notes
>  + Introduce commit notes
> 
> Earlier part was merged to master and then reverted there.  I probably
> should rebase this after 1.6.2 to keep my sanity.

Yes, please.

Ciao,
Dscho
