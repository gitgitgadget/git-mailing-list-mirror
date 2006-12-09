X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <sbejar@gmail.com>
Subject: Re: [PATCH] Add branch.*.merge warning and documentation update
Date: Sat, 9 Dec 2006 17:14:12 +0100
Message-ID: <8aa486160612090814n4c4ee827o905674618c97eeea@mail.gmail.com>
References: <cc723f590612052051r62111c4cgfd7ee893cb00f84a@mail.gmail.com>
	 <200612090017.44105.Josef.Weidendorfer@gmx.de>
	 <7vu006ez1i.fsf@assigned-by-dhcp.cox.net>
	 <200612090228.26722.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Sat, 9 Dec 2006 16:14:27 +0000 (UTC)
Cc: "Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=m46yqOswcSn/yB4Hhmw3DKHxwFVxKvSU7JjsZFv3FemhHdOWzBOXhnhTswuQY99UJdBs4RyDuDGCpSllr/YXtUUvEJ79mgz6XUf15n6dVco0+IOTibFJCxOgWl5g3B3f5JFDr7zKQDTqzfNUee7P/SVffHLgIkwp60K+aGkJWQY=
In-Reply-To: <200612090228.26722.Josef.Weidendorfer@gmx.de>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33818>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gt4qB-00075b-A8 for gcvg-git@gmane.org; Sat, 09 Dec
 2006 17:14:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S937055AbWLIQOO convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Sat, 9 Dec 2006 11:14:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937056AbWLIQOO
 (ORCPT <rfc822;git-outgoing>); Sat, 9 Dec 2006 11:14:14 -0500
Received: from wx-out-0506.google.com ([66.249.82.235]:22923 "EHLO
 wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S937055AbWLIQON convert rfc822-to-8bit (ORCPT
 <rfc822;git@vger.kernel.org>); Sat, 9 Dec 2006 11:14:13 -0500
Received: by wx-out-0506.google.com with SMTP id h27so1095457wxd for
 <git@vger.kernel.org>; Sat, 09 Dec 2006 08:14:12 -0800 (PST)
Received: by 10.70.61.1 with SMTP id j1mr8378370wxa.1165680852518; Sat, 09
 Dec 2006 08:14:12 -0800 (PST)
Received: by 10.70.45.1 with HTTP; Sat, 9 Dec 2006 08:14:12 -0800 (PST)
To: "Josef Weidendorfer" <Josef.Weidendorfer@gmx.de>
Sender: git-owner@vger.kernel.org

On 12/9/06, Josef Weidendorfer <Josef.Weidendorfer@gmx.de> wrote:
> This patch clarifies the meaning of the branch.*.merge option.
> Previously, if branch.*.merge was specified but did not match any
> ref, the message "No changes." was not really helpful regarding
> the misconfiguration. This patch adds a warning for this.
>
> Signed-off-by: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>

Acked-by: Santi B=E9jar <sbejar@gmail.com>

And thanks for the patch.

