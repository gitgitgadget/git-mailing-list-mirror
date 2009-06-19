From: Wincent Colaiuta <win@wincent.com>
Subject: Re: visualise the output of git-diff?
Date: Fri, 19 Jun 2009 10:42:13 +0200
Message-ID: <9553BA37-1651-4A83-90E8-56EB4583F0D8@wincent.com>
References: <200906190732.24455.Karlis.Repsons@gmail.com>
Mime-Version: 1.0 (Apple Message framework v935.3)
Content-Type: text/plain; charset=UTF-8;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?Q?=22K=C4=81rlis_Repsons=22?= <karlis.repsons@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 19 10:42:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MHZg4-0006XK-TZ
	for gcvg-git-2@gmane.org; Fri, 19 Jun 2009 10:42:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752929AbZFSImS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Jun 2009 04:42:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752886AbZFSImR
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Jun 2009 04:42:17 -0400
Received: from wincent1.inetu.net ([209.235.192.161]:60243 "EHLO
	wincent1.inetu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752278AbZFSImQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Jun 2009 04:42:16 -0400
Received: from [192.168.1.33] (195.Red-88-5-254.dynamicIP.rima-tde.net [88.5.254.195])
	(authenticated bits=0)
	by wincent1.inetu.net (8.13.8/8.13.8) with ESMTP id n5J8gEF6018503
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Fri, 19 Jun 2009 04:42:17 -0400
In-Reply-To: <200906190732.24455.Karlis.Repsons@gmail.com>
X-Mailer: Apple Mail (2.935.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121887>

El 19/6/2009, a las 9:32, K=C4=81rlis Repsons escribi=C3=B3:

> Hi,
> this is about displaying git-diff results:
> in case of long text lines, where only a single word may be changed, =
=20
> it would
> be useful, if that single difference would be displayed in a differen=
t
> colour, but is it possible?


I started working on a patch for that feature a while back and then =20
got snowed under by other work, but it's still on my TODO list. There =20
was some discussion on the list about the idea.

The relevant thread starts with
=09
	Message-ID: <53497057-1ADE-4300-9F35-B218959606FE@wincent.com>
	Subject: RFC: git diff colorization idea

Browsable copy here:

	http://article.gmane.org/gmane.comp.version-control.git/106805

Cheers,
Wincent
