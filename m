From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [Tagging Commits] feedback / discussion request
Date: Wed, 4 May 2011 01:49:46 +0200
Message-ID: <BANLkTimTmkufMnY5dJtDD6BWxs=vsDTygA@mail.gmail.com>
References: <BANLkTik5-Ygh0YwN=j+ibLhP6==ots_MXQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Richard Peterson <richard@rcpeterson.com>
X-From: git-owner@vger.kernel.org Wed May 04 01:50:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHPMO-0004Vg-16
	for gcvg-git-2@lo.gmane.org; Wed, 04 May 2011 01:50:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752213Ab1ECXu1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 May 2011 19:50:27 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:44993 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751165Ab1ECXu1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2011 19:50:27 -0400
Received: by qwk3 with SMTP id 3so406450qwk.19
        for <git@vger.kernel.org>; Tue, 03 May 2011 16:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=n6tKQpRPWmQd6pwmzSQ2V+s2spEX8toFXh70FsUDzSk=;
        b=EpvcMQZs/6yB40Q6mvYF+YY5zIcYsEMtvmD5ImO7ApxPD04KUEeAlihYbhxXrQ0ytx
         Achnd9nm6j0t6+SnDUrfAWa6JQ0dqIMbQQ7lpz6I1j5RfS8hnmAmTdw2ixIN8JICxo6+
         hwvcdJMbasf+JHtf9eCb05cpMJzZahMmN3Fy0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=sT1km/u/hWywMHGMlvQYA5Rhg3+fILbsRAblg73aobSd22hkjeAisF4gh3S5n0Aq6L
         HTYtRonYmj62XxLCjQd8iUZchb5GrUPXG/cQOJchiqrpS9X1rFAvpKDkEcrR/jMEKyOW
         xdS/jgKkryTEJ7P7+1DCabuMSLok0gp25s74k=
Received: by 10.229.78.216 with SMTP id m24mr224603qck.60.1304466626096; Tue,
 03 May 2011 16:50:26 -0700 (PDT)
Received: by 10.229.75.70 with HTTP; Tue, 3 May 2011 16:49:46 -0700 (PDT)
In-Reply-To: <BANLkTik5-Ygh0YwN=j+ibLhP6==ots_MXQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172705>

Heya,

On Wed, May 4, 2011 at 01:36, Richard Peterson <richard@rcpeterson.com> wrote:
> Thank you, and please give feedback. I'm no git pro - just a guy with an
> idea. Based on your feedback, Eric and I will steer our implementation.

Have you looked at git notes? They seem relevant. You could use them
to sign commits after the fact, and by multiple people, etc.

-- 
Cheers,

Sverre Rabbelier
