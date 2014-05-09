From: Tim Henigan <tim.henigan@gmail.com>
Subject: Re: [PATCH v1 06/25] contrib: remove 'diffall'
Date: Fri, 9 May 2014 13:16:52 -0700
Message-ID: <CAFouetiq59=g+1kdU-id_J-vjtJAF=3pp_FOw3+bZgmQ4sXV_Q@mail.gmail.com>
References: <1399597116-1851-1-git-send-email-felipe.contreras@gmail.com>
	<1399597116-1851-7-git-send-email-felipe.contreras@gmail.com>
	<CAFouetj4A+z2xzciGAbsQ8th8CNwYMd5QTapar4TXRLzGdAqeQ@mail.gmail.com>
	<20140509185035.GL9218@google.com>
	<CAFouethK=VKYzTOW7dDi7tmOHaGtNp_xHxk3MSf+n1QNuXbEdQ@mail.gmail.com>
	<20140509201246.GM9218@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 09 22:16:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WirE1-0006t4-Vq
	for gcvg-git-2@plane.gmane.org; Fri, 09 May 2014 22:16:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756972AbaEIUQy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 May 2014 16:16:54 -0400
Received: from mail-ve0-f177.google.com ([209.85.128.177]:47978 "EHLO
	mail-ve0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756765AbaEIUQx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 May 2014 16:16:53 -0400
Received: by mail-ve0-f177.google.com with SMTP id db11so5806609veb.8
        for <git@vger.kernel.org>; Fri, 09 May 2014 13:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=sj1CsLrrNx+Ohdq+gJ+k9OHzo20G+OtBOBOH53EtJxE=;
        b=luzgwEOrl7WeHTGo/ficLSDarZpbzE8x/4t3idcIm1X0/pYho2p9xGohSVHjZT/CBz
         c2OAyVa2yyzihq3dL/wSBHMV4/MkEcXx5LzTUMIcrrk/FK8VW+EoZemOmRwYr8VAh7fD
         7gCTM0ecAEhKYtT9H7uznJShCnQ52AYlSu7pqGH/wY+UTQdqAIcAPjB+Hu7byZSiPg6G
         1AagSpJUrpYy8XpOLCyYuq3Sn2kP7fAbcGSnhXVO/fXxJnIbJ5VoOPbpQjVPCaEkk6/f
         bAi08ZsZBWRlaQ2ezPzb3+K3pORBkUsyE7/ZqasOKi/mpstSX7gYUxoQS2h1kfqcZjNm
         oMJg==
X-Received: by 10.58.74.201 with SMTP id w9mr1903817vev.56.1399666612925; Fri,
 09 May 2014 13:16:52 -0700 (PDT)
Received: by 10.220.95.207 with HTTP; Fri, 9 May 2014 13:16:52 -0700 (PDT)
In-Reply-To: <20140509201246.GM9218@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248638>

Hi Jonathan,

On Fri, May 9, 2014 at 1:12 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Hi,
>
> Tim Henigan wrote:
>
>> However, I like the idea of simply removing the directory from contrib
>> and pointing to 'difftool --dir-diff' in the release notes.
>
> Thanks.  I believe Junio uses commit messages as reference when
> writing release notes so hopefully this should be enough to make that
> happen.

The updated commit message looks good to me.  Thanks.

-Tim
