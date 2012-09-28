From: Angelo Borsotti <angelo.borsotti@gmail.com>
Subject: Re: git gui does not open bare repositories
Date: Fri, 28 Sep 2012 14:09:19 +0200
Message-ID: <CAB9Jk9C=ndfO37YWS5mg4anu91N4O__iA_msmxU+X2_Nakv-tQ@mail.gmail.com>
References: <CAB9Jk9CA+e8xR9sz7cW+5+990FmTeYN3pjxs4ZKFpkzb6OL35Q@mail.gmail.com>
	<CAH6sp9N1cFH7orPNmfbhgHq6oUNtQNe=-5f5jkYNXzr+6Xp_pQ@mail.gmail.com>
	<CAB9Jk9BivVrH7daMR=u5Y6Ut=pZGRBcgKNZ_afZ53XFxhFBnZw@mail.gmail.com>
	<CAH6sp9ME0og0E-=oW6MBFMBv8hD0y8PpmdpyaV4qqr7Mb7c5VA@mail.gmail.com>
	<50656388.3050400@atlas-elektronik.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Frans Klaver <fransklaver@gmail.com>, git <git@vger.kernel.org>
To: =?ISO-8859-1?Q?Stefan_N=E4we?= <stefan.naewe@atlas-elektronik.com>
X-From: git-owner@vger.kernel.org Fri Sep 28 14:09:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THZNp-0003VN-Oo
	for gcvg-git-2@plane.gmane.org; Fri, 28 Sep 2012 14:09:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757511Ab2I1MJU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Sep 2012 08:09:20 -0400
Received: from mail-vc0-f174.google.com ([209.85.220.174]:59642 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751613Ab2I1MJT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Sep 2012 08:09:19 -0400
Received: by vcbfo13 with SMTP id fo13so3200238vcb.19
        for <git@vger.kernel.org>; Fri, 28 Sep 2012 05:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=fCjnbByFxPwfJ9o+dYnC/tzCMFvJG/yKNpTADk6tzZE=;
        b=cRZ64u6J0zwtzMeq/B3Qgu5f68njtidReQ7DAGBdP51GZyREY4BgTcEzc8F/IpCCm2
         bsfZZRfQYt5u2kIiLAbCnU5OPVsPCaH5s+YVllFYks+SJ5RgJYIuLnnRmAGhN25llNMn
         ZVc3ib4VYBifZeanEG7sI/+rpZxzntN382Z+UtNS9XHntLjhGB4f06Vo57sw1/W/y5D7
         e6W1s+bVRfX4z0wPw7rcsHaAfwexvhCbfu/txdUZtpcUK7KhrnpOq0D7hMMEyoADqEN6
         vBuE7KOGVLKPOie1w/cD1CvFb9hCwRt9DoXpVlLLlBLjXR3BX1VHD7tuuGphY/Y3+eO4
         qN3g==
Received: by 10.220.228.131 with SMTP id je3mr3897308vcb.73.1348834159205;
 Fri, 28 Sep 2012 05:09:19 -0700 (PDT)
Received: by 10.58.68.40 with HTTP; Fri, 28 Sep 2012 05:09:19 -0700 (PDT)
In-Reply-To: <50656388.3050400@atlas-elektronik.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206572>

I have removed the Italian localization so as to make git gui use the
English one.
The result is the same as I have found before.
The message is: " Not a Git repository: remote.git".
Thus, the misleading message is there.

-Angelo
