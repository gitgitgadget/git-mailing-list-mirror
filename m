From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] fetch doc: escape asterisk in --tags paragraph
Date: Fri, 7 Jun 2013 20:43:13 +0530
Message-ID: <CALkWK0=Oi_PzLni=Hxw6fh=8s1SjKJCmQf0xDSmCPSg_OBrYHQ@mail.gmail.com>
References: <1370604694-2438-1-git-send-email-artagnon@gmail.com>
 <7vppvyugeg.fsf@alter.siamese.dyndns.org> <7vk3m6ufcw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 07 17:14:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UkyMZ-0001lu-G8
	for gcvg-git-2@plane.gmane.org; Fri, 07 Jun 2013 17:13:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755255Ab3FGPNz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jun 2013 11:13:55 -0400
Received: from mail-ie0-f182.google.com ([209.85.223.182]:56307 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754831Ab3FGPNz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jun 2013 11:13:55 -0400
Received: by mail-ie0-f182.google.com with SMTP id 9so10826865iec.41
        for <git@vger.kernel.org>; Fri, 07 Jun 2013 08:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=jXyZsT5JKWLQEUrNefXyzcG0xIE79IL1RsF9wYf5ctg=;
        b=zvWxS2TwspgSASpxjSQU8TpqCEXrST7OSsNxZgma27U5gJ96A/zRqKCl4L9n9hFnzw
         tvscjgMR5ndDRVWky8upjkHyimkmqZu13qNkr91k89YdVYN8Pv+nm0UBFrAeaxzh/6kL
         AbQvitZEsJ7ZBhgzGplNY8f+mID5V8ybWYkE46Wru43F5z3uGMtRk5Bxx/M9HHfv0+ur
         fwyd88/V85ACI36/C+JZQJHKlLiNWskGdF4hU3OSEx8RsK1sij/3YJHGr+ETmwDDifAc
         AFhQtZJdL9WuOQ/eYrNnCZZqN8mpVISBeZD1MHRef6jsaBwqHeJkPb0DMSwg8YU59xr+
         5epw==
X-Received: by 10.50.32.8 with SMTP id e8mr1615435igi.89.1370618034751; Fri,
 07 Jun 2013 08:13:54 -0700 (PDT)
Received: by 10.64.136.104 with HTTP; Fri, 7 Jun 2013 08:13:13 -0700 (PDT)
In-Reply-To: <7vk3m6ufcw.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226636>

Junio C Hamano wrote:
> How about this?

Looks good, thanks.
