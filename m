From: Geoff Mets <geoff.metselaar@gmail.com>
Subject: Re: git-receive-pack missing credentials ?
Date: Wed, 16 Nov 2011 09:19:01 -0800 (PST)
Message-ID: <1321463941686-7001142.post@n2.nabble.com>
References: <4EB7FA3A.8070908@univ-rennes1.fr> <loom.20111108T114722-414@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 16 18:19:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQj8f-0005zU-FJ
	for gcvg-git-2@lo.gmane.org; Wed, 16 Nov 2011 18:19:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757321Ab1KPRTE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Nov 2011 12:19:04 -0500
Received: from sam.nabble.com ([216.139.236.26]:48424 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755127Ab1KPRTD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Nov 2011 12:19:03 -0500
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.72)
	(envelope-from <geoff.metselaar@gmail.com>)
	id 1RQj8X-0004yu-N0
	for git@vger.kernel.org; Wed, 16 Nov 2011 09:19:01 -0800
In-Reply-To: <loom.20111108T114722-414@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185553>

Hi Francois

Reading this thread mirrored the exact problems I'm seeing but sadly your
solution adding +ExecCGI didn't fix it.

I'm guessing, like you, it's probably an apache config issue. Could you
share your working apache.conf

Many thanks ..............Geoff

--
View this message in context: http://git.661346.n2.nabble.com/git-receive-pack-missing-credentials-tp6970872p7001142.html
Sent from the git mailing list archive at Nabble.com.
