From: LordSmoke <dslice@morphometrics.org>
Subject: Re: Sharing nested subparts of large repository?
Date: Thu, 29 Mar 2012 13:05:49 -0700 (PDT)
Message-ID: <1333051549578-7419114.post@n2.nabble.com>
References: <1332693502389-7403743.post@n2.nabble.com> <1332957138457-7414676.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 29 22:06:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDLbd-0005i3-AJ
	for gcvg-git-2@plane.gmane.org; Thu, 29 Mar 2012 22:06:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760146Ab2C2UFy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Mar 2012 16:05:54 -0400
Received: from sam.nabble.com ([216.139.236.26]:35546 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760126Ab2C2UFu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Mar 2012 16:05:50 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.72)
	(envelope-from <dslice@morphometrics.org>)
	id 1SDLbR-0002sX-Iv
	for git@vger.kernel.org; Thu, 29 Mar 2012 13:05:49 -0700
In-Reply-To: <1332957138457-7414676.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194289>

Drat! I got my branches set up the way I wanted, but basic merge
restores/deletes files depending upon what I am merging with what. E.g.,
"master" <-merge- "development" deletes master's files I want to keep,
"development" <-merge- "master" adds back in the files I took out of
"development". Perhaps some merge options.

Still looking... 8-/


--
View this message in context: http://git.661346.n2.nabble.com/Sharing-nested-subparts-of-large-repository-tp7403743p7419114.html
Sent from the git mailing list archive at Nabble.com.
