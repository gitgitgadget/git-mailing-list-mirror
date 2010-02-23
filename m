From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: APIs for automatic patch generation
Date: Tue, 23 Feb 2010 19:07:10 +0100
Message-ID: <fabb9a1e1002231007p650d78fere904f6e5572b12d@mail.gmail.com>
References: <4B803AB8.30304@web.de> <4B840AA2.3010604@web.de> 
	<fabb9a1e1002230907u6471efa5w234a5dabfa4ba5e1@mail.gmail.com> 
	<4B840EF5.2090306@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Markus Elfring <Markus.Elfring@web.de>
X-From: git-owner@vger.kernel.org Tue Feb 23 19:07:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NjzAW-0002YO-SO
	for gcvg-git-2@lo.gmane.org; Tue, 23 Feb 2010 19:07:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752332Ab0BWSHb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2010 13:07:31 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:64343 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751216Ab0BWSHb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2010 13:07:31 -0500
Received: by pwj8 with SMTP id 8so4025888pwj.19
        for <git@vger.kernel.org>; Tue, 23 Feb 2010 10:07:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=gqgLDpYQ0DtHAvJw7VJMbHez5x9wSpj/Ol2rwXWz4Kc=;
        b=a1eF7UnHWHfcpYFVIuN7VuEUEmxYw/qPMUNIWnnYEgssjiVUMdDcO/EKIFpzyG41KO
         +Iuy53EltVItCwILoYhQR+7arUr4LjiGcuVNA5BECAJ3NFjgcbdmxZHhFeYgtcqL+0HP
         QkvfHLbdMi6JrdQwUxTV034rRbVYXqien8qWI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=VLNEuDEL5nwy7jlT6flHV7Xwz0QnheYgBRvgQ/vetZtLTNtCd5DFqtrcAHBwTn0pqk
         Gsf1JG+M14LyI7xhIgLMiStUUi3Qekm+lNwB4SwlHLfq1DAhTm91K+o62NctcCpiS9om
         6QlO1B9fqvMRMd3m2ETDnNYdYOIEPIj3JuH7Q=
Received: by 10.142.247.20 with SMTP id u20mr3395642wfh.209.1266948450786; 
	Tue, 23 Feb 2010 10:07:30 -0800 (PST)
In-Reply-To: <4B840EF5.2090306@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140821>

Heya,

On Tue, Feb 23, 2010 at 18:23, Markus Elfring <Markus.Elfring@web.de> wrote:
> I do not need the whole functionality of these commands for my library.

My answer still holds.

-- 
Cheers,

Sverre Rabbelier
