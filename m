From: Wincent Colaiuta <win@wincent.com>
Subject: Re: What's cooking in git.git (Mar 2009, #06; Sat, 21)
Date: Sat, 21 Mar 2009 17:20:21 +0100
Message-ID: <0768D909-FCD5-4E5B-95A7-2602824FC431@wincent.com>
References: <7vk56jfgt2.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 21 17:22:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ll3xf-0006DL-VH
	for gcvg-git-2@gmane.org; Sat, 21 Mar 2009 17:22:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754274AbZCUQU2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 21 Mar 2009 12:20:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751648AbZCUQU2
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Mar 2009 12:20:28 -0400
Received: from wincent1.inetu.net ([209.235.192.161]:51043 "EHLO
	wincent1.inetu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752915AbZCUQU1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 Mar 2009 12:20:27 -0400
Received: from cuzco.lan (207.pool85-53-9.dynamic.orange.es [85.53.9.207])
	(authenticated bits=0)
	by wincent1.inetu.net (8.13.8/8.13.8) with ESMTP id n2LGKLqw013479
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Sat, 21 Mar 2009 12:20:23 -0400
In-Reply-To: <7vk56jfgt2.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.930.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114042>

El 21/3/2009, a las 8:58, Junio C Hamano escribi=F3:

> * da/difftool (Thu Mar 19 01:25:25 2009 -0700) 1 commit
> - difftool: move 'git-difftool' out of contrib

Before this one goes any further, I noticed that nobody replied to my =20
email on this thread a few days ago:

http://article.gmane.org/gmane.comp.version-control.git/113609

My concern was:

> Given that git-difftool shares basically all the same options as =20
> "git diff", I think a good long-term plan would be looking at adding =
=20
> the "--tool" option to "git diff" itself so that users wouldn't have =
=20
> to learn a new subcommand, just a new option.


What do people think?

Cheers,
Wincent
