From: Olivier Croquette <ocroquette@free.fr>
Subject: Re: Patches for qgit on MacOS X
Date: Tue, 01 Jul 2008 10:05:48 +0200
Message-ID: <4869E55C.2020608@free.fr>
References: <48665027.3090406@free.fr> <e5bfff550806300300s2a0c0e60sdaa86453116c531f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 01 10:07:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDatN-0002uy-Fs
	for gcvg-git-2@gmane.org; Tue, 01 Jul 2008 10:07:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756364AbYGAIFz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jul 2008 04:05:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756346AbYGAIFz
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Jul 2008 04:05:55 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:52306 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756262AbYGAIFw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jul 2008 04:05:52 -0400
Received: from [192.168.178.26] (p5498C523.dip.t-dialin.net [84.152.197.35])
	by mrelayeu.kundenserver.de (node=mrelayeu4) with ESMTP (Nemesis)
	id 0ML21M-1KDas13xJz-000375; Tue, 01 Jul 2008 10:05:50 +0200
User-Agent: Thunderbird 2.0.0.4 (Macintosh/20070604)
In-Reply-To: <e5bfff550806300300s2a0c0e60sdaa86453116c531f@mail.gmail.com>
X-Provags-ID: V01U2FsdGVkX18MzDU0njneciNgSBsiIZFDHdYuuKKA2m7+Csy
 pWgdTtcQDPfI4zm3RwNm4/Qvih1AYUhJFxqKujONpY24ycXn0B
 SiGwq/aNL0+sT+gy4FGvA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87007>

Marco Costalba wrote, On 30/06/08 12:00:
> Thanks for the patches, I'll apply them.

Great!

> Can I ask why don't you use qgit-2.X series ?

Sure you can, it is just because I overlooked the existence of the
version 2 :)

After compiling qt4-mac from source (it took quite some time), I have 
been able to compile qgit2 too without a hitch, so I guess the patch is 
irrelevant for qgit2. Are you using a different mechanism to access the 
environment?
