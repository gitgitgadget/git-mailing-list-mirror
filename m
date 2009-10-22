From: Jari Aalto <jari.aalto@cante.net>
Subject: Re: [PATCH] Documentation/fetch-options.txt: order options alphabetically
Date: Thu, 22 Oct 2009 12:23:24 +0300
Message-ID: <87my3jzss3.fsf@jondo.cante.net>
References: <87eiow1pey.fsf@jondo.cante.net>
	<7vpr8g32ht.fsf@alter.siamese.dyndns.org>
	<7vhbts3285.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 22 11:23:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0ttm-0006gv-3a
	for gcvg-git-2@lo.gmane.org; Thu, 22 Oct 2009 11:23:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754691AbZJVJXp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Oct 2009 05:23:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754528AbZJVJXp
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Oct 2009 05:23:45 -0400
Received: from lo.gmane.org ([80.91.229.12]:52803 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754486AbZJVJXo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Oct 2009 05:23:44 -0400
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1N0tta-0006cR-Vp
	for git@vger.kernel.org; Thu, 22 Oct 2009 11:23:46 +0200
Received: from a91-155-187-216.elisa-laajakaista.fi ([91.155.187.216])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 22 Oct 2009 11:23:46 +0200
Received: from jari.aalto by a91-155-187-216.elisa-laajakaista.fi with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 22 Oct 2009 11:23:46 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: a91-155-187-216.elisa-laajakaista.fi
User-Agent: Gnus/5.110011 (No Gnus v0.11) Emacs/23.1 (gnu/linux)
Cancel-Lock: sha1:YK269Y7vkEJIK1PAnF8MI7DwuPA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131012>

Junio C Hamano <gitster@pobox.com> writes:
> I think you looked only at git-fetch.txt without
> checking where else this file is included.  Then the patch certainly is
> understandable.  It would probably make git-fetch.{1,html} easier to scan,
> while making things not worse for git-pull.{1,html}

Yes. Unfortunately there doesn't seem to be a way to arrange all nicely,
so perhaps you could accept the following patch to accompany with it. At
least there would be ordered "git-fetch" and semi ordered "git-pull".

    Subject: [PATCH] Documentation/merge-options.txt: order options in alphabetical groups

Jari
