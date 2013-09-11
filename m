From: Javier Domingo <javierdo1@gmail.com>
Subject: Re: [RFC] Disabling status hints in COMMIT_EDITMSG
Date: Wed, 11 Sep 2013 16:03:13 +0200
Message-ID: <CALZVapkJMdaHt=-PBbmDnnNA+uPj6vRzeDdmmFGJcGahXFg-4Q@mail.gmail.com>
References: <vpq4n9tghk5.fsf@anie.imag.fr> <xmqqeh8wzl0h.fsf@gitster.dls.corp.google.com>
 <vpq61u7akin.fsf@anie.imag.fr> <CAEBDL5VVxMSPnfwBL4PiQAjAHDX1FkfaG3SOFZ1oqEh8d6S1YQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: John Szakmeister <john@szakmeister.net>
X-From: git-owner@vger.kernel.org Wed Sep 11 16:03:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJl19-0002Ku-9x
	for gcvg-git-2@plane.gmane.org; Wed, 11 Sep 2013 16:03:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754053Ab3IKODe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Sep 2013 10:03:34 -0400
Received: from mail-vb0-f48.google.com ([209.85.212.48]:61657 "EHLO
	mail-vb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753885Ab3IKODe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Sep 2013 10:03:34 -0400
Received: by mail-vb0-f48.google.com with SMTP id w16so6007450vbf.7
        for <git@vger.kernel.org>; Wed, 11 Sep 2013 07:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=SggKJkTCVajhly/2EY+Gv1WpObX2vwJZhjwtQPWtO6c=;
        b=dVOjmeNLU6cswMBHFfioa731sUDpQma8DMLp7wsFtYQeMIX4pGt8/vLjK1QrLkMX9+
         34QxGD1XlkqTb+UE202XWX6gFnJvGrT8KEqmCmWIID2TFOWuYmR4hA6t9f12zd3lEVYS
         3DAeKRfjvU6BoZsajGT8gLVWUaorZsI41PAoVfa7I+EeGQYL6ckiDfItPG6eJIa9bBJQ
         SGj/SqpINqHyyv3slUA9MNBrWj0ZQWU17ORbhrLoo2OwJV7GNcmJcpr1JENlvXQ2ip2o
         kXYp/lqBYwgPqfpJz8dVN7w8ZN5E2CKE68HOw1UZRq9S72R2cm99/tG1OvA9O2nBgNto
         ncqw==
X-Received: by 10.58.118.130 with SMTP id km2mr1422026veb.0.1378908213633;
 Wed, 11 Sep 2013 07:03:33 -0700 (PDT)
Received: by 10.58.200.74 with HTTP; Wed, 11 Sep 2013 07:03:13 -0700 (PDT)
In-Reply-To: <CAEBDL5VVxMSPnfwBL4PiQAjAHDX1FkfaG3SOFZ1oqEh8d6S1YQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234566>

That extra info doesn't occupy too much, and helps distinguish between
sections. They do also remember you the commands to use (thought after
some time using git, you may not need it).

Cheers,

Javier
