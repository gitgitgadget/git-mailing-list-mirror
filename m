From: Eric Hanchrow <offby1@blarg.net>
Subject: Re: How to capture date/time of push vs. local commit?
Date: Thu, 08 May 2008 06:57:55 -0700
Message-ID: <87hcd85258.fsf@offby1.atm01.sea.blarg.net>
References: <6844644e0805080648g72c4b767l4bcf48ade319bf77@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 08 16:10:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ju6o5-0004Rn-Cr
	for gcvg-git-2@gmane.org; Thu, 08 May 2008 16:09:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753875AbYEHOIX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 May 2008 10:08:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753848AbYEHOIX
	(ORCPT <rfc822;git-outgoing>); Thu, 8 May 2008 10:08:23 -0400
Received: from main.gmane.org ([80.91.229.2]:54725 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753136AbYEHOIW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 May 2008 10:08:22 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Ju6n9-0005IN-04
	for git@vger.kernel.org; Thu, 08 May 2008 14:08:15 +0000
Received: from q-static-138-125.avvanta.com ([206.124.138.125])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 08 May 2008 14:08:14 +0000
Received: from offby1 by q-static-138-125.avvanta.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 08 May 2008 14:08:14 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: q-static-138-125.avvanta.com
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.60 (gnu/linux)
Cancel-Lock: sha1:zJDnQI8o10TbZBLDEBc81rTZD8c=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81530>

I would think you could get what you want with sufficient grovelling of
the files in .../.git/logs/.
-- 
It is a truth universally acknowledged, that any language in
possession of a rich syntax, must be in want of a rewrite.
        -- Piers Cawley
