From: Tony Luck <tony.luck@gmail.com>
Subject: Re: Linus kernel tree corrupt?
Date: Fri, 8 Jul 2005 10:06:09 -0700
Message-ID: <12c511ca05070810065db87043@mail.gmail.com>
References: <9e473391050708085756bd463e@mail.gmail.com>
Reply-To: Tony Luck <tony.luck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jul 08 19:06:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DqwIo-0005sx-R7
	for gcvg-git@gmane.org; Fri, 08 Jul 2005 19:06:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262720AbVGHRGK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Jul 2005 13:06:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262718AbVGHRGK
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jul 2005 13:06:10 -0400
Received: from zproxy.gmail.com ([64.233.162.197]:52629 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262720AbVGHRGK convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Fri, 8 Jul 2005 13:06:10 -0400
Received: by zproxy.gmail.com with SMTP id 12so214971nzp
        for <git@vger.kernel.org>; Fri, 08 Jul 2005 10:06:09 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=EffDlRoSGCL5OOFFP8Be6uy8VdKFCUCYC2HRFp7JdL+QHxXx7UTNQXN70XCJctWric5dt4R+F0mJcp6b4cplLdFSVhBFLPTUVsDNYNZnjeuqGIy47ZL7WV0RMca7QbVQjOmBhK1OPXD7UHYhyudORaFwtrKVm2Cw/wbcJK/nsds=
Received: by 10.36.4.14 with SMTP id 14mr727563nzd;
        Fri, 08 Jul 2005 10:06:09 -0700 (PDT)
Received: by 10.36.59.4 with HTTP; Fri, 8 Jul 2005 10:06:09 -0700 (PDT)
To: Jon Smirl <jonsmirl@gmail.com>
In-Reply-To: <9e473391050708085756bd463e@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On 7/8/05, Jon Smirl <jonsmirl@gmail.com> wrote:
> What happened in this session...

Linus has "packed" his GIT tree ... and now http-pull doesn't work. 
rsync still does (provided
you have a new enough cogito).

-Tony
