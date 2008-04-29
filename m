From: Eric Hanchrow <offby1@blarg.net>
Subject: Re: Dumb idea on git library for script languages
Date: Mon, 28 Apr 2008 21:06:48 -0700
Message-ID: <873ap5484n.fsf@offby1.atm01.sea.blarg.net>
References: <1209366216.17090.4.camel@prosumer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 29 06:09:23 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jqh9d-00022a-WF
	for gcvg-git-2@gmane.org; Tue, 29 Apr 2008 06:09:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752613AbYD2EIS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2008 00:08:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752705AbYD2EIS
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Apr 2008 00:08:18 -0400
Received: from main.gmane.org ([80.91.229.2]:38734 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752215AbYD2EIR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2008 00:08:17 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Jqh8Z-00087D-3d
	for git@vger.kernel.org; Tue, 29 Apr 2008 04:08:15 +0000
Received: from q-static-138-125.avvanta.com ([206.124.138.125])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 29 Apr 2008 04:08:15 +0000
Received: from offby1 by q-static-138-125.avvanta.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 29 Apr 2008 04:08:15 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: q-static-138-125.avvanta.com
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Cancel-Lock: sha1:OIlb1+rWqYEeP7n2TqsBbONRCBs=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80642>

Look into Python's "subprocess" module; it has all you need to cleanly
invoke subprocesses, capture their output, and check their return
status.
-- 
It has been suggested that this article or section be merged
into Fried dough. (Discuss)
        -- Seen on Wikipedia
