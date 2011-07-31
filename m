From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 3/5] bisect: introduce --no-checkout[=<ref>] support into porcelain.
Date: Sun, 31 Jul 2011 02:36:30 +0200
Message-ID: <201107310236.31237.chriscool@tuxfamily.org>
References: <1312014511-7157-1-git-send-email-jon.seymour@gmail.com> <201107301634.33710.chriscool@tuxfamily.org> <CAH3AnrqaruBM8djz6Hfs0Rj5nqHBv6kU+yWNV5QYtaHrOKhRew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, j6t@kdbg.org, gitster@pobox.com,
	jnareb@gmail.com
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 31 02:36:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QnK1Q-0008R7-M5
	for gcvg-git-2@lo.gmane.org; Sun, 31 Jul 2011 02:36:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752612Ab1GaAgm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Jul 2011 20:36:42 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:48354 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752275Ab1GaAgl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jul 2011 20:36:41 -0400
Received: from style.localnet (unknown [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 020A3A60F2;
	Sun, 31 Jul 2011 02:36:33 +0200 (CEST)
User-Agent: KMail/1.13.6 (Linux/2.6.38-8-generic; KDE/4.6.2; x86_64; ; )
In-Reply-To: <CAH3AnrqaruBM8djz6Hfs0Rj5nqHBv6kU+yWNV5QYtaHrOKhRew@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178222>

On Saturday 30 July 2011 19:00:22 Jon Seymour wrote:
> On Sun, Jul 31, 2011 at 12:34 AM, Christian Couder
> 
> <chriscool@tuxfamily.org> wrote:
> > Is there a reason you use "${GIT_DIR}" instead of "$GIT_DIR" that is used
> > everywhere else?
> 
> No, there is no good reason.
> 
> I've pushed a revision that addresses your comments to github  -
> https://github.com/jonseymour/git/commits/no-checkout-v2
> (git@github.com:jonseymour/git.git)

I commented on some of the patches there.

> I'll post the revised series to the list once Junio and others have
> had a chance to comment.

Thanks,
Christian.
