From: Christian Couder <christian.couder@gmail.com>
Subject: Draft of Git Rev News edition 1
Date: Sun, 22 Mar 2015 12:03:28 +0100
Message-ID: <CAP8UFD1WtwKri8cWABnzeRvxKhdNmUfVw5xm=F4oLrevuOGyUA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Thomas Ferris Nicolaisen <tfnico@gmail.com>
To: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	David Kastrup <dak@gnu.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Paul Tan <pyokagan@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Dongcan Jiang <dongcan.jiang@gmail.com>,
	Jeff King <peff@peff.net>, Doug Kelly <dougk.ff7@gmail.com>,
	Bharat Suvarna <bharat.bs84@icloud.com>,
	Kevin D <me@ikke.info>,
	"Randall S. Becker" <rsbecker@nexbridge.com>,
	Stephen Robin <stephen.robin@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 22 12:03:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZdfN-0007X8-FR
	for gcvg-git-2@plane.gmane.org; Sun, 22 Mar 2015 12:03:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751660AbbCVLDa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Mar 2015 07:03:30 -0400
Received: from mail-ig0-f173.google.com ([209.85.213.173]:34914 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751070AbbCVLD3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Mar 2015 07:03:29 -0400
Received: by igcau2 with SMTP id au2so20928873igc.0
        for <git@vger.kernel.org>; Sun, 22 Mar 2015 04:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=VQ5PGaHYaOW84ynHjkuPeyoyX4UdfGkZM0PDitBHbVw=;
        b=iD1HMGUxg4IPgzuyQ/cKjr6v3cqZFyjsowgjIbdbGt162QBwE1OIsnO2kRw8DaaEhA
         5zkFEnW4wOs5MO5jKahhBeNBUw2JN9IP/IaF5wXpilq+S3VLPiips+gPJDnTLkHFe5ZM
         CkTifMWbkYLNeZTcAXYJnHDnhq2wUJRas9SRhU0eA3IKJNz+7GYv+u7Qi3xDRgCiZWAJ
         /1voIrBZrL6X/zESgRSPtnXf+t0m32JjBG8VXJ6vwMYbMZ783NmnDE1CrWxBzjwhAjwM
         ZOMk+j+ez7AnsEcQHIXRAwFu3mLmYlcCZ8wsQRtytk7ls4G3VMMywChd5iTTfSYXFEby
         up+A==
X-Received: by 10.42.27.143 with SMTP id j15mr13821570icc.28.1427022208171;
 Sun, 22 Mar 2015 04:03:28 -0700 (PDT)
Received: by 10.50.245.168 with HTTP; Sun, 22 Mar 2015 04:03:28 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266066>

Hi,

A draft of Git Rev News edition 1 is available here:

https://github.com/git/git.github.io/blob/master/rev_news/draft/edition-1.md

Everyone is welcome to contribute in any section either by editing the
above page on GitHub and sending a pull request, or by commenting on
this GitHub issue:

https://github.com/git/git.github.io/issues/17

You can also reply to this email.

I tried to cc the persons who appear in the edition but maybe I missed
some, sorry about that.

Thomas and myself plan to publish this edition on Wednesday the 25th of March.

We call it an "edition" instead of an "issue" to avoid confusion with
GitHub issues.

Thanks,
Christian
