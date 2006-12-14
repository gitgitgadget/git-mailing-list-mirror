X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Arkadiusz Miskiewicz <arekm@maven.pl>
Subject: Re: svn versus git
Date: Thu, 14 Dec 2006 20:00:54 +0100
Organization: SelfOrganizing
Message-ID: <200612142000.54409.arekm@maven.pl>
References: <200612132200.41420.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Thu, 14 Dec 2006 19:18:18 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Greylist: delayed 990 seconds by postgrey-1.27 at vger.kernel.org; Thu, 14 Dec 2006 14:17:38 EST
User-Agent: KMail/1.9.5
In-Reply-To: <200612132200.41420.andyparkins@gmail.com>
Content-Disposition: inline
X-Authenticated-Id: arekm
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34385>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Guw5m-0000Zf-Oi for gcvg-git@gmane.org; Thu, 14 Dec
 2006 20:18:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751969AbWLNTRj convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006 14:17:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751970AbWLNTRj
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 14:17:39 -0500
Received: from outgoing1.smtp.agnat.pl ([193.239.44.83]:47159 "EHLO
 outgoing1.smtp.agnat.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1751969AbWLNTRj convert rfc822-to-8bit (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 14 Dec 2006 14:17:39 -0500
Received: from [83.11.30.20] (helo=[192.168.0.64]) by tekla.agnat.pl with
 esmtpsa (TLSv1:DHE-RSA-AES256-SHA:256) (Exim 4.63) (envelope-from
 <arekm@maven.pl>) id 1GuvpC-0003Cu-Sz; Thu, 14 Dec 2006 20:00:59 +0100
To: Andy Parkins <andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org

On Wednesday 13 December 2006 23:00, Andy Parkins wrote:
> Hello,
>
> With all the discussion about user interface difficulties, I started =
to
> write a comparison with subversion document.  (I was assuming that pe=
ople
> find subversion easy).  As much as I love git, I was expecting to fin=
d that
> it's hard to use interface would have subversion as the clear winner.=
  I
> was hoping that would then give guidance as to what could be fixed in=
 git.
>
> I was surprised, therefore, to find that in each case I was finding t=
hat
> git was the winner.

subversion is a winner when it comes to options handling (especially --=
help)=20
and better (error) messages. That's one of reason why people find it ea=
sy.

ps. I'm blind or there is no documentation about what utilities are nee=
ded to=20
get git fully working? (like sed, coreutils, grep, rcs package (merge t=
ool=20
afaik needed)...).=20

--=20
Arkadiusz Mi=B6kiewicz        PLD/Linux Team
