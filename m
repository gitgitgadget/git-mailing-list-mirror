From: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCH v7, resend] gitweb: ref markers link to named shortlogs
Date: Wed, 3 Sep 2008 01:55:25 +0200
Message-ID: <cb7bb73a0809021655t1c9c2863ub7e2771bf2ca3a83@mail.gmail.com>
References: <1220384825-19824-1-git-send-email-giuseppe.bilotta@gmail.com>
	 <200809030116.13676.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Petr Baudis" <pasky@ucw.cz>,
	"Lea Wiemann" <lewiemann@gmail.com>,
	"Junio C Hamano" <gitster@pobox.com>
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 03 01:56:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kafjd-0004oj-93
	for gcvg-git-2@gmane.org; Wed, 03 Sep 2008 01:56:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752026AbYIBXz1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Sep 2008 19:55:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751815AbYIBXz1
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Sep 2008 19:55:27 -0400
Received: from yx-out-2324.google.com ([74.125.44.30]:57178 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751199AbYIBXz0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Sep 2008 19:55:26 -0400
Received: by yx-out-2324.google.com with SMTP id 8so1491062yxm.1
        for <git@vger.kernel.org>; Tue, 02 Sep 2008 16:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=wcO2NzOK0IbV0QCUwgZhub3edzfxcddB/s7muNhV2+s=;
        b=dS+14tmx0epJkWO9anKerHUEBpY91/B+nYTnzP8/WH7FH0SLV5IVqOvQO6uWwo4UnA
         orfUbe13FzCYj48WR29RWvxnNUn6ocLhc0pV0Kw8E+KoGrn3WAjdv4xuIzNlyX6uHJb2
         ElQ+ZOTMiiakDyx63H98LQVa/VipDhm0y+KIo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=xnPEcYQ9K3r9p7jmSTrEogBS1SV6uVt/v9RtEAtmfRMw1Sdr8ZSz9z0xXwXyMmhp1b
         lnI0UTTrR6QTWpwjC02G9S13k8NWpSBtDyX6Tz+tsg2x9FwO6zvWqpOMbUDrpcGS6MJO
         LXTIG9ISASVMPeM30vnY1H15pkV18kxwZWcSc=
Received: by 10.150.121.3 with SMTP id t3mr11375966ybc.179.1220399725555;
        Tue, 02 Sep 2008 16:55:25 -0700 (PDT)
Received: by 10.150.145.2 with HTTP; Tue, 2 Sep 2008 16:55:25 -0700 (PDT)
In-Reply-To: <200809030116.13676.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94743>

On Wed, Sep 3, 2008 at 1:16 AM, Jakub Narebski <jnareb@gmail.com> wrote:
>
> for what it is worth...
>> ---
>>
>> This is a resend of v7 of the refmark patch, since it seems to
>> have falled again below the gitweb maintainers' radar, despite
>> their interest in it ;)
>
> Unfortunately there is not gitweb maintainer; nobody picked up
> the mantle (although there are a few of unofficial gitweb "gurus").

Oh, that's ok, as long as I know I can bug you and Petr I'm happy ;)
Just let me know if I become a little too insistent 8-D



-- 
Giuseppe "Oblomov" Bilotta
