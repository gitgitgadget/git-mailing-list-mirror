From: =?UTF-8?B?TMOhc3psw7MgTW9uZGE=?= <laci@monda.hu>
Subject: Adding hooks.envelopesendername to the post-receive-email hook script
Date: Fri, 26 Aug 2011 03:15:27 +0200
Message-ID: <CAJ9y4Kkp5_4vVvSwPV0hy-Wz2azQswxra3UOvzmgUZWo6PpXKQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 26 03:15:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qwl1F-0003lh-R2
	for gcvg-git-2@lo.gmane.org; Fri, 26 Aug 2011 03:15:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754482Ab1HZBP3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 25 Aug 2011 21:15:29 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:33646 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753954Ab1HZBP2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Aug 2011 21:15:28 -0400
Received: by gya6 with SMTP id 6so2288065gya.19
        for <git@vger.kernel.org>; Thu, 25 Aug 2011 18:15:28 -0700 (PDT)
Received: by 10.42.172.71 with SMTP id m7mr333318icz.478.1314321327959; Thu,
 25 Aug 2011 18:15:27 -0700 (PDT)
Received: by 10.231.19.5 with HTTP; Thu, 25 Aug 2011 18:15:27 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180144>

Hi List,

I wonder whether anybody thinks that being able to specify
hooks.envelopesendername to set the name of the sender (like what the
sendmail -F option does) would be a useful feature.  If so, I'm also
interested that whoever is in charge is willing to merge such a patch.

Thanks in advance.

--=20
L=C3=A1szl=C3=B3 Monda <http://monda.hu>
