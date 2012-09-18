From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Test failure: Test #3 in t1304-default-acl
Date: Tue, 18 Sep 2012 11:49:48 +0530
Message-ID: <CALkWK0nndTDxoGXjFcp5PC1JUbuifbEJdcE2N8XCcOmOkj4OKg@mail.gmail.com>
References: <CALkWK0n0bH3xPLarv35Th_agnhKCkRjgcKTJR7Xy=B_NkBHkOg@mail.gmail.com>
 <vpqy5k8raig.fsf@grenoble-inp.fr> <CALkWK0=h6iU_J=X6MFgLXPfo0rh236cTuVaU3nNSnAaikjKH5w@mail.gmail.com>
 <vpqd31kr7v4.fsf@grenoble-inp.fr> <CALkWK0=ROz8fxXgnqt-+AthU-hgq_mzFg0GhBQCrAshH_mRBPQ@mail.gmail.com>
 <vpqvcfcps2z.fsf@grenoble-inp.fr> <7v4nmwwqox.fsf@alter.siamese.dyndns.org> <vpqipbcpp69.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Sep 18 08:20:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDrAS-00051Q-Uz
	for gcvg-git-2@plane.gmane.org; Tue, 18 Sep 2012 08:20:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755261Ab2IRGUK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2012 02:20:10 -0400
Received: from mail-qa0-f46.google.com ([209.85.216.46]:35227 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753160Ab2IRGUJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2012 02:20:09 -0400
Received: by qaas11 with SMTP id s11so2237481qaa.19
        for <git@vger.kernel.org>; Mon, 17 Sep 2012 23:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=pDMXjBpLQPus4biNRuYI2WubNfF03OTQWG7gGU6GMuA=;
        b=UW+WQwtsyQIVtjbLKkKvanvY830cVjVmgELtagdpctR8kD3V0W+T4/zWuk1AaaSavv
         L6ulYLnMtCnJDXE6rAaZH6Xgwp4p1LmpBP/UQZkJDf3L/mh2f0TkCfnr2aN0PeKNxyC4
         b3yHW32ebQYyYXjXScfWgL4+pUOM8D6iPJqxKNbfM4mzSM2TCVPWVcyCr/e0QymsIPOn
         O/vMvGgcxib8Dd1YPCT8y7jYDyHbRkTldB85JpUu9G1qmTN8+lkkyNXYLN5CL6LORJKl
         mJGMyRpVNwvewxp3N24mJyMiXHBbkuPeXza6otztQrvKzryN2hOI/iKly8H0y54bSiS7
         EL8Q==
Received: by 10.224.222.143 with SMTP id ig15mr32959338qab.25.1347949208586;
 Mon, 17 Sep 2012 23:20:08 -0700 (PDT)
Received: by 10.49.84.105 with HTTP; Mon, 17 Sep 2012 23:19:48 -0700 (PDT)
In-Reply-To: <vpqipbcpp69.fsf@grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205793>

Hi,

Matthieu Moy wrote:
> I can see two reasons for having the same UID for two login names:
>
> 1) the sysadmin really messed up, and as you say, a total stranger has
> complete ownership of your files. Ramkumar, you should check that this
> is not your case.

Looks like my sysadmin really screwed up :|

Ram
