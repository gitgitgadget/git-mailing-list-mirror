From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Error in documentation for @{-n} in gitrevisions
Date: Sun, 12 Jan 2014 15:49:03 +0530
Message-ID: <CALkWK0k51=Ek_r4eiX8kve=aoSwHxGjV9m_EbMnEadt6wALFwA@mail.gmail.com>
References: <CAO54GHBRbVQWDjE70tEZY=nP==gtrqVvmx1JWYNkc_HOeDnYDA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Thomas Rast <tr@thomasrast.ch>
To: Kevin <ikke@ikke.info>
X-From: git-owner@vger.kernel.org Sun Jan 12 11:19:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W2I8y-00043r-4s
	for gcvg-git-2@plane.gmane.org; Sun, 12 Jan 2014 11:19:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751207AbaALKTp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Jan 2014 05:19:45 -0500
Received: from mail-ie0-f175.google.com ([209.85.223.175]:56395 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751168AbaALKTn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Jan 2014 05:19:43 -0500
Received: by mail-ie0-f175.google.com with SMTP id tp5so1043919ieb.34
        for <git@vger.kernel.org>; Sun, 12 Jan 2014 02:19:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=AR1mAJckXzpKUi3zMvUKkS2DN/S6+f2fUIiKaGKJ6C0=;
        b=pj9AE/PJKmZXcL3X2xAgbAwI+DyJK8TfkxsNavAWRekQVYaXHLzoCasLCqpFW5hRfP
         wwIcmbzfXbB4uedk1xQIocvqRDeIdHRVkeQphSr35ylaVpDFwRft86GjVOg8v3mJdnut
         aieIV5qh+SJ/rj5PN7rcdxBkk6BAdcjEMB53nsT8qp5UkdyvwziheonEOdLQ4nx/aUIO
         Je/L+HHUr3iYGQpuwCFNcMvuRCHLxKlqHjb7mFLOmHEwd7S06jgH79tqbrbzhsBiR7eb
         ft5xpVAH5TRISE9FYvMCNLWRyhfnwmK4PQyRYmPHLXGvQy4H8BOG+fTICEG5+xLjXqlI
         EbqA==
X-Received: by 10.42.232.206 with SMTP id jv14mr1088350icb.52.1389521983129;
 Sun, 12 Jan 2014 02:19:43 -0800 (PST)
Received: by 10.64.17.10 with HTTP; Sun, 12 Jan 2014 02:19:03 -0800 (PST)
In-Reply-To: <CAO54GHBRbVQWDjE70tEZY=nP==gtrqVvmx1JWYNkc_HOeDnYDA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240337>

Kevin wrote:
> Either the documentation is wrong, and should be changed to "<n>th
> branch/commit checkout out before the current one", or the behavior of
> @{-1} is wrong.

Yeah, the documentation needs to be updated. Patches welcome.
