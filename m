From: Vitor Antunes <vitor.hda@gmail.com>
Subject: Re: [PATCHv2 0/4] git-p4: small fixes to branches and labels; tests
Date: Thu, 1 Dec 2011 21:59:29 +0000
Message-ID: <CAOpHH-XL5OGpnihEgqnXqUUFsMxXn2wSdLadegnC1epg44vs8A@mail.gmail.com>
References: <1322643817-13051-1-git-send-email-luke@diamand.org>
 <loom.20111130T155409-599@post.gmane.org> <4ED6809A.9020703@diamand.org>
 <20111130225813.GA11544@arf.padd.com> <CAOpHH-U3PF0v7EPqnO0FNxNKh+uF1GH=cnA_MA09SaQTxo0cDA@mail.gmail.com>
 <20111201040259.GA22189@arf.padd.com> <CAOpHH-UMdLpCPx1+D2dtQJs+=t1+0U2srKfTwBi-TEF4F7EDyw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Luke Diamand <luke@diamand.org>
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Thu Dec 01 23:00:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RWEfq-00031a-E2
	for gcvg-git-2@lo.gmane.org; Thu, 01 Dec 2011 23:00:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754343Ab1LAWAD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 1 Dec 2011 17:00:03 -0500
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:47207 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754144Ab1LAWAB convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 1 Dec 2011 17:00:01 -0500
Received: by lagw12 with SMTP id w12so841450lag.19
        for <git@vger.kernel.org>; Thu, 01 Dec 2011 14:00:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=+teg2493Txp2lu7ItnOxocfbe13nqLRuwtLojTFir0I=;
        b=bqGTRNBARw8kaEl0tCGcBGUaw16Y/OtUSjG5f1UW1wWMvlXiCNJ4xQ0I7wHXIQRxoG
         X8HHbwLw9nb9a1AFJtpeiVpnYdKpmPQiIKxwBisoxIrE8j/5enDFjGHuLGaIKwj//SUE
         bXSTeK3HGuZS15pgCuOyDRS5dE/HTgAPibL7A=
Received: by 10.152.103.132 with SMTP id fw4mr2847249lab.37.1322776800313;
 Thu, 01 Dec 2011 14:00:00 -0800 (PST)
Received: by 10.152.5.105 with HTTP; Thu, 1 Dec 2011 13:59:29 -0800 (PST)
In-Reply-To: <CAOpHH-UMdLpCPx1+D2dtQJs+=t1+0U2srKfTwBi-TEF4F7EDyw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186195>

On Dec 1, 2011 4:03 AM, "Pete Wyckoff" <pw@padd.com> wrote:
> I see your point. =A0P4 labels are the only way that they support
> tagging, apparently. =A0I'm okay with leaving label support in
> git-p4. =A0And it will be nice if Luke makes it behave a bit
> better. =A0But doing heroics to emulate cross-commit tags feels
> like a lot of work, and the wrong direction.

Agreed. Lets keep it simple.

--=20
Vitor Antunes
