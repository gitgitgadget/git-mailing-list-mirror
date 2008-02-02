From: Jari Aalto <jari.aalto@cante.net>
Subject: Re: [PATCH] Documentation/git-stash.txt: Adjust SYNOPSIS command syntaxes
Date: Sat, 02 Feb 2008 03:43:06 +0200
Organization: Private
Message-ID: <y7a45e1h.fsf@blue.sea.net>
References: <7ihp802o.fsf@blue.sea.net> <m37iho9b70.fsf@localhost.localdomain>
	<1w7w966m.fsf@blue.sea.net> <m33asc94xn.fsf@localhost.localdomain>
	<k5lo716v.fsf@blue.sea.net>
	<7vejbw8die.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 02 02:45:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JL7Rr-00020d-Q5
	for gcvg-git-2@gmane.org; Sat, 02 Feb 2008 02:45:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752955AbYBBBpG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Feb 2008 20:45:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751986AbYBBBpG
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Feb 2008 20:45:06 -0500
Received: from main.gmane.org ([80.91.229.2]:45900 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752174AbYBBBpE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Feb 2008 20:45:04 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1JL7RH-0008Ky-05
	for git@vger.kernel.org; Sat, 02 Feb 2008 01:45:03 +0000
Received: from a91-155-183-103.elisa-laajakaista.fi ([91.155.183.103])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 02 Feb 2008 01:45:02 +0000
Received: from jari.aalto by a91-155-183-103.elisa-laajakaista.fi with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 02 Feb 2008 01:45:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: a91-155-183-103.elisa-laajakaista.fi
User-Agent: Gnus/5.110007 (No Gnus v0.7) Emacs/22.1 (windows-nt)
Cancel-Lock: sha1:TLWVaJ13fQTBMUF06BR0me85PZ0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72205>

* Fri 2008-02-01 Junio C Hamano <gitster@pobox.com>
* Message-Id: 7vejbw8die.fsf@gitster.siamese.dyndns.org
> GNU 'cpio' makes it somewhat easier to read by listing
> subcommands separately:
>
>   SYNOPSIS
>     cpio  {-o|--create} [-0acvABLV] [-C bytes] [-H format] [-M message] [-O
>     [[user@]host:]archive]            [-F            [[user@]host:]archive]
>     [--file=[[user@]host:]archive]   [--format=format]  [--message=message]
>     [--null] [--reset-access-time] [--verbose] [--dot] [--append] [--block-
>     size=blocks]      [--dereference]      [--io-size=bytes]      [--quiet]
>     [--force-local] [--rsh-command=command] [--help]  [--version]  <  name-
>     list [> archive]
>
>     cpio  {-i|--extract} [-bcdfmnrtsuvBSV] [-C bytes] [-E file] [-H format]

Yes, I previously presented that the other common syntax was using curly
braces, like here. I think we shoudl select it.

Jari

-- 
Welcome to FOSS revolution: we fix and modify until it shines
