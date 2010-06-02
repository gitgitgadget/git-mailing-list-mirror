From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 1/5] t/t5800: skip if python version is older than 2.5
Date: Wed, 2 Jun 2010 18:38:07 +0200
Message-ID: <AANLkTilT3erRySKImnUxON1vOnNJyVOLjn4t4F4rCQTi@mail.gmail.com>
References: <Wt_M4qptcPdpY0Q3jqUbfIk6yMCN9Ja5RCtRUsADK5OJGrz7R_Cq1oGpeQoN7A9uCvw38jm63Jo@cipher.nrlssc.navy.mil> 
	<Wt_M4qptcPdpY0Q3jqUbfCU_HpY9NEjqs9eujZFD2rsUj5HRo__oQm7EUCxzXu38mC0y-ilUA14@cipher.nrlssc.navy.mil> 
	<AANLkTinQrdJeTxoZ207kvv5R_3qUj5ocGgAlC22SQyOg@mail.gmail.com> 
	<meC0HM60UnAajjHuTX-y8qZO2Unmc9VZYk1ZAHZ86LlKSy4E9Rfc_w@cipher.nrlssc.navy.mil> 
	<ECbjGSsMA4ZIaSU1sgkRHSvxlxbZZwsEBdVFoyCTLeEuJTxU_EI8Xw@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, gitster@pobox.com
To: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Wed Jun 02 18:38:50 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJqxu-0000PS-1Z
	for gcvg-git-2@lo.gmane.org; Wed, 02 Jun 2010 18:38:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932796Ab0FBQi3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jun 2010 12:38:29 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:52123 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932729Ab0FBQi2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jun 2010 12:38:28 -0400
Received: by gye5 with SMTP id 5so2300383gye.19
        for <git@vger.kernel.org>; Wed, 02 Jun 2010 09:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=YxepxvZxvePdSGau9iMKP2pAQYLC3g1q2UN4wh0NU4A=;
        b=GlisD4SOhJ4257Ag5mdWXSnWLnmMH3M+aZUCtLbDcpAFjyD27UowobIeA5Yuega85U
         pI+9cHJHe+MMc5bz7nD+uM1STOalRghXewHGcLaY53Df3ubY92p/xYWjRU3jLWXbxwAH
         hxCmKrCLjxWYv6OtVgxYJKVGpgmbl4dYBapO8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=McOQ5qd7bQ2ngU0YB0wJmhDzyyWp2w+UtTAFE04ekgCqoTsck0a5AFLdnquxx9xnVB
         I6iFl1xA6A8DK+DHkvJAbOPonfaHkP4ANtXcO3063bXLSIZKmAagYfA84GtbKONGYJZA
         zpsgBvGo+/y7LO2rbtktAV2J33dsgXyVt6kG8=
Received: by 10.150.93.14 with SMTP id q14mr7743936ybb.307.1275496707319; Wed, 
	02 Jun 2010 09:38:27 -0700 (PDT)
Received: by 10.151.61.12 with HTTP; Wed, 2 Jun 2010 09:38:07 -0700 (PDT)
In-Reply-To: <ECbjGSsMA4ZIaSU1sgkRHSvxlxbZZwsEBdVFoyCTLeEuJTxU_EI8Xw@cipher.nrlssc.navy.mil>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148265>

Heya,

On Wed, Jun 2, 2010 at 17:15, Brandon Casey
<brandon.casey.ctr@nrlssc.navy.mil> wrote:
> Here's the patch:

That was not meant as a concrete suggestion :P. I meant that I did not
know what package is available in 2.4.x, so substitute it on the ??'s
:P. The ? does not mean anything.

-- 
Cheers,

Sverre Rabbelier
