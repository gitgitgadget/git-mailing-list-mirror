From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: [PATCH] git-submodule: New subcommand 'summary'
Date: Tue, 8 Jan 2008 20:20:35 +0800
Message-ID: <46dff0320801080420v6295939aw86a6cba3ceb8c076@mail.gmail.com>
References: <1199122505-27478-1-git-send-email-pkufranky@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 08 13:21:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCDS6-0007yq-Fq
	for gcvg-git-2@gmane.org; Tue, 08 Jan 2008 13:21:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751376AbYAHMUh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jan 2008 07:20:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751275AbYAHMUh
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jan 2008 07:20:37 -0500
Received: from py-out-1112.google.com ([64.233.166.176]:6307 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751254AbYAHMUg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jan 2008 07:20:36 -0500
Received: by py-out-1112.google.com with SMTP id u52so13181803pyb.10
        for <git@vger.kernel.org>; Tue, 08 Jan 2008 04:20:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=J8KmRDY1zbZRvT3YZZMd10vRCgJFUVljJx+yP/8cnoE=;
        b=SfG/bqf8Xa/60f+6+keUHnUTuW5lXgK40++n22zo33Ge4nW6d5hYdNB8At3NE32/vpQoGZNuqP/SEMfMrv+9+JChqwfXKzXLMnXsj406vZqwcNc4A15u1VjJSY1BZmKyki2C/M62nWJfUWpBoewPizzma7t+P5Ks+NYIFKIJ7m4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=h1/pO44kRL1pi3EjCKTYJkSL+Nl3nyS37sU0A1NedQiA1UpLKgUPFvtSD5wA6jyZUPslKHbQQtK7k/uKRIvMUUEHYnlVr4+C0p3UqNl9ESorUuWVLWHvto8TGWLNCmHgvgE8WJVBdHd9l6VtOBI1C+Vd9gdX4hhNbWLFH7VaRY4=
Received: by 10.35.79.3 with SMTP id g3mr1739038pyl.3.1199794835291;
        Tue, 08 Jan 2008 04:20:35 -0800 (PST)
Received: by 10.35.108.1 with HTTP; Tue, 8 Jan 2008 04:20:35 -0800 (PST)
In-Reply-To: <1199122505-27478-1-git-send-email-pkufranky@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69870>

Any comment to my patch?

Following this i will give patches to introduce submodule summary
function into git-commit

On Jan 1, 2008 1:35 AM, Ping Yin <pkufranky@gmail.com> wrote:
> The patch series ( 3 in total) teach git-submodule a new subcommand 'summary'.
>
> PATCH 1 introduces the code framework.
>
> PATCH 2 does the real work for summary.
>
> PATCH 3 teaches a new option '--summary-limit|-n'.
>
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>



-- 
Ping Yin
