From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCH RFC 06/10] send-email: References: should only reference what is actually sent
Date: Sat, 11 Apr 2009 21:52:21 +0000 (UTC)
Message-ID: <loom.20090411T214618-958@post.gmane.org>
References: <1239476908-25944-1-git-send-email-mfwitten@gmail.com> <1239476908-25944-2-git-send-email-mfwitten@gmail.com> <1239476908-25944-3-git-send-email-mfwitten@gmail.com> <1239476908-25944-4-git-send-email-mfwitten@gmail.com> <1239476908-25944-5-git-send-email-mfwitten@gmail.com> <1239476908-25944-6-git-send-email-mfwitten@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 11 23:54:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lsl9M-0003jl-T5
	for gcvg-git-2@gmane.org; Sat, 11 Apr 2009 23:54:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756294AbZDKVwi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Apr 2009 17:52:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754549AbZDKVwh
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Apr 2009 17:52:37 -0400
Received: from main.gmane.org ([80.91.229.2]:43739 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753616AbZDKVwg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Apr 2009 17:52:36 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Lsl7o-0005nH-4k
	for git@vger.kernel.org; Sat, 11 Apr 2009 21:52:33 +0000
Received: from h-68-164-64-249.lsanca54.dynamic.covad.net ([68.164.64.249])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 11 Apr 2009 21:52:32 +0000
Received: from bebarino by h-68-164-64-249.lsanca54.dynamic.covad.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 11 Apr 2009 21:52:32 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 68.164.64.249 (Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.9.0.8) Gecko/2009032609 Firefox/3.0.8)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116355>

Michael Witten <mfwitten <at> gmail.com> writes:

> 
> +# returns 1 of the message was sent, 0 otherwise.

s/of/if/
