From: Will Palmer <wmpalmer@gmail.com>
Subject: Re: [PATCH v2 3/3] pretty: add aliases for pretty formats
Date: Mon, 26 Apr 2010 23:11:30 +0100
Message-ID: <1272319890.5368.15.camel@walleee>
References: <1272232579-18895-1-git-send-email-wmpalmer@gmail.com>
	 <1272232579-18895-2-git-send-email-wmpalmer@gmail.com>
	 <1272232579-18895-3-git-send-email-wmpalmer@gmail.com>
	 <1272232579-18895-4-git-send-email-wmpalmer@gmail.com>
	 <20100426072516.GA30416@progeny.tock>
Reply-To: wmpalmer@gmail.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com, peff@peff.net
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 27 00:12:11 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O6WXC-0005RG-M2
	for gcvg-git-2@lo.gmane.org; Tue, 27 Apr 2010 00:12:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754883Ab0DZWLg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Apr 2010 18:11:36 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:52377 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754874Ab0DZWLf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Apr 2010 18:11:35 -0400
Received: by wyb42 with SMTP id 42so296425wyb.19
        for <git@vger.kernel.org>; Mon, 26 Apr 2010 15:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=b5/y91WjzSRYMb2PsszSFcBZOpKANoghcduOVCb3lqM=;
        b=Lk5Ap2jN5dboi4Hhu6BobWZXMKH7DmOXiWKOuQQ83WZBUT6YdQ5JB5briADb0or3L2
         dY/WwNVAFK9Mxk/ENE35KGewrobf9AGKq5X+loxrLwIvCKGSR6zRVM7X5QHpVmFf1lp8
         C8s/xy/yHiQz94nrktMaRm1ceXKf+jXvRXAms=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=bzRrF9nBfrWWp3DDql3QiWgoFHpGw/b2zIG6swe2fVJzl8P+WOb+4s44p5YkFpeNkc
         QL188YpX/LiZiC7IgNqFIVuNn6VRAwyB8WpGU2aMhQPISyYqM55E0cETzmrKseAaGujZ
         xwBu2vHaDDYTi14kLJ3Bxwxu1ev90u9crzBEI=
Received: by 10.216.166.201 with SMTP id g51mr2532463wel.40.1272319892900;
        Mon, 26 Apr 2010 15:11:32 -0700 (PDT)
Received: from [192.168.0.4] (5acc34b2.bb.sky.com [90.204.52.178])
        by mx.google.com with ESMTPS id r29sm1755832wbv.9.2010.04.26.15.11.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 26 Apr 2010 15:11:32 -0700 (PDT)
In-Reply-To: <20100426072516.GA30416@progeny.tock>
X-Mailer: Evolution 2.26.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145858>

On Mon, 2010-04-26 at 02:25 -0500, Jonathan Nieder wrote:
... a lot ...

Now that I've had a chance to fully read through this, I see that I
can't actually just go through line-by-line and respond to it off the
top of my head. I've made a note of everything, and anything which is
not directly addressed in the next version, should at least be addressed
in the cover-letter.

Thank you very much for taking time to review this

-- 
-- Will
