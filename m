From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v21 0/19] rs/ref-transaction (Re: Transaction patch
 series overview)
Date: Fri, 12 Sep 2014 16:57:45 -0700
Message-ID: <20140912235745.GB18279@google.com>
References: <CAL=YDWka47hV2TMcwcY1hm+RhbiD6HD=_ED4zB84zX5e5ABf4Q@mail.gmail.com>
 <CAL=YDWm9VaKUBRAmmybHzOBhAg_VvNc0KMG0W_uTA02YYzQrzA@mail.gmail.com>
 <20140820231723.GF20185@google.com>
 <20140911030318.GD18279@google.com>
 <xmqqfvfxdcjz.fsf@gitster.dls.corp.google.com>
 <20140912004717.GY18279@google.com>
 <xmqqsijwaclo.fsf@gitster.dls.corp.google.com>
 <20140912191812.GZ18279@google.com>
 <xmqqk358a9yz.fsf@gitster.dls.corp.google.com>
 <54136B10.4050001@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Ronnie Sahlberg <sahlberg@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sat Sep 13 01:57:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XSaiv-00075b-Hq
	for gcvg-git-2@plane.gmane.org; Sat, 13 Sep 2014 01:57:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751764AbaILX5u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Sep 2014 19:57:50 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:43864 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751705AbaILX5t (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Sep 2014 19:57:49 -0400
Received: by mail-pa0-f53.google.com with SMTP id rd3so2283917pab.26
        for <git@vger.kernel.org>; Fri, 12 Sep 2014 16:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=ZEiJhWGnH0kBNzHegFxdalKcduQMWv0CM3ktMmJkTuA=;
        b=jN1JJrinzsVVrIEXxCSmO/x+8vrcaYq8nDl7cvj3zq3YehllFOOxQjzgAkO2Fi9Amr
         dr/PiPs5xGsfWnG68Y8YPOSfCo1nne2Zly4ziJm5a9bmX4iYCNTV5u9DWkFZxWqHUxUu
         39nSIiPAl3dW1rIqM36d2zPMzI6csymxVCxMI3R44BU9pX70Y0s95YEdkX+YBIl0HYxl
         Xm9JKdJosVk4RQqDlSTt6m7NVQz98rRC2FUnBgWLDjhvFE3jIkKRIOVpBtHbHoaaM5FL
         JELAbvPPFyXitvAIyAsqucYUeRChN83i9il3Z0NrH8nyoTI7QuG+va9rzwO/CuYJ3vPC
         oTEw==
X-Received: by 10.70.21.228 with SMTP id y4mr15506025pde.19.1410566268125;
        Fri, 12 Sep 2014 16:57:48 -0700 (PDT)
Received: from google.com (aiede.mtv.corp.google.com [172.27.69.120])
        by mx.google.com with ESMTPSA id ca2sm4944776pbc.26.2014.09.12.16.57.46
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 12 Sep 2014 16:57:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <54136B10.4050001@alum.mit.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256952>

Michael Haggerty wrote:
>> Jonathan Nieder <jrnieder@gmail.com> writes:

>>> so I'll send a reroll of the series as-is in an hour or so.
>
> Jonathan: Is a current version of this patch series set up for review in
> Gerrit?

Yes.
(https://code-review.googlesource.com/#/q/project:git+topic:ref-transaction)

Thanks,
Jonathan
