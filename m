From: "Rajkumar S" <rajkumars+git@gmail.com>
Subject: Re: Tracking a branch using StGIT
Date: Fri, 15 Sep 2006 17:04:24 +0530
Message-ID: <64de5c8b0609150434r2162042dmcf6b587466f6ab9d@mail.gmail.com>
References: <64de5c8b0609150120h3aeee6dcv976da13134396654@mail.gmail.com>
	 <b0943d9e0609150342y6105d8d1o61abb1934da9f51b@mail.gmail.com>
	 <8aa486160609150417s288d6540tc8ee6aa83bbf67b4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 15 13:34:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GOBxl-0003Rq-39
	for gcvg-git@gmane.org; Fri, 15 Sep 2006 13:34:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751284AbWIOLe0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Sep 2006 07:34:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751286AbWIOLe0
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Sep 2006 07:34:26 -0400
Received: from py-out-1112.google.com ([64.233.166.176]:35019 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751284AbWIOLeZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Sep 2006 07:34:25 -0400
Received: by py-out-1112.google.com with SMTP id n25so4040798pyg
        for <git@vger.kernel.org>; Fri, 15 Sep 2006 04:34:25 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=L9E6sz42jNKNzt/wEEhbr51mF84D7ML6YtlgGhjKBs9rIB/an5xhxmI/E5JQDr+sf+I+kWkErYyKMYcTpIVlnCKDm2wyeja+e46lhsSqrlcZK6YovzmBCmJLiIPft2oHijWwvfKK+qZqEi5wPSc1bAmKr+gIJpWVCg+K7TD09L8=
Received: by 10.65.219.14 with SMTP id w14mr8589894qbq;
        Fri, 15 Sep 2006 04:34:24 -0700 (PDT)
Received: by 10.65.248.1 with HTTP; Fri, 15 Sep 2006 04:34:24 -0700 (PDT)
To: Santi <sbejar@gmail.com>
In-Reply-To: <8aa486160609150417s288d6540tc8ee6aa83bbf67b4@mail.gmail.com>
Content-Disposition: inline
X-Google-Sender-Auth: 46a6cc9f696960a2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27079>

On 9/15/06, Santi <sbejar@gmail.com> wrote:
> No. But the it merge the first pull line in .git/remotes/origin into
> the current branch. So he only has to put the RELENG_1 line the first,
> as:
>
> URL: /usr/local/pfSense/upstream/pfSense/.git
> Pull: refs/heads/RELENG_1:refs/heads/RELENG_1

Thanks a lot, that should solve this.

raj
