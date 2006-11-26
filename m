X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>
Subject: Re: [PATCH] Documentation: clarify tutorial pull/merge discussion
Date: Sun, 26 Nov 2006 19:05:00 +0100
Message-ID: <4d8e3fd30611261005w20279017la17a7a6639481b3e@mail.gmail.com>
References: <20061123203950.5d47421f@paolo-desktop>
	 <20061124161144.GA19708@fieldses.org>
	 <20061126034502.GA3782@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sun, 26 Nov 2006 18:05:23 +0000 (UTC)
Cc: "Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hyMKLWR79aCWaY/ATK2UI8Nhh+rn2us+8NV/C2Ppp8lDwYDeCdhP8TfTtLjSnqM5jR+KnifqfqiKecMdvA6z4GqI7i6hFyaF9V2hBx6qhRuFu0KmmI819O26uRe0jPAGwOKLqynEMspxy8YKwS8Id8FGX8+fUhRbX2HpXRBgegg=
In-Reply-To: <20061126034502.GA3782@fieldses.org>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32361>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GoONO-0000wj-HH for gcvg-git@gmane.org; Sun, 26 Nov
 2006 19:05:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S935396AbWKZSFG (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 26 Nov 2006
 13:05:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935464AbWKZSFF
 (ORCPT <rfc822;git-outgoing>); Sun, 26 Nov 2006 13:05:05 -0500
Received: from nf-out-0910.google.com ([64.233.182.187]:16094 "EHLO
 nf-out-0910.google.com") by vger.kernel.org with ESMTP id S935396AbWKZSFC
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 26 Nov 2006 13:05:02 -0500
Received: by nf-out-0910.google.com with SMTP id o25so1936705nfa for
 <git@vger.kernel.org>; Sun, 26 Nov 2006 10:05:00 -0800 (PST)
Received: by 10.78.58.11 with SMTP id g11mr12418698hua.1164564300596; Sun, 26
 Nov 2006 10:05:00 -0800 (PST)
Received: by 10.78.165.3 with HTTP; Sun, 26 Nov 2006 10:05:00 -0800 (PST)
To: "J. Bruce Fields" <bfields@fieldses.org>
Sender: git-owner@vger.kernel.org

On 11/26/06, J. Bruce Fields <bfields@fieldses.org> wrote:
> Attempt to clarify somewhat the difference between pull and merge,
> and give a little more details on the pull syntax.
>
> I'm still not happy with this section: the explanation of the origin
> branch isn't great, but maybe that should be left alone pending the
> use-separate-remotes change; and we need to explain how to set up a
> public repository and push to it.
>
> Signed-off-by: J. Bruce Fields <bfields@citi.umich.edu>

A lot more clear in my opinion.

Acked-by: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>

Ciao,
-- 
Paolo
http://docs.google.com/View?docid=dhbdhs7d_4hsxqc8
http://www.linkedin.com/pub/0/132/9a3

