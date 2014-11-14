From: Max Kirillov <max@max630.net>
Subject: Re: [PATCH 1/1] gitk: po/ru.po russian translation typo fixed
Date: Fri, 14 Nov 2014 23:16:09 +0200
Message-ID: <20141114211609.GA4808@wheezy.local>
References: <1415963128-14221-1-git-send-email-kuleshovmail@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Alex Riesen <raa.lkml@gmail.com>
To: Paul Mackerras <paulus@samba.org>, 0xAX <kuleshovmail@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 14 22:17:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XpOF2-0006mF-Te
	for gcvg-git-2@plane.gmane.org; Fri, 14 Nov 2014 22:17:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422815AbaKNVRK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Nov 2014 16:17:10 -0500
Received: from p3plsmtpa09-04.prod.phx3.secureserver.net ([173.201.193.233]:58710
	"EHLO p3plsmtpa09-04.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1422643AbaKNVRH (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Nov 2014 16:17:07 -0500
Received: from wheezy.local ([82.181.81.240])
	by p3plsmtpa09-04.prod.phx3.secureserver.net with 
	id FZGv1p00i5B68XE01ZH1xD; Fri, 14 Nov 2014 14:17:04 -0700
Content-Disposition: inline
In-Reply-To: <1415963128-14221-1-git-send-email-kuleshovmail@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi.

On Fri, Nov 14, 2014 at 05:05:28PM +0600, 0xAX wrote:
> Signed-off-by: 0xAX <kuleshovmail@gmail.com>

> -"(=D7=D3=C5 =C9=DA=CD=C5=CE=C5=CE=C9=D1 =D7 =D2=C1=C2=CF=DE=C5=CD =CB=
=C1=D4=C1=CC=CF=C7=C9 =C2=D5=C4=D5=D4 =D0=CF=D4=C5=D2=D1=CE=D9)"
> +"(=D7=D3=C5 =C9=DA=CD=C5=CE=C5=CE=C9=D1 =D7 =D2=C1=C2=CF=DE=C5=CD =CB=
=C1=D4=C1=CC=CF=C7=C5 =C2=D5=C4=D5=D4 =D0=CF=D4=C5=D2=D1=CE=D9)"

I cannot say I see much sense to use software like Git with
translations to national languages, but I confirm that the
newer version is grammatically correct while the older is
not. You may add "Reviewed-By: " with me or whatever tag is
appropriate for my statement above.

btw, you might want to find the author of the string, with
"git blame", and, if he is still active in the maillist, add
him to To: or CC: for the patch.

--=20
Max
