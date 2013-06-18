From: Alexander Nestorov <alexandernst@gmail.com>
Subject: Re: [Request] Git reset should be able to ignore file permissions
Date: Tue, 18 Jun 2013 17:51:36 +0200
Message-ID: <CACuz9s1H2Gi+B7=Fc3yJ+PC9oDueLQzXstSX0C9uAy3_MN4Kag@mail.gmail.com>
References: <CACuz9s31OUWNxTqCmj7ukAo7=TpXK7zBv5kTFZ5obpXKOju9ng@mail.gmail.com>
 <vpqsj0fr19j.fsf@anie.imag.fr> <CACuz9s1KGKsL-pGftAtAWyX5gUA5c-PYyJUSstf+xw151rZLtA@mail.gmail.com>
 <vpq7ghrqzrv.fsf@anie.imag.fr> <CACuz9s0=7z-M1-zgRNUs2hS-4LcuXrsWbqyDaMnuvFXRnP7E-Q@mail.gmail.com>
 <vpqppvjpjz3.fsf@anie.imag.fr> <CACuz9s2DfN5O91ZF8QOnWuA0V3bGFuUG5RVmkmjeL7Jien+fYg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Jun 18 17:52:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UoyCl-0004GB-M7
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 17:52:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932364Ab3FRPwS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jun 2013 11:52:18 -0400
Received: from mail-qe0-f41.google.com ([209.85.128.41]:35391 "EHLO
	mail-qe0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756305Ab3FRPwR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jun 2013 11:52:17 -0400
Received: by mail-qe0-f41.google.com with SMTP id b4so2574662qen.0
        for <git@vger.kernel.org>; Tue, 18 Jun 2013 08:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=7zKLM6pR3SYk8PoACWezrgt397V6PrwnLSojEigLlOA=;
        b=OEIIMUZgGdWTaROShmC+lMotf0ps/qJrbmNRJ8kZx1ezM6WFIrmYFxY+2jtFp1G5iI
         6/u5rxKnRkwn9dAFB8TIBuytd9qDTCrv4ste027wrsG20m71q7N+TTs9pidwiQMmqkaM
         f+hloDKSZcG8Jn3vUefutznCLHMf2wW3TVMJv9bv8I7RR0Wnc3tLed1NgkGliDPAa9FG
         pT4/aw4gesuliV52rMAZqWmV9gNfDekNn0q6Rrkj3Xaq6DTerd1mttc/31XvgoCMztf2
         CGfw6IR1Vi2PyDRckhbfDnY+Vcc9i5BUTBL+QJNwA/2Q+2gr4ZxLXH0/oSxKjlesPnAm
         b/OA==
X-Received: by 10.229.198.133 with SMTP id eo5mr8678434qcb.148.1371570736314;
 Tue, 18 Jun 2013 08:52:16 -0700 (PDT)
Received: by 10.229.168.70 with HTTP; Tue, 18 Jun 2013 08:51:36 -0700 (PDT)
In-Reply-To: <CACuz9s2DfN5O91ZF8QOnWuA0V3bGFuUG5RVmkmjeL7Jien+fYg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228256>

I'm home, https://github.com/alexandernst/git/commit/61f0a7d558e3cbae308fabdff66bd87569d6aa18
Is that good? Should I PR?
