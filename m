From: ivo welch <ivo.welch@gmail.com>
Subject: Why C pure?  What IDE/tools?
Date: Mon, 21 Jul 2014 15:06:52 +0000 (UTC)
Message-ID: <loom.20140721T165032-319@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 21 19:15:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X9HBB-0007Nu-Ng
	for gcvg-git-2@plane.gmane.org; Mon, 21 Jul 2014 19:15:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933041AbaGURPH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jul 2014 13:15:07 -0400
Received: from plane.gmane.org ([80.91.229.3]:34113 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932679AbaGURPG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jul 2014 13:15:06 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1X9HB2-0007HL-2W
	for git@vger.kernel.org; Mon, 21 Jul 2014 19:15:04 +0200
Received: from p4FF0A5FB.dip0.t-ipconnect.de ([79.240.165.251])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 21 Jul 2014 19:15:04 +0200
Received: from ivo.welch by p4FF0A5FB.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 21 Jul 2014 19:15:04 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 79.240.165.251 (Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/35.0.1916.153 Safari/537.36)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253979>


curious: I am only an occasional programmer in C.  I read Linus'
post that C++ is a horrible language.

alas, I wonder why people like Linus, who live in C, do not
design C 11.1---a preprocessor or preprocessor replacement that
adds some modest niceties to the language.  For example, forward
references and auto-header generation.  For example, a shorter
way to state #ifndef X #define X #endif .  For example,
propagation of '...' and optional arguments.  Many others.

It would be a collection of small improvements, some copied from
C++ (or other languages), that make the actual C kernel code
programming more pleasant.  I don't mean a full new language,
like C++ or D.  over time, given the prominence of the kernel and
Linus, this could even morph into a quasi-standard with toolchain
and IDE support.  Not a full new language, just modest C language
programming pleasantry enhancements.

what IDE and tools does Linus use?  (I do know linux and git! ;-).)
do these tools make enhancements less useful?!?

/iaw
