From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv5 09/12] gitweb: group styling
Date: Mon, 27 Sep 2010 00:10:44 +0200
Message-ID: <201009270010.45142.jnareb@gmail.com>
References: <1285344167-8518-1-git-send-email-giuseppe.bilotta@gmail.com> <1285344167-8518-10-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 27 00:11:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzzRi-0000bD-MZ
	for gcvg-git-2@lo.gmane.org; Mon, 27 Sep 2010 00:11:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757859Ab0IZWKz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Sep 2010 18:10:55 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:41518 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757790Ab0IZWKy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Sep 2010 18:10:54 -0400
Received: by bwz11 with SMTP id 11so2941360bwz.19
        for <git@vger.kernel.org>; Sun, 26 Sep 2010 15:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=UqH4CroNlSOEWrBzv2Uj23WxjfvfIKQtwUhJaI1dZVE=;
        b=XLEJB5JpzGjrXAzoOjRzN/KpU19gUE3jMIYhMJzdSgAHwXSizWXEbC5rUWjlsrWzS1
         ls+dyYIgWh8WsV+N7PT+V4wd7LfDyGxH6X+nlkPkMIppUSw2jG3f6xaw4LD03d6ZAvd2
         MEDC+BF7BfGarfbWeOW6+6TSom9GF7xnljfSo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=FPAG1Y1+6z7uLo7kJzoQePFJ20D8drWpV4zJD8CPoGarlIxv6AJfq5bnTfO7R8UD3c
         Z4gRfppDnPJvfzNZypVf51egpCot88T1+6iATZV1ViN2ZdTNN3yRN45SMleTS9B8Tcev
         QcLHP6wzqPSG22xN4oCt/Kay6wq0L+8qAD56c=
Received: by 10.204.7.88 with SMTP id c24mr4470872bkc.172.1285539053001;
        Sun, 26 Sep 2010 15:10:53 -0700 (PDT)
Received: from [192.168.1.13] (abwp12.neoplus.adsl.tpnet.pl [83.8.239.12])
        by mx.google.com with ESMTPS id v7sm1026328bkx.16.2010.09.26.15.10.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 26 Sep 2010 15:10:52 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1285344167-8518-10-git-send-email-giuseppe.bilotta@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157262>

On Fri, 24 Sep 2010, Giuseppe Bilotta wrote:

> +div.group {
> +	margin: .5em;
> +	border: 1px solid #d9d8d1;
> +	display: inline-block;
> +}

As I currently at this moment don't use web browser which supports 
'display: inline-block;', I can't say much about this patch.  But
it does degrade nicely.

-- 
Jakub Narebski
Poland
