X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-1.5 required=3.0 tests=BAYES_00,DKIM_ADSP_NXDOMAIN,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RCVD_NUMERIC_HELO,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
From: Jerome Lovy <t2a2e9z8ncbs9qg@brefemail.com>
Subject: Re: [PATCH] "master" should be treated no differently from any other
   branch
Date: Thu, 14 Dec 2006 17:20:04 +0100
Message-ID: <458179B4.7020408@brefemail.com>
References: <200612141519.44294.andyparkins@gmail.com> <Pine.LNX.4.63.0612141627090.3635@wbgn013.biozentrum.uni-wuerzburg.de>
Reply-To: t2a2e9z8ncbs9qg@brefemail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Thu, 14 Dec 2006 16:18:48 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 20
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 212.11.48.246
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
In-Reply-To: <Pine.LNX.4.63.0612141627090.3635@wbgn013.biozentrum.uni-wuerzburg.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34361>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GutID-0005aM-Cz for gcvg-git@gmane.org; Thu, 14 Dec
 2006 17:18:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932854AbWLNQSc convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006 11:18:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932855AbWLNQSc
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 11:18:32 -0500
Received: from main.gmane.org ([80.91.229.2]:49918 "EHLO ciao.gmane.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S932854AbWLNQSb
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec 2006 11:18:31 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GutHu-0001LT-Sg for git@vger.kernel.org; Thu, 14 Dec 2006 17:18:29 +0100
Received: from 212.11.48.246 ([212.11.48.246]) by main.gmane.org with esmtp
 (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Thu, 14
 Dec 2006 17:18:26 +0100
Received: from t2a2e9z8ncbs9qg by 212.11.48.246 with local (Gmexim 0.1
 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Thu, 14 Dec 2006
 17:18:26 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Hi,

Johannes Schindelin wrote:
> On Thu, 14 Dec 2006, Andy Parkins wrote:
>=20
>> "master" shouldn't get special treatment; making different log messa=
ges=20
>> based on the name of the branch is bad form.  What if a user likes=20
>> "my/master" or "my/head" as their master branch?
>=20
> I do not agree. There is usually a principal branch, where you collec=
t the=20
> topics, and you do want to treat that special. As for the name: bette=
r=20
> have a convention here than configurability. You would not want "git"=
 to=20
> be called "guitar" for some users, just because they happen to like t=
hat=20
> name more, either, right?

because I like the pattern framework described in the book "Software=20
Configuration Management Patterns", I like to use "mainline" instead of=
=20
"master", for example.

J=E9r=F4me
