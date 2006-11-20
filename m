X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: Some tips for doing a CVS importer
Date: Tue, 21 Nov 2006 12:03:01 +1300
Message-ID: <46a038f90611201503m6a63ec8ct347026c635190108@mail.gmail.com>
References: <9e4733910611201349s4d08b984g772c64982f148bfa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 20 Nov 2006 23:03:12 +0000 (UTC)
Cc: "Git Mailing List" <git@vger.kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pMM0/DDEAl8lqnDC/sJ1OXvfHoDQPLckMbtEpej2PLq6pXzckJVKyEPBcbGUizR2FNMh0Io9vFd2JUpaX56ZcsANq3e9cXp0f8cOXdtFwqX31Iy9p6KIPUbqbPIjK4mS/tq5KWjlkAmhjZZFfeP2hBhiGAcGrz3dp9En5itmKqs=
In-Reply-To: <9e4733910611201349s4d08b984g772c64982f148bfa@mail.gmail.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31953>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GmIAO-0004kI-B3 for gcvg-git@gmane.org; Tue, 21 Nov
 2006 00:03:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S966879AbWKTXDF (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 20 Nov 2006
 18:03:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966882AbWKTXDF
 (ORCPT <rfc822;git-outgoing>); Mon, 20 Nov 2006 18:03:05 -0500
Received: from nf-out-0910.google.com ([64.233.182.186]:40306 "EHLO
 nf-out-0910.google.com") by vger.kernel.org with ESMTP id S966879AbWKTXDC
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 20 Nov 2006 18:03:02 -0500
Received: by nf-out-0910.google.com with SMTP id o25so2500659nfa for
 <git@vger.kernel.org>; Mon, 20 Nov 2006 15:03:01 -0800 (PST)
Received: by 10.49.91.6 with SMTP id t6mr32153nfl.1164063781122; Mon, 20 Nov
 2006 15:03:01 -0800 (PST)
Received: by 10.49.60.1 with HTTP; Mon, 20 Nov 2006 15:03:01 -0800 (PST)
To: "Jon Smirl" <jonsmirl@gmail.com>
Sender: git-owner@vger.kernel.org

On 11/21/06, Jon Smirl <jonsmirl@gmail.com> wrote:
> I have tried all of the available CVS importers. None of them are
> without problems. If anyone is interested in writing one for git here
> are some ideas on how to structure it.

Hi Jon,

I gather this means that the cvs2svn track hasn't been as productive
as expected. Any remaining/unsolvable issues with it? I have been
chronically busy on my e-learning projects, but don't discard coming
back to this when I have some time.

cheers,



