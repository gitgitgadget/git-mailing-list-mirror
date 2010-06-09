From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: permissions
Date: Wed, 9 Jun 2010 15:00:17 +0200
Message-ID: <AANLkTimrK5Hf9TBaed69gG330N9z9QpTrUIMY77KiX2_@mail.gmail.com>
References: <4C0A19FE.1020802@wpursell.net>
	<AANLkTikGpbeP1ba0y0oUsWGQXsrL8Z-GKjybCB83W_FJ@mail.gmail.com>
	<4C0F6CF0.3020603@wpursell.net>
	<201006091406.50955.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: William Pursell <bill.pursell@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Andreas Schwab <schwab@linux-m68k.org>, git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Jun 09 15:00:26 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMKtO-0004Q0-Ac
	for gcvg-git-2@lo.gmane.org; Wed, 09 Jun 2010 15:00:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754999Ab0FINAU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jun 2010 09:00:20 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:62694 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752606Ab0FINAT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jun 2010 09:00:19 -0400
Received: by yxl31 with SMTP id 31so1082651yxl.19
        for <git@vger.kernel.org>; Wed, 09 Jun 2010 06:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=K7FegChpQkBYHmYSQihxZ6s5MpEQ7ff1LS3e0sSUWN0=;
        b=oZ84k+W1uq2rbG5qmGRd2LDJ4IB6sZQGpIS+cplscKxGDv0FGqUKNkWi4I+kCCeqMp
         iwFs7eM5tbVD0UCwKw1qU1M1cz34KN0swIJLuYq99HPes6cSp+Z1a2LeFCucVd37X1Wb
         RuVrLtKduC274jfuasjgeuOq3HmTc8Kgse9QA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=xU+jVtUB/SEiVHdSvhfDoeW5+gqsUIp+STVdoChx8r5yWjBDOcEtJ/g0nTB/+BeWK2
         77hAyJ/wxvR5ZBnptXyueS74Yt3YoohYlNBHXfY2nDisX70l51oUcyZdy0OExvLrkDib
         sLfzBrph4YmV+DwuvXHKsALsR5LpEbSfG+7eo=
Received: by 10.100.245.35 with SMTP id s35mr18089291anh.71.1276088418158; 
	Wed, 09 Jun 2010 06:00:18 -0700 (PDT)
Received: by 10.100.229.5 with HTTP; Wed, 9 Jun 2010 06:00:17 -0700 (PDT)
In-Reply-To: <201006091406.50955.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148769>

On Wed, Jun 9, 2010 at 14:06, Thomas Rast <trast@student.ethz.ch> wrote:
> Or maybe we don't care about BOFH ideas?

Git _is_ used in corporate environments. The BOs thrive there,
not to mention ideas they get.
