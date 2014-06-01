From: "C. Benson Manica" <cbmanica@gmail.com>
Subject: (unknown)
Date: Sun, 1 Jun 2014 14:24:54 -0700
Message-ID: <CA+kozekeTOBZFauhU2EY18hTzhpZ-VUnbBH91CtErnD4UGSNsw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 01 23:25:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WrDFU-00053o-Vh
	for gcvg-git-2@plane.gmane.org; Sun, 01 Jun 2014 23:25:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751847AbaFAVYz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Jun 2014 17:24:55 -0400
Received: from mail-ve0-f180.google.com ([209.85.128.180]:40914 "EHLO
	mail-ve0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750983AbaFAVYz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Jun 2014 17:24:55 -0400
Received: by mail-ve0-f180.google.com with SMTP id db12so4349286veb.11
        for <git@vger.kernel.org>; Sun, 01 Jun 2014 14:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=S+D2o7B9pVzPtih6bTtmq0mZX1FzoVwzZ2lpLXwu5yE=;
        b=rkdgoLgRA5sgk8F7YUtVp1sdgVENDK4f9S2bhYPqFkhdeN9t7e5Ao7E5UQpW2D/zmH
         jX638tDmbSiPEipEoMP1XyB5AaxQQGRyv9n+CkWZ5KXz55shs2mpz0QolzgKWUmRZWY6
         De0YRKizU3xM46IMbWzqeRvCS0vYh3E+FW3WeXObZo3bo2UepIaXXyHU4LgEpM11X3K4
         E1LoSuByBwSU2eowgJzy+JwQjzH7TJyqz7ctgn/I5lnxamFzqf/510QMu8CEtHbLrbZe
         MXIlTfjdMKX+5OLfHsEQrl6d846UNv+M/r4YZ3HyFCEAgZr0xF4vDpBq7hfNRcpFR36C
         Jp5A==
X-Received: by 10.220.163.3 with SMTP id y3mr26263250vcx.7.1401657894115; Sun,
 01 Jun 2014 14:24:54 -0700 (PDT)
Received: by 10.58.151.197 with HTTP; Sun, 1 Jun 2014 14:24:54 -0700 (PDT)
Subject: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250547>

The documentation for installing git from source here,
http://git-scm.com/book/en/Getting-Started-Installing-Git, incorrectly
fails to mention that the MakeMaker perl module is also required and
is installable via

$ yum install perl-ExtUtils-MakeMaker

Also, you might want to let people know that you've configured your
mail system for 1987 mode and do not accept HTML-formatted mail.

-- 
C. Benson Manica
cbmanica@gmail.com
