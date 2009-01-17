From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: log-tree.c: date hardwired
Date: Sun, 18 Jan 2009 00:38:35 +0100
Message-ID: <81b0412b0901171538l5e9fb66bh862c9b7a125fc98f@mail.gmail.com>
References: <87r637oq41.fsf@jidanni.org> <87fxjhcy3i.fsf@jidanni.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: jidanni@jidanni.org
X-From: git-owner@vger.kernel.org Sun Jan 18 00:40:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOKll-0004dR-5p
	for gcvg-git-2@gmane.org; Sun, 18 Jan 2009 00:40:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762720AbZAQXii (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Jan 2009 18:38:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761620AbZAQXih
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Jan 2009 18:38:37 -0500
Received: from wa-out-1112.google.com ([209.85.146.183]:3111 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758145AbZAQXig (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Jan 2009 18:38:36 -0500
Received: by wa-out-1112.google.com with SMTP id v27so1184849wah.21
        for <git@vger.kernel.org>; Sat, 17 Jan 2009 15:38:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=ZcTkgN0ApPniAvrwP9/AW/n1fbJqbzQIfnlps3EXmB8=;
        b=R66tk5wZo3a+S3yGQLibafpgXWzu2l/gvv+fXemKh1efOrCbqvwouV+1KivElIP67u
         wigQ390CVF6AxN2RtGTb015op//GvaYeEU6eYVYGwiqMZHjuyaZCwt0t0HksVIOP9WF1
         lRiGs+YrIIzg/uNJLsB3c/dK63ydm54stxGS8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=Sm+6qzLGev/xBZW1QWLqJ+ncf5QE9f6x8L+tq7kjn0ztcVDb8FKpjgfliygr8I3F04
         9aXnny/w1H3pKS923O5ArQ9+NQgdqmaz9dDWPqCl0Xh6im+Bma3fykv48w8Zy3bMLUtt
         AUGwR1FrRCcQOY95+aHsTmYgKBsokYMBk44R4=
Received: by 10.114.181.6 with SMTP id d6mr2937773waf.8.1232235515455;
        Sat, 17 Jan 2009 15:38:35 -0800 (PST)
Received: by 10.114.179.4 with HTTP; Sat, 17 Jan 2009 15:38:35 -0800 (PST)
In-Reply-To: <87fxjhcy3i.fsf@jidanni.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106111>

2009/1/18  <jidanni@jidanni.org>:
> Can I get a go-ahead from somebody for me to begin work on implementing a fix?

No. Try and guess why
