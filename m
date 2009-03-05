From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: notes, was Re: What's cooking in git.git (Mar 2009, #02; Thu, 05)
Date: Thu, 5 Mar 2009 12:04:26 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903051204010.6524@intel-tinevez-2-302>
References: <7vbpsg2sgx.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 05 12:06:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfBOl-00018V-N2
	for gcvg-git-2@gmane.org; Thu, 05 Mar 2009 12:05:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755367AbZCELEb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Mar 2009 06:04:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754580AbZCELEa
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Mar 2009 06:04:30 -0500
Received: from mail.gmx.net ([213.165.64.20]:59923 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755287AbZCELE3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Mar 2009 06:04:29 -0500
Received: (qmail invoked by alias); 05 Mar 2009 11:04:27 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp028) with SMTP; 05 Mar 2009 12:04:27 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18Rs3AZFiURD+7U0U0sGBwsHBp9q9BqtUFai0GnC0
	DUKmvyLUilQpia
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <7vbpsg2sgx.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112297>

Hi,

On Thu, 5 Mar 2009, Junio C Hamano wrote:

> * js/notes (Wed Feb 18 11:17:27 2009 -0800) 14 commits
>  - tests: fix "export var=val"
>  - notes: refuse to edit notes outside refs/notes/
>  - t3301: use test_must_fail instead of !
>  - t3301: fix confusing quoting in test for valid notes ref
>  - notes: use GIT_EDITOR and core.editor over VISUAL/EDITOR
>  - notes: only clean up message file when editing
>  - handle empty notes gracefully
>  - git notes show: test empty notes
>  - git-notes: fix printing of multi-line notes
>  - notes: fix core.notesRef documentation
>  - Add an expensive test for git-notes
>  - Speed up git notes lookup
>  - Add a script to edit/inspect notes
>  - Introduce commit notes
> 
> Rebased and then kicked back to 'pu' to give the author a chance to
> rearrange if necessary.  I might do some trivial squashing myself.

Will do.

Thanks,
Dscho
