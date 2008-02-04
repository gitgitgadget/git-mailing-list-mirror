From: Jari Aalto <jari.aalto@cante.net>
Subject: Re: [PATCH] Documentation/SubmittingPatches: Instruct how to use [PATCH] Subject header
Date: Mon, 04 Feb 2008 10:12:14 +0200
Organization: Private
Message-ID: <ejbt16ox.fsf@blue.sea.net>
References: <r6ft1sd1.fsf@blue.sea.net>
	<alpine.LSU.1.00.0802040029020.7372@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 04 09:13:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLwSI-00005G-Dc
	for gcvg-git-2@gmane.org; Mon, 04 Feb 2008 09:13:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753492AbYBDIM5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2008 03:12:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753486AbYBDIM5
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Feb 2008 03:12:57 -0500
Received: from main.gmane.org ([80.91.229.2]:45594 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753322AbYBDIM4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2008 03:12:56 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JLwRi-0003kH-9V
	for git@vger.kernel.org; Mon, 04 Feb 2008 08:12:54 +0000
Received: from a91-155-178-181.elisa-laajakaista.fi ([91.155.178.181])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 04 Feb 2008 08:12:54 +0000
Received: from jari.aalto by a91-155-178-181.elisa-laajakaista.fi with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 04 Feb 2008 08:12:54 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: a91-155-178-181.elisa-laajakaista.fi
User-Agent: Gnus/5.110007 (No Gnus v0.7) Emacs/22.1 (windows-nt)
Cancel-Lock: sha1:mL0UgA1F8S1aSs59FTVngFkc3oQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72477>

* Mon 2008-02-04 Johannes Schindelin <Johannes.Schindelin@gmx.de>
>
> Whitespace error?  (Spaces instead of Tabs)

There should be a big notice at the beginning of
Documentation/SubmittingPatches:

Junio, would you add this.

Jari

----------------------------------------------------------------
Checklist (and a short version for the impatient):

        General:

                NOTE: Please set your editor to use tabs instead of
                spaces. In Emacs this can be set with
                (setq indent-tabs-mode t) and in vi this can be set 
                with ...

        Commits:

-- 
Welcome to FOSS revolution: we fix and modify until it shines
