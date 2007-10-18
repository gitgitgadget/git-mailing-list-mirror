From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: On Tabs and Spaces
Date: Thu, 18 Oct 2007 00:31:54 -0400
Message-ID: <200710180031.54819.dmitry.torokhov@gmail.com>
References: <634393B0-734A-4884-93E3-42F7D3CB157F@mit.edu> <47168E70.4070305@op5.se> <ejftl3c2.fsf@blue.sea.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jari Aalto <jari.aalto@cante.net>
X-From: git-owner@vger.kernel.org Thu Oct 18 06:32:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IiN3o-0006dC-C4
	for gcvg-git-2@gmane.org; Thu, 18 Oct 2007 06:32:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752705AbXJREcG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2007 00:32:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752254AbXJREcD
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Oct 2007 00:32:03 -0400
Received: from py-out-1112.google.com ([64.233.166.182]:50053 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752218AbXJREcA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2007 00:32:00 -0400
Received: by py-out-1112.google.com with SMTP id u77so92187pyb
        for <git@vger.kernel.org>; Wed, 17 Oct 2007 21:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=nPNz8UzggOtxV+MipCQGSWS4q/Zvmdrf8+593HSHn3I=;
        b=ROWbpLodMKLFIp/0fazGH1DPD5pmB6gBqhJIT0thNXrVheKi7r/mSK5SNIE8+0KPcsgImpmpTBvgRCcaTfY3AbTpbYYpzKxgX6fUli93Il65aIlY4ikK64PgpK7Q8FUb/2O4IQwy4bbPoN2e2bDsBSDM+CAiSrdGv7p/7TiOyNs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Mu+M0vunjApfZvJotrq7ED7M+G762qB8sSKV+Ogk13bex6Q3DJiPR+9aOAKofamu4JOHYwFsk1QbE0H5wSs+KNGSUZr6gnlHT8Gzd/xOfPswrE7eKlhsLPfLf590PvDxaib4XebxI1gF3wkIuNKeEF+/WsyT+NfytTYtYWPq58Y=
Received: by 10.35.12.10 with SMTP id p10mr146374pyi.1192681919108;
        Wed, 17 Oct 2007 21:31:59 -0700 (PDT)
Received: from mailhub.coreip.homeip.net ( [74.142.80.143])
        by mx.google.com with ESMTPS id n80sm551948pyh.2007.10.17.21.31.56
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 17 Oct 2007 21:31:57 -0700 (PDT)
Received: from anvil.corenet.prv (anvil.corenet.prv [192.168.45.170])
	by mailhub.coreip.homeip.net (Postfix) with ESMTP id 4989F526C18;
	Thu, 18 Oct 2007 00:31:55 -0400 (EDT)
Received: by anvil.corenet.prv (Postfix, from userid 500)
	id 0437954EAC3; Thu, 18 Oct 2007 00:31:54 -0400 (EDT)
User-Agent: KMail/1.9.7
In-Reply-To: <ejftl3c2.fsf@blue.sea.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61463>

On Wednesday 17 October 2007, Jari Aalto wrote:
> - Any editor will display the text written in "all spaces"
>   100 % the same. Regradless of any viewer or editor used.
> 
> But the same is not true with text that uses tabs (because you
> really can't know what options the editor is preset / user set /
> regarding the treatment of tabs).
> 
> The score is 1 - 0 for "all spaces" in this contest.
> 

How about this - I like tabs because when you removing it you
need to hit Backspace just once and don't have to strain your
eyes figuring out "Did I delete enough? Does it line up now?"

-- 
Dmitry
