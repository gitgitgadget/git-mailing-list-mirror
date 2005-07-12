From: Bryan Larsen <bryan.larsen@gmail.com>
Subject: Re: Stacked GIT 0.4
Date: Tue, 12 Jul 2005 07:05:57 -0400
Message-ID: <42D3A415.5000709@gmail.com>
References: <1120899939.7125.4.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: GIT <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 12 13:07:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DsIbf-0001z3-GB
	for gcvg-git@gmane.org; Tue, 12 Jul 2005 13:07:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261326AbVGLLGo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 12 Jul 2005 07:06:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261176AbVGLLGo
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jul 2005 07:06:44 -0400
Received: from zproxy.gmail.com ([64.233.162.205]:65294 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261326AbVGLLF6 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Jul 2005 07:05:58 -0400
Received: by zproxy.gmail.com with SMTP id r28so508571nza
        for <git@vger.kernel.org>; Tue, 12 Jul 2005 04:05:58 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=eYHrZXXq4TCktEObC0Gaxaj56jz2sBoyed4VUA4fLa7hmZJC5EgHYNQc5lsglLTXiWe4srllv8PalZTFR17XordpcrJnjxPDBT7Fk/b8+Tvjchk0yGyEVbakrRTGgUQj9wk+rrzu9qEUsQZGZ//8Z2Ngrhz7zyXsyzIXJDrM4Wg=
Received: by 10.36.129.6 with SMTP id b6mr1550200nzd;
        Tue, 12 Jul 2005 04:05:58 -0700 (PDT)
Received: from ?192.168.2.80? ([69.159.204.165])
        by mx.gmail.com with ESMTP id 12sm2639652nzn.2005.07.12.04.05.57;
        Tue, 12 Jul 2005 04:05:58 -0700 (PDT)
User-Agent: Mozilla Thunderbird 1.0.2 (Macintosh/20050317)
X-Accept-Language: en-us, en
To: Catalin Marinas <catalin.marinas@gmail.com>
In-Reply-To: <1120899939.7125.4.camel@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Catalin Marinas wrote:
> Stacked GIT 0.4 release is available from http://procode.org/stgit/
> 

Very nice.

Here's my wishlist.  Hopefully I'll be able to dig in and help out.

import: the complement to export
template files for the "series" output of export, to put it into a 
format that "sendpatchset" understands.

Bryan
