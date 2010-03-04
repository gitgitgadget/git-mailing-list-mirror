From: Jari Aalto <jari.aalto@cante.net>
Subject: FEATURE REQUEST: git tag -- add option to display SHA1 values
Date: Thu, 04 Mar 2010 19:28:32 +0200
Organization: Private
Message-ID: <878wa8atdr.fsf@jondo.cante.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 04 18:29:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NnErh-0005zn-NW
	for gcvg-git-2@lo.gmane.org; Thu, 04 Mar 2010 18:29:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932166Ab0CDR3c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Mar 2010 12:29:32 -0500
Received: from lo.gmane.org ([80.91.229.12]:46263 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932149Ab0CDR3c (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Mar 2010 12:29:32 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1NnErK-0005b9-86
	for git@vger.kernel.org; Thu, 04 Mar 2010 18:29:14 +0100
Received: from a91-155-187-216.elisa-laajakaista.fi ([91.155.187.216])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 04 Mar 2010 18:29:13 +0100
Received: from jari.aalto by a91-155-187-216.elisa-laajakaista.fi with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 04 Mar 2010 18:29:13 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: a91-155-187-216.elisa-laajakaista.fi
User-Agent: Gnus/5.110011 (No Gnus v0.11) Emacs/23.1 (gnu/linux)
Cancel-Lock: sha1:aP04gcnMGwSvYNe+FpHjLlHiEdI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141535>


It would be nice if there were option to list the SHA1 values easily for
every tag:

    $ git tag --sha         # or -s short option

    release/1.0         3a162d7086a7da0f9621530cca5996668d1442e3
    snapshot/20100125   e7b2b55a1bc2e59b5bf4fc92bc5eaf8ec25031a3
    ...

Jari
