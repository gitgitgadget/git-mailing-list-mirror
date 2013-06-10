From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: [PATCH] Documentation/CommunityGuidelines
Date: Mon, 10 Jun 2013 17:09:04 -0400
Message-ID: <51B64070.2080209@gmail.com>
References: <CALkWK0mqk5sRPV8PHz8RqZH-Ln7TUtkHPVbvsJPKuVSXiUOiww@mail.gmail.com> <51B5D9A1.1080900@ensimag.fr> <vpqhah6hxjm.fsf@anie.imag.fr> <robbat2-20130610T162316-152176477Z@orbis-terrarum.net> <7vzjuxj21b.fsf@alter.siamese.dyndns.org> <20130610190102.GF12924@google.com> <CALkWK0neo-OF7P__T5u5oHrJgseJ-H5Zk=qbpDDYttdaaRu6gQ@mail.gmail.com> <51B639FC.7030007@gmail.com> <CALkWK0n5fVZ7t-5aAO6AXM5DpxqYfL_QLxkD48edK65rGsrX_g@mail.gmail.com>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	"Robin H. Johnson" <robbat2@gentoo.org>,
	Git Mailing List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 10 23:09:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Um9Kz-0000C7-9M
	for gcvg-git-2@plane.gmane.org; Mon, 10 Jun 2013 23:09:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753138Ab3FJVJI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Jun 2013 17:09:08 -0400
Received: from mail-qc0-f170.google.com ([209.85.216.170]:52093 "EHLO
	mail-qc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752419Ab3FJVJH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jun 2013 17:09:07 -0400
Received: by mail-qc0-f170.google.com with SMTP id s1so1211016qcw.15
        for <git@vger.kernel.org>; Mon, 10 Jun 2013 14:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:disposition-notification-to:date:from:reply-to
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=P5lG+VXOQ/pIVRAguUN0XOCWAFRIXe3yV1JaNGyy35I=;
        b=LMWjcOVO6XpQ6ME+IBsBOf+/cTz5Us4y/8dVtEXmR3eJiQ4wyX/906wb61fgUEB5sy
         IkYVps4fsT/8gxMLRc3YAnzVay2FnmqYToDxTpttXxzqF/F4ZRvOO5P/sTWPApAr+Vtx
         +JUcmkLQ2BpwIJLP4+sJMOw2a05E9Rn8m0qSqciT/BNM9OYqz5Cm0vgw2pLfxJvtK6sm
         7rHgpjleOyFcrPGdxObZTtOEQRHemQy85p13DojqFqFgOECx7AbG9fWY5xtZjLjU595Y
         B9qY5gylsKoa9JGc69/azAjJNC1jfTSPeGHo7+dOu3LNG5eOBn+akX5ktO5nsKWQrsMr
         589w==
X-Received: by 10.224.179.148 with SMTP id bq20mr15418225qab.30.1370898546233;
        Mon, 10 Jun 2013 14:09:06 -0700 (PDT)
Received: from [10.0.1.131] (50-88-155-14.res.bhn.net. [50.88.155.14])
        by mx.google.com with ESMTPSA id j9sm15886125qas.3.2013.06.10.14.09.04
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 10 Jun 2013 14:09:05 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.12) Gecko/20130116 Icedove/10.0.12
In-Reply-To: <CALkWK0n5fVZ7t-5aAO6AXM5DpxqYfL_QLxkD48edK65rGsrX_g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227382>

On 06/10/2013 04:56 PM, Ramkumar Ramachandra wrote:
> A Large Angry SCM wrote:
>>> It is absolutely imperative to keep all our contributors productive,
>>> and maximize output.
>>
>>
>> Why?
>>
>> A useful "product" with a maintainable code base are what seems to be more
>> important to a successful open source effort.
>
> Doesn't a successful open source effort (with a good review process,
> which we already have) imply a maintainable product with lots of
> users?  What am I missing, and what change do you propose?
>

It's not about keeping all of the contributers productive or maximizing 
output. It's about the result being useful.
