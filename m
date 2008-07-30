From: "Sverre Rabbelier" <alturin@gmail.com>
Subject: Re: [ANNOUNCE] GitStats development finished (WRT GSoC)
Date: Wed, 30 Jul 2008 11:12:47 +0200
Message-ID: <bd6139dc0807300212r67ccb849i542e490c8cd00953@mail.gmail.com>
References: <bd6139dc0807291511v2d70d549r3682291eb10a745d@mail.gmail.com>
	 <7vabfz97fl.fsf@gitster.siamese.dyndns.org>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailinglist" <git@vger.kernel.org>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Jakub Narebski" <jnareb@gmail.com>,
	"David Symonds" <dsymonds@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	"Sam Vilain" <sam@vilain.net>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 30 11:14:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KO7kl-0008Ai-0Q
	for gcvg-git-2@gmane.org; Wed, 30 Jul 2008 11:13:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753702AbYG3JMt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2008 05:12:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753130AbYG3JMt
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jul 2008 05:12:49 -0400
Received: from wf-out-1314.google.com ([209.85.200.168]:40315 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752020AbYG3JMs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2008 05:12:48 -0400
Received: by wf-out-1314.google.com with SMTP id 27so407362wfd.4
        for <git@vger.kernel.org>; Wed, 30 Jul 2008 02:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=S+UObDDlZWDTWAlTbX2kzEGD5Gd0vjCKGSP7x7RAxdA=;
        b=FVqNQnDZOUDaLHtNUkPYYXpxJ7z8sa7J2+KSn6NWv5EQf7MYheA74DUTtcDSZ6f2ng
         C3DFvEiZAQTi+pHVBSuRDlRmsEUpz1gCBXRWizpALClsdGM9MpGzMe1lNTMCPeUYo6k+
         vhzR18BxR8H6jbI5BGsnvprp8Tt+0nTGkWsio=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:references;
        b=XnYnjV+fI071/7Ug7tUqfz3VtZg/Dm0WqgApaePB1C6MLAGZga1Ql6bsCJ/KlSOkyg
         clZT5zj4GWTCz866Jw5t4U9m00Awm3Qz60kl8JvDfUQsfgLYjQWuqDFNfON58PYRxr04
         2CH6CCbkm/k4+1nDxEUCxz/XKtoVysmOhj5+Q=
Received: by 10.142.207.8 with SMTP id e8mr2554149wfg.281.1217409167773;
        Wed, 30 Jul 2008 02:12:47 -0700 (PDT)
Received: by 10.142.104.10 with HTTP; Wed, 30 Jul 2008 02:12:47 -0700 (PDT)
In-Reply-To: <7vabfz97fl.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90760>

On Wed, Jul 30, 2008 at 09:07, Junio C Hamano <gitster@pobox.com> wrote:
> Can't wait running this, especially in conjunction with the "author" stuff
> ;-)

Hehe, don't expect too much of it yet though (the 'bug' module that
is), there won't be any "99% of the bugs come from Dscho" yet :P.

-- 
Cheers,

Sverre Rabbelier
