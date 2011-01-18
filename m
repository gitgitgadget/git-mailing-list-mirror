From: Yaroslav Halchenko <debian@onerussian.com>
Subject: Re: problem with cherry-picking a commit which comes before
 introducing a new submodule
Date: Tue, 18 Jan 2011 11:02:22 -0500
Message-ID: <20110118160222.GA23926@onerussian.com>
References: <20110107172432.GA6040@onerussian.com>
 <20110107181501.GA28980@burratino>
 <20110107183226.GG6040@onerussian.com>
 <20110107230017.GA15495@burratino>
 <20110108000131.GR6040@onerussian.com>
 <20110111132710.GA14905@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 18 17:02:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PfE0s-0004is-4Z
	for gcvg-git-2@lo.gmane.org; Tue, 18 Jan 2011 17:02:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752322Ab1ARQCZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jan 2011 11:02:25 -0500
Received: from washoe.dartmouth.edu ([129.170.30.229]:49823 "EHLO
	smtp.onerussian.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751753Ab1ARQCY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jan 2011 11:02:24 -0500
Received: from smtp.onerussian.com ([192.168.100.6] helo=washoe.onerussian.com)
	by smtp.onerussian.com with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <yoh@onerussian.com>)
	id 1PfE0k-0006PI-LU; Tue, 18 Jan 2011 11:02:22 -0500
Received: from yoh by washoe.onerussian.com with local (Exim 4.69)
	(envelope-from <yoh@onerussian.com>)
	id 1PfE0k-0006PF-GT; Tue, 18 Jan 2011 11:02:22 -0500
Content-Disposition: inline
In-Reply-To: <20110111132710.GA14905@burratino>
X-URL: http://www.onerussian.com
X-Image-Url: http://www.onerussian.com/img/yoh.png
X-PGP-Key: http://www.onerussian.com/gpg-yoh.asc
X-fingerprint: C5B9 05F0 E8D9 FD96 68FF  366F A2DE 2350 62DA 33FA
User-Agent: Mutt/1.5.20 (2009-06-14)
X-SA-Exim-Connect-IP: 192.168.100.6
X-SA-Exim-Rcpt-To: git@vger.kernel.org, jrnieder@gmail.com, newren@gmail.com
X-SA-Exim-Mail-From: yoh@onerussian.com
X-SA-Exim-Scanned: No (on smtp.onerussian.com); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165202>


On Tue, 11 Jan 2011, Jonathan Nieder wrote:
> ...
> a submodule might be another reason for a directory in the worktree.
> In any event, we get a spurious conflict.
> Thanks, that was interesting (no patch yet, alas).

is there a way to memorize this issue somewhere (bug tracking/TODO/etc)
where this issue could be recorded so it doesn't get forgotten? ;)

-- 
Yaroslav O. Halchenko
Postdoctoral Fellow,   Department of Psychological and Brain Sciences
Dartmouth College, 419 Moore Hall, Hinman Box 6207, Hanover, NH 03755
Phone: +1 (603) 646-9834                       Fax: +1 (603) 646-1419
WWW:   http://www.linkedin.com/in/yarik        
