From: Seth House <seth@eseth.com>
Subject: Re: Conflict markers in mergetool $LOCAL ?
Date: Tue, 17 Aug 2010 17:08:44 +0000 (UTC)
Message-ID: <loom.20100817T185804-167@post.gmane.org>
References: <loom.20100817T054731-955@post.gmane.org> <20100817093008.GA26357@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 17 19:09:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OlPem-0002HN-8Z
	for gcvg-git-2@lo.gmane.org; Tue, 17 Aug 2010 19:09:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757847Ab0HQRI4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Aug 2010 13:08:56 -0400
Received: from lo.gmane.org ([80.91.229.12]:38077 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751190Ab0HQRIy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Aug 2010 13:08:54 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1OlPef-0002Dp-Fw
	for git@vger.kernel.org; Tue, 17 Aug 2010 19:08:53 +0200
Received: from ip65-44-116-164.z116-44-65.sendoutcards.net ([65.44.116.164])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 17 Aug 2010 19:08:53 +0200
Received: from seth by ip65-44-116-164.z116-44-65.sendoutcards.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 17 Aug 2010 19:08:53 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 65.44.116.164 (Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/534.6 (KHTML, like Gecko) Chrome/6.0.493.0 Safari/534.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153765>

David Aguilar <davvid <at> gmail.com> writes:
> What happens if you remove this section?:

Same result. The conflict markers are still there:

http://i.imgur.com/d1vp1.png
