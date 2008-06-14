From: Sven <svoop@delirium.ch>
Subject: Re: [BUG REPORT] "git =?utf-8?b?bHMtcmVtb3RlCWh0dHA6Ly9naXQuZG9tYWluLmNvbS9yZXBvLmdpdD9IRUFEIg==?= doesn't work
Date: Sat, 14 Jun 2008 09:40:38 +0000 (UTC)
Message-ID: <loom.20080614T093747-613@post.gmane.org>
References: <loom.20080614T065448-251@post.gmane.org> <20080614071011.GA29699@glandium.org> <7vprqkh423.fsf@gitster.siamese.dyndns.org> <loom.20080614T074854-525@post.gmane.org> <20080614090244.GA1262@glandium.org> <loom.20080614T092039-924@post.gmane.org> <20080614093126.GC22538@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 14 11:42:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7SGd-0003jP-HF
	for gcvg-git-2@gmane.org; Sat, 14 Jun 2008 11:41:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755735AbYFNJkv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Jun 2008 05:40:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755580AbYFNJkv
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jun 2008 05:40:51 -0400
Received: from main.gmane.org ([80.91.229.2]:38042 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755460AbYFNJku (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jun 2008 05:40:50 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1K7SFd-0005vk-B2
	for git@vger.kernel.org; Sat, 14 Jun 2008 09:40:49 +0000
Received: from 151.121.221.87.dynamic.jazztel.es ([87.221.121.151])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 14 Jun 2008 09:40:49 +0000
Received: from svoop by 151.121.221.87.dynamic.jazztel.es with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 14 Jun 2008 09:40:49 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 87.221.121.151 (Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.5; en-US; rv:1.9) Gecko/2008061004 Firefox/3.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85001>

Jeff King <peff <at> peff.net> writes:
> Maybe I wasn't clear in my other message. The wait is either "none,
> upgrade to the current master", or "a week or so, wait for 1.5.6 to be
> released."

Oh-kay... guess I'll monkey patch Capistrano and wait till 1.5.6 leaks down to
my Gentoo box, shouldn't take long. 

> But I'll take the $50. ;)

Well, hey, offer made. Tell me where to cable it to. Any in any case - thanks
for the patch!

-sven
