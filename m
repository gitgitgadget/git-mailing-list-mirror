From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 2/6] completion: add common options for rev-parse
Date: Fri, 7 Jun 2013 21:03:28 +0530
Message-ID: <CALkWK0khxsp7pLb_ojHqYhT1SQnAAX6DLi7eSBTn_CQ1rXAJkA@mail.gmail.com>
References: <1370181822-23450-1-git-send-email-artagnon@gmail.com> <1370181822-23450-3-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 07 17:34:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UkygA-0004CY-Ev
	for gcvg-git-2@plane.gmane.org; Fri, 07 Jun 2013 17:34:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755878Ab3FGPeK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jun 2013 11:34:10 -0400
Received: from mail-ie0-f176.google.com ([209.85.223.176]:44903 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754298Ab3FGPeJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jun 2013 11:34:09 -0400
Received: by mail-ie0-f176.google.com with SMTP id ar20so8323191iec.35
        for <git@vger.kernel.org>; Fri, 07 Jun 2013 08:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=gazJt9or+p7hruW8RC0i6k2PhBKxpMHXciP+QG4UAT8=;
        b=0YAMF9U5RZDf0g9q11UePIfxcKasq9xiYbdm+1Db6Bo/su6t9sJGkq/YAXUmwrxXpK
         Cw0BQYXaSwqsSum+kiwotVFThVddDklyA2y8SEg6hPvYd49I6lJ9D4iBhJ44gOknJE7x
         Ryi0NpefbhP+VPL3DQtfZyCNl7QlpPZeuwTXcp5uUPd0qj3X3AeoliGTsmaD1waJUDQG
         9uJkxjMe2lxMFM2g4+I5ix4UTI7eniHPh8vLWTahMHg9bDT0a6TbUifU+dfTK4Xbj+Ov
         5f6MDOCGIjCVaWC/UnVeykWwqRwlwoOlO6Vjnbdu+NjqbQbzQVJGiBq+do3xaTrUw+7O
         5iKQ==
X-Received: by 10.50.32.8 with SMTP id e8mr1662238igi.89.1370619248531; Fri,
 07 Jun 2013 08:34:08 -0700 (PDT)
Received: by 10.64.136.104 with HTTP; Fri, 7 Jun 2013 08:33:28 -0700 (PDT)
In-Reply-To: <1370181822-23450-3-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226640>

Ramkumar Ramachandra wrote:
> Add support for completing 'git rev-parse'.  List only the options that
> are likely to be used on the command-line, as opposed to scripts.

Can we get this patch?  I use git rev-list quite a lot, and want completion.
