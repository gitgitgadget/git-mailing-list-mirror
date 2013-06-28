From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] fixup-builtins: remove unused cruft
Date: Fri, 28 Jun 2013 22:57:17 +0530
Message-ID: <CALkWK0k39d3=Z2czdwdiwXmpNNYiUHUSvZubCqbfP5QFCebqTQ@mail.gmail.com>
References: <1372434379-24085-1-git-send-email-artagnon@gmail.com> <20130628164545.GB9127@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jun 28 19:28:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UscSp-0002MP-Fd
	for gcvg-git-2@plane.gmane.org; Fri, 28 Jun 2013 19:28:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755268Ab3F1R17 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Jun 2013 13:27:59 -0400
Received: from mail-ie0-f171.google.com ([209.85.223.171]:53584 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755063Ab3F1R17 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Jun 2013 13:27:59 -0400
Received: by mail-ie0-f171.google.com with SMTP id qd12so4693440ieb.16
        for <git@vger.kernel.org>; Fri, 28 Jun 2013 10:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=7PvDIIqMUkwNcwNqrF1VDgzBjS+/ze09JuQcr3UycGQ=;
        b=y0H5lydQCzEYqBQUVzO5xr4ZMPkvfCwGNzlq9B4hgJwIwKTO07bf1+w6sSahZ4ncRV
         XbuqlFGo3ODvTHDiyoBphxyn47alj3peRRoQi6tn9ZDXEPnTGCzd9oM7JPueffMQojvV
         E4X5LRGIZ/A2dni4Uy5rLODsLWyG6E1zlg6/4mdNwAqxEPr9WX4ZiJ1WXMkQ3jyS0Ipy
         rsETrCAFyQu3YVFR34aqBjLqI4lF36Uy/jxuMr1aqgJdju6SNpjzNiSPc7YBZZ3Fte2O
         0Jbw9sebrpj8QAlTfbj3nMvF/myZ8T4eidaZAQUVhmHe+7zNhA74JqOvRRBPu7HykAi5
         wUMg==
X-Received: by 10.50.66.130 with SMTP id f2mr4767907igt.55.1372440477937; Fri,
 28 Jun 2013 10:27:57 -0700 (PDT)
Received: by 10.64.37.130 with HTTP; Fri, 28 Jun 2013 10:27:17 -0700 (PDT)
In-Reply-To: <20130628164545.GB9127@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229219>

Jeff King wrote:
>   This script was added in 36e5e70 (Start deprecating "git-command" in
>   favor of "git command", 2007-06-30) with the intent of aiding the
>   transition away from dashed forms. However, nobody is really working
>   on that transition, and even if they did, this tool will probably lead
>   them in the wrong direction, as it produces a large number of
>   questionable changes.

Sure, that sounds good.
