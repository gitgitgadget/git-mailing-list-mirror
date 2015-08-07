From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH 0/10] Port branch.c to ref-filter.
Date: Fri, 7 Aug 2015 20:52:26 +0530
Message-ID: <CAOLa=ZTtLKNJ7zgXF7wqs9_18JAjnau=kmAutwKQMkqviH43kQ@mail.gmail.com>
References: <CAOLa=ZSnn19DR_Y5MqUXHed0g5MSk_dwFc48dk8GoPYvL5DQ=Q@mail.gmail.com>
 <CAOLa=ZSR=7mvOG+RPSJ_xxr3k644WOiqirTrNMo-=jcXbtM3yw@mail.gmail.com> <xmqq614t2zbe.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 07 17:23:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZNjUC-0003mv-4b
	for gcvg-git-2@plane.gmane.org; Fri, 07 Aug 2015 17:23:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932263AbbHGPW6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Aug 2015 11:22:58 -0400
Received: from mail-ob0-f178.google.com ([209.85.214.178]:35191 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932243AbbHGPW4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Aug 2015 11:22:56 -0400
Received: by obbop1 with SMTP id op1so81413053obb.2
        for <git@vger.kernel.org>; Fri, 07 Aug 2015 08:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=AdlanF9yD7ko2MLKafAg6UP203C+SVY6941WnVVyhwI=;
        b=fJ1WtUgt9m0gVXpYWG8d6NSLvc0+OCAj0arl+GmAV9QxJvXsL1DbTGeX6DDUg/7S09
         aNHOQ5kENADb1kuf150qr/+Ypq6WMYOU727EowD97yVKOg1D2UnmgrTArHu5q67BjzPQ
         iDXQRnLpijx5AUg0p/TUaoOdNWdxw14gBKb5MxUwnQFyZYoKGDnj1zIWKC/6YTDICq9t
         wCDc4cW3vo+cvbXZaJFvjPjeedr3nePrO/rt2O2otWrMk93jOIfxe1iaSFymJuZitiRI
         oK/tTiBo8id9CPLEHlxtcL2P8drX9cI3lkpMkqvrA6io0nPdIwfvSm3rTJc18EdK8+Sj
         BP7A==
X-Received: by 10.60.177.195 with SMTP id cs3mr7076401oec.37.1438960975708;
 Fri, 07 Aug 2015 08:22:55 -0700 (PDT)
Received: by 10.182.26.73 with HTTP; Fri, 7 Aug 2015 08:22:26 -0700 (PDT)
In-Reply-To: <xmqq614t2zbe.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275468>

On Thu, Aug 6, 2015 at 3:05 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> There are nine patches in the series. Have put "0/10" by mistake.
>
> FYI, format-patch has --cover-letter option.

Thanks! I need to check out a lot of options :)



-- 
Regards,
Karthik Nayak
