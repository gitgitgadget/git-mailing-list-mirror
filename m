From: konglu@minatec.inpg.fr
Subject: Re: [PATCH] Introduce --current option to git-branch builtin
 command.
Date: Thu, 07 Jun 2012 13:18:00 +0200
Message-ID: <20120607131800.Horde.yryrAXwdC4BP0I3o4goH21A@webmail.minatec.grenoble-inp.fr>
References: <CAECJ0BmcxeS1q8bw4hN9jDja2g8GGzNyN_v7jC3ehOW70x6CRA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	DelSp=Yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Kenta Murata (?? ??)" <mrkn@cookpad.com>
X-From: git-owner@vger.kernel.org Thu Jun 07 13:18:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ScajC-0004fd-KH
	for gcvg-git-2@plane.gmane.org; Thu, 07 Jun 2012 13:18:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932317Ab2FGLSF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 7 Jun 2012 07:18:05 -0400
Received: from v-smtp.minatec.grenoble-inp.fr ([147.173.216.28]:59839 "EHLO
	v-smtp.minatec.grenoble-inp.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932309Ab2FGLSE (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Jun 2012 07:18:04 -0400
Received: from localhost (www02.minatec.grenoble-inp.fr [147.173.216.15])
	by v-smtp.minatec.grenoble-inp.fr (Postfix) with ESMTP id 3D05B1A02F1;
	Thu,  7 Jun 2012 13:18:01 +0200 (CEST)
Received: from wifi-028144.grenet.fr (wifi-028144.grenet.fr
 [130.190.28.144]) by webmail.minatec.grenoble-inp.fr (Horde Framework) with
 HTTP; Thu, 07 Jun 2012 13:18:00 +0200
In-Reply-To: <CAECJ0BmcxeS1q8bw4hN9jDja2g8GGzNyN_v7jC3ehOW70x6CRA@mail.gmail.com>
User-Agent: Internet Messaging Program (IMP) H4 (5.0.17)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199391>


"Kenta Murata (?? ??)" <mrkn@cookpad.com> a =E9crit=A0:

> Introducing --current option to git-branch builtin command.
> This option allows us to simply show the current branch name.

In which case would you need to use this option ? Running 'git
branch' is faster and would do the same thing. Even though you
have a lot of branches as Vincent said (and so the output of
'git branch' would be quite verbose), I do not think that adding
an option just for that is relevant.

Lucien Kong
