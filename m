From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH v4 1/5] refs: Introduce pseudoref and per-worktree ref concepts
Date: Thu, 30 Jul 2015 05:45:50 +0200
Message-ID: <CALKQrgeswFaWD1Fb7z=iOpDQq_pW0KTYd+bZB1L7ZaHHoFmAww@mail.gmail.com>
References: <1438192688-8048-1-git-send-email-dturner@twopensource.com>
	<1438192688-8048-2-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git mailing list <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Thu Jul 30 05:46:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKenD-0004Mx-MY
	for gcvg-git-2@plane.gmane.org; Thu, 30 Jul 2015 05:46:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753438AbbG3Dp7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jul 2015 23:45:59 -0400
Received: from locusts.copyleft.no ([188.94.218.116]:53523 "EHLO
	mail.mailgateway.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752542AbbG3Dp6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jul 2015 23:45:58 -0400
Received: from mail-yk0-f179.google.com ([209.85.160.179])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1ZKen6-000PF7-GX
	for git@vger.kernel.org; Thu, 30 Jul 2015 05:45:56 +0200
Received: by ykba194 with SMTP id a194so25049353ykb.0
        for <git@vger.kernel.org>; Wed, 29 Jul 2015 20:45:50 -0700 (PDT)
X-Received: by 10.170.127.145 with SMTP id t139mr49396989ykb.88.1438227950684;
 Wed, 29 Jul 2015 20:45:50 -0700 (PDT)
Received: by 10.37.208.71 with HTTP; Wed, 29 Jul 2015 20:45:50 -0700 (PDT)
In-Reply-To: <1438192688-8048-2-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274966>

On Wed, Jul 29, 2015 at 7:58 PM, David Turner <dturner@twopensource.com> wrote:
> +       specially by git.  Psuedorefs both have names that are all-caps,

s/Psuedo/Pseudo/

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
