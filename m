From: Jari Aalto <jari.aalto@cante.net>
Subject: FEATURE REQUEST: git-format-path: Add option to encode patch content
Date: Fri, 27 Apr 2007 14:31:15 +0300
Organization: Private
Message-ID: <ps5qyry4.fsf@cante.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 27 15:15:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HhQIB-0003YF-Tb
	for gcvg-git@gmane.org; Fri, 27 Apr 2007 15:15:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755723AbXD0NPP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Apr 2007 09:15:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755802AbXD0NPP
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Apr 2007 09:15:15 -0400
Received: from main.gmane.org ([80.91.229.2]:46969 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755723AbXD0NPO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Apr 2007 09:15:14 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1HhQHu-0002OR-8C
	for git@vger.kernel.org; Fri, 27 Apr 2007 15:15:02 +0200
Received: from a81-197-175-198.elisa-laajakaista.fi ([81.197.175.198])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 27 Apr 2007 15:15:02 +0200
Received: from jari.aalto by a81-197-175-198.elisa-laajakaista.fi with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 27 Apr 2007 15:15:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: a81-197-175-198.elisa-laajakaista.fi
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.3 (windows-nt)
Cancel-Lock: sha1:JWFstsMzCzSaM7BadXWpY4BKEBg=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45713>


FEAURE REQUEST
--------------

Add sme option to git-format-path to encode thae patch content 
(MIME/base64)

RATIONALE
-------------

I need to submit patches that fix trailing whitespcaes, and to guard
those in email message it would be nice if the patch could be made
into base64 envelope (or MIME)

-- Jari
