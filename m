From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 1/2] fix typo in Documentation
Date: Wed, 4 Feb 2009 06:30:11 +0100
Message-ID: <bd6139dc0902032130k47551f1cle52ae286bd539e5d@mail.gmail.com>
References: <1233781241-721-1-git-send-email-guanqun.lu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Guanqun Lu <guanqun.lu@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 04 06:32:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUaMO-0006JM-Lb
	for gcvg-git-2@gmane.org; Wed, 04 Feb 2009 06:31:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750892AbZBDFaP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Feb 2009 00:30:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750782AbZBDFaO
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Feb 2009 00:30:14 -0500
Received: from fg-out-1718.google.com ([72.14.220.157]:10136 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750755AbZBDFaN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2009 00:30:13 -0500
Received: by fg-out-1718.google.com with SMTP id 16so1106609fgg.17
        for <git@vger.kernel.org>; Tue, 03 Feb 2009 21:30:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=G5YsnSEylCH27eFpvrhkMIJKLIrxnMtW752hBr4xQow=;
        b=sSOuy9soTLA9A2XLDeI4Kbty8/4+29v4G2Dm5EG4zWOAPhvUaYvaZadenhGH3yJR6z
         eKjGH2A1n/tlMG7u64dtyDjL1uTYMquCDfrHVAQY18BFWKTfeHDFj/8mWTlzeLtR4NBE
         EIadrrvpHPju4fOnyhlwCnAURNCz6zFHNM+o8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=pk0JEaEeZOSuxBpv8+PH17yoAK9/3XM2FBvH0deNQhpG+2uFhpPIsw6G/0Uv/SmW15
         KED/qDEnKCXz6hT2oYYQoMAtoPqMBCLYshmQd/N7T57aN8Jr531PnI2PmAeRP3fVRRsp
         pga9T/Ljq8A7eT7DrnMOk4bV5yd3hD7xHjlbI=
Received: by 10.86.59.18 with SMTP id h18mr1150191fga.5.1233725411321; Tue, 03 
	Feb 2009 21:30:11 -0800 (PST)
In-Reply-To: <1233781241-721-1-git-send-email-guanqun.lu@gmail.com>
X-Google-Sender-Auth: fc0e8c988e039a46
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108296>

Heya,

On Wed, Feb 4, 2009 at 22:00, Guanqun Lu <guanqun.lu@gmail.com> wrote:
> -However, it it totally safe to modify anything in the string pointed by
> +However, it is totally safe to modify anything in the string pointed by

To prevent someone else from staring at this for a minute, "it it" was
replaced by "it is".

-- 
Cheers,

Sverre Rabbelier
