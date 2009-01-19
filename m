From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What's cooking in git.git (Jan 2009, #04; Mon, 19)
Date: Mon, 19 Jan 2009 14:08:48 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901191407470.3586@pacific.mpi-cbg.de>
References: <7vbpu3r745.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 19 14:10:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOttN-0000w3-0p
	for gcvg-git-2@gmane.org; Mon, 19 Jan 2009 14:10:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760056AbZASNIs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Jan 2009 08:08:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759527AbZASNIr
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Jan 2009 08:08:47 -0500
Received: from mail.gmx.net ([213.165.64.20]:34074 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759985AbZASNIq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Jan 2009 08:08:46 -0500
Received: (qmail invoked by alias); 19 Jan 2009 13:08:45 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp020) with SMTP; 19 Jan 2009 14:08:45 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19gydYxoKxg3ZxyvLZBQokrqXifv1EjY48TuhCDVO
	kHQ+NbCW9JEDRs
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <7vbpu3r745.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.59
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106354>

Hi,

On Mon, 19 Jan 2009, Junio C Hamano wrote:

> * js/diff-color-words (Sat Jan 17 17:29:48 2009 +0100) 7 commits
>  - color-words: make regex configurable via attributes
>  - color-words: expand docs with precise semantics
>  - color-words: enable REG_NEWLINE to help user
>  - color-words: take an optional regular expression describing words
>  - color-words: change algorithm to allow for 0-character word
>    boundaries
>  - color-words: refactor word splitting and use ALLOC_GROW()
>  - Add color_fwrite_lines(), a function coloring each line
>    individually
> 
> Dscho's series that was done in response to Thomas's original; two agreed
> to work together on this codebase.

I am actually pretty comfortable with this series now.

> * jk/valgrind (Thu Oct 23 04:30:45 2008 +0000) 2 commits
>  . valgrind: ignore ldso errors
>  . add valgrind support in test scripts

Could you put this in pu, at least, please?

Thanks,
Dscho
