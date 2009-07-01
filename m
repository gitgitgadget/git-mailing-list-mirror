From: Graeme Geldenhuys <graemeg@gmail.com>
Subject: Re: Team Coherence to Git conversion
Date: Wed, 01 Jul 2009 10:00:29 +0200
Message-ID: <h2f56j$alt$1@ger.gmane.org>
References: <h2cmv6$agp$1@ger.gmane.org> <20090630144128.GR11191@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 01 10:03:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MLumS-0002qF-SR
	for gcvg-git-2@gmane.org; Wed, 01 Jul 2009 10:03:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753554AbZGAICn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jul 2009 04:02:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753184AbZGAICm
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Jul 2009 04:02:42 -0400
Received: from main.gmane.org ([80.91.229.2]:35920 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753478AbZGAICj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jul 2009 04:02:39 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1MLumA-0008Gs-0y
	for git@vger.kernel.org; Wed, 01 Jul 2009 08:02:42 +0000
Received: from dsl-245-91-189.telkomadsl.co.za ([41.245.91.189])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 01 Jul 2009 08:02:42 +0000
Received: from graemeg by dsl-245-91-189.telkomadsl.co.za with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 01 Jul 2009 08:02:42 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: dsl-245-91-189.telkomadsl.co.za
User-Agent: Thunderbird 2.0.0.22 (X11/20090608)
In-Reply-To: <20090630144128.GR11191@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122571>

Shawn O. Pearce wrote:
> 
> Huh.  TC reminds me of PVCS Version Manager.  Lots of hype on

Team Coherence was quite popular with the Delphi developers, seeing that
it was written in Delphi (Object Pascal). Anyway, looking at it even
compared to Subversion, it is a weird way of doing revision control.
Revisions are based on a per file basis and not as an atomic commit
(snapshot of whole repository status) like SubVersion or Git does. If
you wanted a snapshot of a point in time of the whole repository, you
had to create a Label. :-(  Ideas change over time I guess. :-)


> nobody here has even heard of TC before.  You are on your own to
> write an import tool.
> You might want to look at using git-fast-import to handle the git

No problems.  And thanks for the hint on git-fast-import. I'll read
up on that a bit later.


Regards,
  - Graeme -

-- 
fpGUI Toolkit - a cross-platform GUI toolkit using Free Pascal
http://opensoft.homeip.net/fpgui/
