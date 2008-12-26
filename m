From: jidanni@jidanni.org
Subject: Re: [PATCH] gitrepository-layout: No longer first two letters. Also add "down".
Date: Sat, 27 Dec 2008 04:19:45 +0800
Message-ID: <87skoau1su.fsf@jidanni.org>
References: <7veizuog2z.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Dec 26 21:21:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LGJBH-0002a8-GG
	for gcvg-git-2@gmane.org; Fri, 26 Dec 2008 21:21:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752684AbYLZUTu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Dec 2008 15:19:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752652AbYLZUTu
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Dec 2008 15:19:50 -0500
Received: from sd-green-bigip-202.dreamhost.com ([208.97.132.202]:54686 "EHLO
	homiemail-a3.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752647AbYLZUTt (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Dec 2008 15:19:49 -0500
Received: from jidanni.org (122-127-32-218.dynamic.hinet.net [122.127.32.218])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by homiemail-a3.dreamhost.com (Postfix) with ESMTP id 08F83C5950;
	Fri, 26 Dec 2008 12:19:48 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103949>

>>>>> "JCH" == Junio C Hamano <gitster@pobox.com> writes:

JCH> If that is the case, please justify why you think it is better not to say
JCH> "first two letters" the documentation.
OK, I saw
$ ls 3d
05a66c3..
189066f..
If it were the first to letters, it would be
$ ls 3d
3d05a66c3..
3d189066f..
Ah, you mean it snaps them off to form the directory name?! OK, please
note that.

As far as all your other points and messed up To:, OK, next time I will do better.
