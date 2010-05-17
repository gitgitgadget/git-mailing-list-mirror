From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH 1/2] Added "Z" as an alias for the timezone "UTC"
Date: Mon, 17 May 2010 16:32:57 -0400
Message-ID: <AANLkTiljyxwlwGK4i-9QKGSW4T_-v2HtFkcu16a7Ndam@mail.gmail.com>
References: <1274123231-18482-1-git-send-email-marcus@mc.pp.se>
	 <1274123231-18482-2-git-send-email-marcus@mc.pp.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Marcus Comstedt <marcus@mc.pp.se>
X-From: git-owner@vger.kernel.org Mon May 17 22:40:08 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OE76c-0006PL-Gc
	for gcvg-git-2@lo.gmane.org; Mon, 17 May 2010 22:40:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755664Ab0EQUj5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 May 2010 16:39:57 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:42828 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754852Ab0EQUj4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 May 2010 16:39:56 -0400
X-Greylist: delayed 418 seconds by postgrey-1.27 at vger.kernel.org; Mon, 17 May 2010 16:39:56 EDT
Received: by iwn6 with SMTP id 6so696267iwn.19
        for <git@vger.kernel.org>; Mon, 17 May 2010 13:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=rQHT+Z3l4XtNQOTPEipV6uRm68eY5WxDYz0vRAWVR/0=;
        b=vW1NVXmafpzCg99vlzadG3b7BB4gcKGerrKe9fVUtFWLMsQSf/LEXVvhHD3gyOX7Xb
         h/6LEoQY5HXGBmsrj5v1LYSPb932x047MfL3v1O0QAzDNSJG5c/A/6tg6QFGG2mRYC8I
         LXTw8FutanaSY1oSVc4c1fNDajIbENufvW1Ng=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=qrHz6Kbd60Ha+z7wt/+1PbPArHPCiybFlfxnSGJKbtQdYg/vXEH3nyaXF5i7XbP1ax
         rEn9HeE2J99HBc0szwxSC4R0pMe9lmqhcE/va65KFayghCNxBHjrtwMTNSg7QHCPD+8m
         T66qFmifCiEBEQ+IYPz9Ll/Bp/saxnvzXBhtU=
Received: by 10.231.176.75 with SMTP id bd11mr845214ibb.22.1274128377737; Mon, 
	17 May 2010 13:32:57 -0700 (PDT)
Received: by 10.231.34.8 with HTTP; Mon, 17 May 2010 13:32:57 -0700 (PDT)
In-Reply-To: <1274123231-18482-2-git-send-email-marcus@mc.pp.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147258>

On Mon, May 17, 2010 at 3:07 PM, Marcus Comstedt <marcus@mc.pp.se> wrot=
e:
> The name "Z" for the UTC timezone is required to properly parse
> ISO 8601 times. =C2=A0Added it to the list of recignozed timezones.

s/Added/Add/; s/recignozed/recognized/

> Also, fixed the bug that timezone names shorter than 3 characters

s/fixed the/fix a/

j.
