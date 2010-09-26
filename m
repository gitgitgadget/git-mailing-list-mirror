From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCHv3 11/16] t6050 (replace): add missing &&
Date: Sun, 26 Sep 2010 07:22:53 +0200
Message-ID: <201009260722.53397.chriscool@tuxfamily.org>
References: <1285441627-28233-1-git-send-email-newren@gmail.com> <1285441627-28233-12-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 26 07:25:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ozjk8-0002DO-AM
	for gcvg-git-2@lo.gmane.org; Sun, 26 Sep 2010 07:25:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750840Ab0IZFXE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Sep 2010 01:23:04 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:47574 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750738Ab0IZFXD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Sep 2010 01:23:03 -0400
Received: from style.localnet (unknown [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id B9B64A61C4;
	Sun, 26 Sep 2010 07:22:55 +0200 (CEST)
User-Agent: KMail/1.13.2 (Linux/2.6.32-24-generic; KDE/4.4.2; x86_64; ; )
In-Reply-To: <1285441627-28233-12-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157210>

On Saturday 25 September 2010 21:07:02 Elijah Newren wrote:
> Also, mark the first grep in the 'fetch branch with replacement' test as
> being expected to fail.

Yes the test was bogus and your fix is right, but I think that the test should 
be improved anyway, so I will send a patch doing that.

Thanks,
Christian.
