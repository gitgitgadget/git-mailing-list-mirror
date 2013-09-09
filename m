From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 1/3] reset: add --stage and --work options
Date: Mon, 9 Sep 2013 05:45:58 +0530
Message-ID: <CALkWK0kSBXCmCcDJ0p+CJMF4V1+RC2s_toRY_wNnZJOA164HNA@mail.gmail.com>
References: <20130829180129.GA4880@nysa> <1377800397-5434-1-git-send-email-felipe.contreras@gmail.com>
 <1377800397-5434-2-git-send-email-felipe.contreras@gmail.com>
 <CALkWK0=P0xZAk95Jmw9mRUCwPQP7NmVHsuPaWNg+D2v3wP9=-w@mail.gmail.com> <CAMP44s01CqJoDupmiD4K85Y1p9jF0PrT3v5owrS5WQkKQ-kkXA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 09 02:16:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIp9n-0001uO-7o
	for gcvg-git-2@plane.gmane.org; Mon, 09 Sep 2013 02:16:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751056Ab3IIAQj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Sep 2013 20:16:39 -0400
Received: from mail-ie0-f180.google.com ([209.85.223.180]:36422 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750848Ab3IIAQi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Sep 2013 20:16:38 -0400
Received: by mail-ie0-f180.google.com with SMTP id 10so8223873ied.39
        for <git@vger.kernel.org>; Sun, 08 Sep 2013 17:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=cQ6dNqX6rUBnV/b0AtOlnHIrJXj4BJiVxpxCJjBpZPI=;
        b=U0kg8SA7e3Cso46pQJKtRS/MzOLwgBlUMm5oSe5NQ/FOqucdczukJpSs0ZzPRygHpA
         JgyTPuxCDjEklgumqw5jIeOpB6uRvWVhmLo2Sz4P924tD63W21wbavatzxH9yqTMjy0b
         fJECWjsBxG8yBOKM6W3D1kJS8NGuoGkOSJuWGOj8/LShCwU/ABZZO7vNdZTqZNhJn+Va
         RWr331E6VlM6rhiRPOqSUVSoMfmd1v01j/fH3hQQmvaudBAGHljlXoZDdJCOo/EnuRQ5
         U69v1PXBXbMAWGkGjnlwNBZbrZTWjTs5QxOq9PXd42SMlP3iO6PsJ+nD1uZtkyQ+DYBK
         MPAg==
X-Received: by 10.50.9.37 with SMTP id w5mr6161692iga.29.1378685798578; Sun,
 08 Sep 2013 17:16:38 -0700 (PDT)
Received: by 10.64.73.5 with HTTP; Sun, 8 Sep 2013 17:15:58 -0700 (PDT)
In-Reply-To: <CAMP44s01CqJoDupmiD4K85Y1p9jF0PrT3v5owrS5WQkKQ-kkXA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234287>

Felipe Contreras wrote:
> Either way it doesn't matter because Junio is determined to stand
> alone versus the rest of the world in this issue.

Which is why he's the maintainer. Send in incremental updates, and he
should be fine.
