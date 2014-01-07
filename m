From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 1/2] completion: complete format.coverLetter
Date: Tue, 7 Jan 2014 16:54:27 +0530
Message-ID: <CALkWK0=DTB629jUZfQceeEZjjR4RK-b-xBqaTN2+HUG8VGP_0Q@mail.gmail.com>
References: <1389028732-27760-1-git-send-email-artagnon@gmail.com> <1389028732-27760-2-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 07 12:25:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0UmX-0002Z7-GK
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jan 2014 12:25:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750806AbaAGLZJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jan 2014 06:25:09 -0500
Received: from mail-ig0-f175.google.com ([209.85.213.175]:37091 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750760AbaAGLZH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jan 2014 06:25:07 -0500
Received: by mail-ig0-f175.google.com with SMTP id j1so9892098iga.2
        for <git@vger.kernel.org>; Tue, 07 Jan 2014 03:25:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=0RCKPiQBZucDMlyZGJV2McG9dZUHroRzyUilcG58/N4=;
        b=tQmsoUA73lFfZ6YnZLvcmAd3KvrQOP+0HZGnthwxqac5MHrDc36WepSsUT9jRu2ib2
         unqqK0CaTD5tW+Bhx4biA+jXODV11UITphXyiI4xoux75iRJNRamy+6qkp8hP3zrDzcu
         IwBpR559I3j0oJX9byKMyj8G+CV6BhmnjQ+rLQfBT9LScMe21oRuxtHN/SQBI8dC9K0d
         t/jpk2TOK1Df7A7tWhDl5PNN75J33xm8tEj1Ef8I4VU6vUahcjQLbyyMn9cWE0YWMyqK
         LBAGyujPwiSOCEm8VWERdVKR+esaFZcoPXnrN0bRypGyiCykX8oqWE6syt7zt/La4CPC
         eVhg==
X-Received: by 10.51.17.11 with SMTP id ga11mr25373081igd.36.1389093907287;
 Tue, 07 Jan 2014 03:25:07 -0800 (PST)
Received: by 10.64.17.10 with HTTP; Tue, 7 Jan 2014 03:24:27 -0800 (PST)
In-Reply-To: <1389028732-27760-2-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240105>

Ramkumar Ramachandra wrote:
>  contrib/completion/git-completion.bash | 1 +
>  1 file changed, 1 insertion(+)

Junio: Please push this part via 'maint' independently.
