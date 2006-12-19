X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Vincent Legoll" <vincent.legoll@gmail.com>
Subject: Re: git-diff & cg-diff behavior difference
Date: Tue, 19 Dec 2006 11:43:39 +0100
Message-ID: <4727185d0612190243j150bae79m954d096ebb89a9bc@mail.gmail.com>
References: <4727185d0612170911l52fab839x694399db729fd62d@mail.gmail.com>
	 <46a038f90612181249y5ee69a8al28e97a22dca80c81@mail.gmail.com>
	 <4727185d0612190233w26188a56t50ad49d2de58b88b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 19 Dec 2006 10:44:28 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=q4yickMLcMxOhCA9MMi8qetMFmDc5ZU6HDofPbYFejdJrUIsRSj9Q4HGeefaLHVMzRRRO8/+7t6uGkR5w+fh/aJvrHiTunBEArjBG8jaCiEODrIurMTxfs5kr6qPZwQfnrAmuHn5NJQNMbFWGkzYJ/dMDTLvXQEMF+LZVewMvzI=
In-Reply-To: <4727185d0612190233w26188a56t50ad49d2de58b88b@mail.gmail.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34819>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GwcSL-0004HR-0y for gcvg-git@gmane.org; Tue, 19 Dec
 2006 11:44:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932774AbWLSKnn (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 19 Dec 2006
 05:43:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932775AbWLSKnm
 (ORCPT <rfc822;git-outgoing>); Tue, 19 Dec 2006 05:43:42 -0500
Received: from nf-out-0910.google.com ([64.233.182.184]:65051 "EHLO
 nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S932774AbWLSKnl (ORCPT <rfc822;git@vger.kernel.org>); Tue, 19 Dec
 2006 05:43:41 -0500
Received: by nf-out-0910.google.com with SMTP id o25so2242921nfa for
 <git@vger.kernel.org>; Tue, 19 Dec 2006 02:43:40 -0800 (PST)
Received: by 10.82.120.14 with SMTP id s14mr884152buc.1166525020019; Tue, 19
 Dec 2006 02:43:40 -0800 (PST)
Received: by 10.78.177.13 with HTTP; Tue, 19 Dec 2006 02:43:39 -0800 (PST)
To: "Martin Langhoff" <martin.langhoff@gmail.com>
Sender: git-owner@vger.kernel.org

On 12/19/06, Vincent Legoll <vincent.legoll@gmail.com> wrote:
> That's what I wanted to know: if it was a deliberate behavior, a bug on
> my side, or on git's...

Errr, I meant cogito's...

-- 
