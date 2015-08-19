From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/9] Documentation/git-send-pack.txt: Flow long synopsis line
Date: Wed, 19 Aug 2015 13:10:18 -0700
Message-ID: <xmqqlhd782fp.fsf@gitster.dls.corp.google.com>
References: <1439998007-28719-1-git-send-email-dborowitz@google.com>
	<1439998007-28719-3-git-send-email-dborowitz@google.com>
	<xmqqtwrv8328.fsf@gitster.dls.corp.google.com>
	<CAD0k6qRtXX3OqeQF_USwiNYA-y+92X65MSJqPKjhNjGka9QXBw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git <git@vger.kernel.org>
To: Dave Borowitz <dborowitz@google.com>
X-From: git-owner@vger.kernel.org Wed Aug 19 22:10:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZS9gm-00082d-Vb
	for gcvg-git-2@plane.gmane.org; Wed, 19 Aug 2015 22:10:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752115AbbHSUKV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Aug 2015 16:10:21 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:36158 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751887AbbHSUKU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Aug 2015 16:10:20 -0400
Received: by pawq9 with SMTP id q9so10162225paw.3
        for <git@vger.kernel.org>; Wed, 19 Aug 2015 13:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=IfReh0PlOaQVbz9qSd+Qrm6wYQrLwDwt1R9snYS7OiY=;
        b=sqg3shA1q4AeAJrZLDpyUK48sw8hb0ty/LUA50Q4hw+iCwTUCE971PoEHAQZ1TZWYH
         YC0YcMedixuhOirjfurEb35LVGd8EuY7NQ0nrDW2+8mtK2xFzLW8sD6Uag95v91pZtyG
         1EW8tWyTAHcLA7LKPOj62DwBRP8TkDJRjiCUnSa2NA0xV0857SP05kMa3aJXZIGxz1bd
         Upp+CMSZ//tD1irARnINJuZ7q6h13fVmBxNGm8rJjFwAvahftJQDEP33aD6azyadswtC
         hmJVOqa09q2GytMHUaIoGNJtlS3NyX/NPmbiNJuC7pTc130xxyC/DqQNmUaYISEITzTk
         xmmA==
X-Received: by 10.66.185.165 with SMTP id fd5mr21445900pac.32.1440015019906;
        Wed, 19 Aug 2015 13:10:19 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:a5d7:91a5:eac5:b635])
        by smtp.gmail.com with ESMTPSA id ml3sm1785651pab.47.2015.08.19.13.10.19
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 19 Aug 2015 13:10:19 -0700 (PDT)
In-Reply-To: <CAD0k6qRtXX3OqeQF_USwiNYA-y+92X65MSJqPKjhNjGka9QXBw@mail.gmail.com>
	(Dave Borowitz's message of "Wed, 19 Aug 2015 15:59:45 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276225>

Dave Borowitz <dborowitz@google.com> writes:

> I produced the patch with "git format-patch --subject-prefix='PATCH
> v2' --cover-letter @{u}.." and mailed with "git send-email
> --to=git@vger.kernel.org,gitster@pobox.com 0*.patch"; is there a way
> that would have preserved whitespace better?

No need to worry, I suspect that this is a local Emacs/GNUS glitch
on the receiving end.  Sorry for a noise.
