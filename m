From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v4] Improve remote-helpers documentation
Date: Mon, 22 Mar 2010 22:27:06 +0530
Message-ID: <f3271551003220957q5db34547t69b425f708628dff@mail.gmail.com>
References: <f3271551003220604v4c9fbb5ep3b7c69300567a275@mail.gmail.com> 
	<alpine.LNX.2.00.1003221143250.14365@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git Mailing List <git@vger.kernel.org>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Mon Mar 22 17:57:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NtkwW-00039W-OP
	for gcvg-git-2@lo.gmane.org; Mon, 22 Mar 2010 17:57:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755312Ab0CVQ52 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Mar 2010 12:57:28 -0400
Received: from mail-yw0-f172.google.com ([209.85.211.172]:40140 "EHLO
	mail-yw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755283Ab0CVQ51 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Mar 2010 12:57:27 -0400
Received: by ywh2 with SMTP id 2so1894796ywh.33
        for <git@vger.kernel.org>; Mon, 22 Mar 2010 09:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=wJtBwW4ejv2t1Cidv9wkcV/cwWywvgKTdxrHttiuux4=;
        b=sLPHyKGycJ7M+ACEr66tTxJJ5xzuTAhtTWzga2MKWFInGlsMtw2WJmheZhk+0N4ar5
         pyrwPNzzo1WUJkexVHhwto7XbCvZ6tHDvvQiTM6Pp8Kefi0KaI3/fM6+HRbgUylRs6cA
         N/2xTCEBPxWFmwRjmsSVyTODSq3IAAIoRxhuI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=v7jiMn1X0FISujyjR2u0vIirNlTPZiJgRxkwnupgddLBEZYaA5MEYe13XJQWofBi4C
         OgXrOg81WIvnnwjppDYMXWijDxz/lGttDnHGvoBjTAUt2JrB5kgtHmSJvIwqPEv1HRSA
         vj90/AZOIVvRYTrNSs3DkYM6z5J6Eny7f/xsA=
Received: by 10.91.164.5 with SMTP id r5mr4556224ago.95.1269277046402; Mon, 22 
	Mar 2010 09:57:26 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.1003221143250.14365@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142948>

> But I'm fine with whichever format is most helpful for someone trying to
> read the document (that is, to you).

Your format is indeed more elegant- I've incorporated this change in v5. Thanks.

-- Ram
