From: Howard Miller <howard@e-learndesign.co.uk>
Subject: Re: gitosis user on Windows
Date: Tue, 12 Jan 2010 10:45:36 +0000
Message-ID: <26ae428a1001120245q51c922ccr9787581c2886222c@mail.gmail.com>
References: <26ae428a1001120142j36619d62xcf3ffee3539a03b7@mail.gmail.com>
	 <alpine.DEB.2.00.1001121121380.30408@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Peter Krefting <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Tue Jan 12 11:45:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUeFv-0006cG-OW
	for gcvg-git-2@lo.gmane.org; Tue, 12 Jan 2010 11:45:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754121Ab0ALKpo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 Jan 2010 05:45:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754066Ab0ALKpn
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jan 2010 05:45:43 -0500
Received: from mail-ew0-f209.google.com ([209.85.219.209]:49799 "EHLO
	mail-ew0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754029Ab0ALKpm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Jan 2010 05:45:42 -0500
Received: by ewy1 with SMTP id 1so4426102ewy.28
        for <git@vger.kernel.org>; Tue, 12 Jan 2010 02:45:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=3NK9HsZABsfwQS2OrAEpuH3/Q+LGB9pdAqEF1Xrw/Gc=;
        b=SoTDrsjNoUzLt2drLM35eDEwdgj+HrdRo7iI5U6q4kvcvT4ZyPaDFpCKyCNRn+8WUG
         vKyHfehTP1nKt8Y6sebucSCpFmjtIiYvQlLb3eH0dBRe5Jn9P14TOXQ1yyMKRf5WCKwI
         PfEZGcmKU8OAfSlznL/NRHJT0T+64sJ9kzfeI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=CPYzld+CAw58cDJIPwyx1xkAdFycj5md8Tn96eYto4beAjv2FC8pHwjuiI7I/jAUL5
         4/QVHTxfGCf0FISWcb6HT1DRqHr+1bENi0fU7TQBOM0cfeZGRVMrFDeVAm6QxId/OJ8h
         NdAYGjNViEjw43R2JOF3dKp+J0ic0vYSf7cB4=
Received: by 10.213.103.197 with SMTP id l5mr4764332ebo.11.1263293136553; Tue, 
	12 Jan 2010 02:45:36 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1001121121380.30408@ds9.cixit.se>
X-Google-Sender-Auth: 66522ffa11584c62
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136713>

> Howard Miller:
>
>> I have been using gitosis for a while with much success. I now have =
a user
>> on Windows (XP) wanting to access the repositories. I obviously need=
 a key
>> =A0from him but asking just elicited a blank look.
>
> =A0From Git Gui, use Help -> Show SSH Key. If that shows up blank, pr=
ess the
> "Generate Key" button and follow the instructions.

Thanks, but... he's using Tortoise Git (I've just found out). I guess
he's looking for something similar there?
