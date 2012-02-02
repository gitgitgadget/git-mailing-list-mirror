From: Carsten Fuchs <CarstenFuchs@T-Online.de>
Subject: Re: git-svn branches with revision id's in name
Date: Thu, 02 Feb 2012 13:24:27 +0100
Message-ID: <4F2A807B.9050206@T-Online.de>
References: <CAGYrzvwzrsZdHHnSBaMv-sD9mDGVQ-qFuks+JM6d-NQ9Wz9KwQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Stephen Duncan Jr <stephen.duncan@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 02 13:24:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RsviM-0001z0-VI
	for gcvg-git-2@plane.gmane.org; Thu, 02 Feb 2012 13:24:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755961Ab2BBMYa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Feb 2012 07:24:30 -0500
Received: from moutng.kundenserver.de ([212.227.17.10]:54866 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755904Ab2BBMY3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Feb 2012 07:24:29 -0500
Received: from [192.168.1.76] (p5B0C3A0B.dip.t-dialin.net [91.12.58.11])
	by mrelayeu.kundenserver.de (node=mreu0) with ESMTP (Nemesis)
	id 0Lb6pZ-1SHJII3yaP-00kFXt; Thu, 02 Feb 2012 13:24:28 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:10.0) Gecko/20120129 Thunderbird/10.0
In-Reply-To: <CAGYrzvwzrsZdHHnSBaMv-sD9mDGVQ-qFuks+JM6d-NQ9Wz9KwQ@mail.gmail.com>
X-Provags-ID: V02:K0:YzMhHvrPMu0huXWPyY50JVtJonLe0XM/q0duOvdU7jA
 jWzpsC1cLhy5+GUDo9TiNk2pMXvV52fQumZP27DvrPmJFX0FUO
 7MAcHfFD9pSl7rtMj2c+0XQcaUG76698oVblh362OvSoXqkX4y
 scWEabVkITaydhexMoaebaq32ZLfplEmhGOUXSr/XUiTJMfwl/
 PAZG72SaMnbPSrJ9IK6aj+/ly0q6n1zkPEM8uCrwh2AwxjiO0A
 6SgWc/vaJ2CeazKHdsxbDNLhFFlIyFbF4Ny76gMKRj4MOhDq5y
 1wKlChWIAA5CVtjThAkLpjgL6qvfVuLxQyn8ZQw3OGiggCe59m
 Qx3yjFWuXC++1KwQzMEA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189637>

Hi all,

Am 2012-01-30 20:42, schrieb Stephen Duncan Jr:
> [...]
> $ git branch -a
> * master
>    remotes/develop
>    remotes/develop@29271
>    remotes/develop@32463
>    remotes/develop@34103
>    remotes/feature/xyz
>    remotes/feature/xyz@26438
>    remotes/feature/xyz@27542
>    remotes/feature/xyz@35233
>
> Why have these remote branches been created?  What impact does this
> have on my checkout?  Can I remove safely remove them?  How?  I was
> unable to figure out how to reference this behavior in order to search
> for information on it.

Same questions here.
(I know how to remove them, but I'd love to learn and understand why they have been 
created.)

Any info would much be appreciated!

Many thanks and best regards,
Carsten



-- 
    Cafu - the open-source Game and Graphics Engine
for multiplayer, cross-platform, real-time 3D Action
           Learn more at http://www.cafu.de
