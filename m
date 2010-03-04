From: walt <w41ter@gmail.com>
Subject: Question about scm security holes
Date: Thu, 04 Mar 2010 12:09:41 -0800
Message-ID: <hmp427$d6h$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 05 02:53:23 2010
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NnMb7-0007CR-Uc
	for gcvg-git-2@lo.gmane.org; Fri, 05 Mar 2010 02:45:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752035Ab0CEBoz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Mar 2010 20:44:55 -0500
Received: from lo.gmane.org ([80.91.229.12]:39875 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751127Ab0CEBoy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Mar 2010 20:44:54 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1NnMAs-0006o1-PU
	for git@vger.kernel.org; Fri, 05 Mar 2010 02:17:55 +0100
Received: from adsl-69-234-189-175.dsl.irvnca.pacbell.net ([69.234.189.175])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 05 Mar 2010 02:17:54 +0100
Received: from w41ter by adsl-69-234-189-175.dsl.irvnca.pacbell.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 05 Mar 2010 02:17:54 +0100
X-Injected-Via-Gmane: http://gmane.org/
connect(): Connection refused
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: adsl-69-234-189-175.dsl.irvnca.pacbell.net
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.3a3pre) Gecko/20100304 Thunderbird/3.2a1pre
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141552>

I just saw this article about the "google hackers" exploiting weaknesses in scms,
Perforce in particular:

http://www.wired.com/threatlevel/2010/03/source-code-hacks/?utm_source=feedburner&utm_medium=feed&utm_campaign=Feed%3A+wired%2Findex+%28Wired%3A+Index+3+%28Top+Stories+2%29%29

I guess google didn't take Linus's advice to dump Perforce :)

I can't tell from the article if Perforce is any worse than any other scm for
security holes, in fact it seems to imply that others haven't been tested in
the same way.

Just curious if anyone here has any thoughts about how the article may or may
not have any relevance for git (git being the scm I use most, by far, which is
the reason I'm interested).

Thanks
