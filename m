From: jidanni@jidanni.org
Subject: "git-whatever" the new style vs. "git whatever"?
Date: Tue, 30 Dec 2008 03:37:19 +0800
Message-ID: <87sko6lqmo.fsf_-_@jidanni.org>
References: <7vfxk7cnmw.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: nanako3@lavabit.com, git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Dec 29 20:38:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHNwo-0000nM-3u
	for gcvg-git-2@gmane.org; Mon, 29 Dec 2008 20:38:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752049AbYL2ThX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Dec 2008 14:37:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751870AbYL2ThX
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Dec 2008 14:37:23 -0500
Received: from sd-green-bigip-145.dreamhost.com ([208.97.132.145]:42035 "EHLO
	homiemail-a1.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751810AbYL2ThW (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Dec 2008 14:37:22 -0500
Received: from jidanni.org (122-127-33-187.dynamic.hinet.net [122.127.33.187])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by homiemail-a1.g.dreamhost.com (Postfix) with ESMTP id 97C72119E11;
	Mon, 29 Dec 2008 11:37:21 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104123>

JCH> I think he is comparing "git am" and "git-am" the latter of which is now
JCH> deprecated and largely removed from the end user.

By the way, we here at the end user end have a hard time detecting if
"git-whatever" the new style vs. "git whatever"...

Idea: right at top of "man git" say: You might have noticed sometimes
people write "git-whatever" and sometimes write "git whatever", well ...

JCH> IOW, the seeming inconsistency is not an issue anymore in practice in the
JCH> post 1.6.0 era.

(I was just hoping everything is consistent, one way or the other.)
