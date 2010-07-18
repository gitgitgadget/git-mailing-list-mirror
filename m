From: Lars Hjemli <hjemli@gmail.com>
Subject: Re: [CGit RFC/PATCH 0/5] Commit graph on CGit's 'log' view
Date: Sun, 18 Jul 2010 15:26:09 +0200
Message-ID: <AANLkTimROxHdTKvjOIeWUMmQ_FmRD3igv5O06ySopKHW@mail.gmail.com>
References: <1279056219-27096-1-git-send-email-johan@herland.net>
	<1279057221-28036-1-git-send-email-johan@herland.net>
	<AANLkTilWENrG8wf1P4EMlzLSj0CdG9s3M8WAwmAZTYUX@mail.gmail.com>
	<201007140759.02822.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Sun Jul 18 15:26:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OaTsm-0002WS-1Z
	for gcvg-git-2@lo.gmane.org; Sun, 18 Jul 2010 15:26:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754968Ab0GRN0L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Jul 2010 09:26:11 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:36748 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754938Ab0GRN0K (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jul 2010 09:26:10 -0400
Received: by qyk35 with SMTP id 35so1194338qyk.19
        for <git@vger.kernel.org>; Sun, 18 Jul 2010 06:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=BmVScf0loBBaskqLH1l+DhlswWHoHPCLMDrkV2vJVVY=;
        b=DB90h/miS9h02ty7YKVCBCPC0NIxIapfe5dO4lT7AtVxw7DEMokjU02DSgpfZwjzWu
         tNQ5wRJZC7Ki6u4zRaCm4C3C0iktRx0Nj1xFPUXl8GZ9Th1baJK9+Fdqthhc/mnqjr19
         HjdQ0MPxCfkdJbeqrdlRcrSN+IlI5KMVNtpLc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=xj5aEKjS0bbnumw23ZZ9yK/uBRB6033OWA0ABcVivgRHlfdzmLfRGSAw+HONsA5q2p
         1cqMup8MXSM6C42Lyk7mcyLo3wZrGw+ahFn0mX6jgm4jj2UkINBr8rkfWiZxOGpGRFgO
         da1d6LkEYrwdODjpwjdi7By/39mzbrJXSNPhY=
Received: by 10.224.104.132 with SMTP id p4mr3279436qao.322.1279459569796; 
	Sun, 18 Jul 2010 06:26:09 -0700 (PDT)
Received: by 10.229.240.81 with HTTP; Sun, 18 Jul 2010 06:26:09 -0700 (PDT)
In-Reply-To: <201007140759.02822.johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151210>

[Sorry for the late reply]

On Wed, Jul 14, 2010 at 07:59, Johan Herland <johan@herland.net> wrote:
> BTW, have you had time to look at my previous patch series for ignoring
> whitespace in diffs?

It took a while, but I've now merged all your patches (except the
graph series) into my master branch. Thanks.

--
larsh
