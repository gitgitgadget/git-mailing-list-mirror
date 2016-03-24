From: work <motroniii@gmail.com>
Subject: GSoC proposal
Date: Thu, 24 Mar 2016 23:15:53 +0300
Message-ID: <56F44AF9.2020406@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: larsxschneider@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 24 21:17:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajBgf-00018z-7K
	for gcvg-git-2@plane.gmane.org; Thu, 24 Mar 2016 21:16:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751105AbcCXUP6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Mar 2016 16:15:58 -0400
Received: from mail-lf0-f48.google.com ([209.85.215.48]:34335 "EHLO
	mail-lf0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750870AbcCXUP5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Mar 2016 16:15:57 -0400
Received: by mail-lf0-f48.google.com with SMTP id c62so40115577lfc.1
        for <git@vger.kernel.org>; Thu, 24 Mar 2016 13:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=QaHM5He3tNHXPdcv/RzS9DrXFhLSOrDno1iKXF37XsU=;
        b=iApA+aLKLzrJRoMe6ho4QonhI4fut3qDZljet9VCV+DQZ3QdzYzSZfdC41DeF0hSkZ
         G2oEQaOnE8U8J63rV8UogqVBszbwi3gMVGd8ubs3elUG3FX6L32lFt2TMf0uOUmB8bWH
         ZifOiDcFko4tuVYqIxGy2iv7mgQq4zjz7kv4PyB+bmV5l8nkuLabl+CG8me4XrawzfOq
         +MdxmFHdHtNXvRF0X5rnwGWoj4fUOW/mjZh9I7QKeP/xTmlTg3sR5wOd7bFE99x1zbBc
         Y+Xz7ldrDqoACm4M7KfjaU4pFutUT7ZOiO93Q55SS0VveB+XWG3wZyb0l9xQUpEemaKl
         g+GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=QaHM5He3tNHXPdcv/RzS9DrXFhLSOrDno1iKXF37XsU=;
        b=UybZV8fZkaotZasDqfIND6zROaAgPpKZZvDevWyS/UWjmfBrXaezD4R2Y+o6fCQEoX
         gSLvsLVMjwy4wHmIU1Qs2mtn9Rjv8SMA5TevDO0waoAlpwqsyX7HD7n2+eX2Ckmdteb9
         /BPtk5sLI46snSxoSvCMgSSvngZD8iZEuW6LSLMqrseaYYTgnGL5SFRcKAJACdtgTh5p
         Ot1kZ6JNpgLzGhAnPK+MKIOgJQrDC7DLNuCxM5zIbZo4e8TgoYTKRFkZZ2bn4X/Umb9y
         33neo7Li2oHm1WfsqsKTDh2tJbPC+bU3c59ak5Mki798spQ6R92qixzrh0jza0Ntut2M
         8jvw==
X-Gm-Message-State: AD7BkJJVXXKfAfEZ2VWl7p5VYk2HzHY8y5H4czm1t4VC6Hbbd+iGNFENj2rUHvbclMikDA==
X-Received: by 10.25.160.79 with SMTP id j76mr4355942lfe.83.1458850555402;
        Thu, 24 Mar 2016 13:15:55 -0700 (PDT)
Received: from [172.16.163.135] (ppp91-76-147-218.pppoe.mtu-net.ru. [91.76.147.218])
        by smtp.gmail.com with ESMTPSA id um4sm1392471lbb.1.2016.03.24.13.15.54
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 24 Mar 2016 13:15:54 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289795>

As I was strongly encouraged to submit my GSoC proposal, I'll post it 
here and CC to my possible mentor.
Please, provide with your feedback about my draft. You can also comment 
it right in the Google doc. Thanks in advance

Proposal: 
https://docs.google.com/document/d/1Hpu9FfD3wb7qgWgTiKtIAie41OXK3ufgnhnNuRaEH4E
