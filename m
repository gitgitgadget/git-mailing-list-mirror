From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: cc/sequencer-rebase-i, was Re: What's cooking in git.git (Jul 2009,
 #03; Wed, 29)
Date: Thu, 30 Jul 2009 00:46:24 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0907300043420.8306@pacific.mpi-cbg.de>
References: <7vzlanqj9p.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 30 00:47:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWHvN-000382-6G
	for gcvg-git-2@gmane.org; Thu, 30 Jul 2009 00:47:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754856AbZG2WqN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jul 2009 18:46:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754772AbZG2WqN
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Jul 2009 18:46:13 -0400
Received: from mail.gmx.net ([213.165.64.20]:56629 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754826AbZG2WqM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jul 2009 18:46:12 -0400
Received: (qmail invoked by alias); 29 Jul 2009 22:46:12 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp029) with SMTP; 30 Jul 2009 00:46:12 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/OjPM/o0HOSFXnag5PwkKaJSrKyL1MLmdgkxx0Bt
	D/DFrW6JEkLDyb
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <7vzlanqj9p.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124402>

Hi,

On Wed, 29 Jul 2009, Junio C Hamano wrote:

> * cc/sequencer-rebase-i (Fri Jun 26 23:08:46 2009 +0200) 4 commits
>  - rebase -i: use "git sequencer--helper --make-patch"
>  - sequencer: free memory used in "make_patch" function
>  - sequencer: add "make_patch" function to save a patch
>  - sequencer: add "builtin-sequencer--helper.c"
> 
> I do not know how this will interact with what Dscho has been doing.

There was no interaction at all; no change I have been doing in my 
rebase-i-p branch was regarded in the sequencer-rebase-i branch.

I know I should work on this again (especially since I use it quite 
successfully myself to rebase interactively, preserving merges), but the 
God of time is not my friend.

Ciao,
Dscho
