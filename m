From: Lynn Lin <lynn.xin.lin@gmail.com>
Subject: Re: clearcase migration to git
Date: Thu, 2 Dec 2010 10:03:45 +0800
Message-ID: <AANLkTinZ4V=My15tTZN8hBakT3bJYQW-9iL1JuGbVboy@mail.gmail.com>
References: <AANLkTintgZKHW+9aeqN=JPG34X6wqeCNOC0jpdFaWmrN@mail.gmail.com>
	<AANLkTimX3jovT=a2hvJvWR741t+C4x1B0WthSXcqb66t@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 02 03:03:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNyWT-0005hk-C4
	for gcvg-git-2@lo.gmane.org; Thu, 02 Dec 2010 03:03:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756612Ab0LBCDr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Dec 2010 21:03:47 -0500
Received: from mail-qy0-f181.google.com ([209.85.216.181]:58785 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756606Ab0LBCDq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Dec 2010 21:03:46 -0500
Received: by qyk12 with SMTP id 12so9753381qyk.19
        for <git@vger.kernel.org>; Wed, 01 Dec 2010 18:03:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=TujhpjBwfUpg4/qlZAa0tR2C+iGkupVVNdjRxEXaKRM=;
        b=WIS0rdt3u/lSWWnoXo9Qdfq68RlPVLF713xg2JF951eTBBAQ89pMUEZ0egNeNBR9/3
         NEhhavZxmflKESZTEcgIst0MIESi94iPP2Kwt9lbL5NjWeJkFEo46MD5JOFTsRw4ULZB
         HFVddgcS9LiIo5/UzHBlcgDzcwHzw3hbrVOY8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=j1NPReiHSM9ilFVhYfsxCJnxkvw2dDfm6gu7AKA08FFrNeXi8fNDY7tp/3bWv9m8qa
         cF1RH7mbpsukbIkxA/qRL+Xye6wuW/VX6nT5nEQfdQnuo80r3vimmj/5bVz+cUTbPCJZ
         xw52eUE7Rlwa6fxjMR+4KFjMzIkukFPDJ34i0=
Received: by 10.229.184.198 with SMTP id cl6mr7942561qcb.222.1291255425596;
 Wed, 01 Dec 2010 18:03:45 -0800 (PST)
Received: by 10.229.216.199 with HTTP; Wed, 1 Dec 2010 18:03:45 -0800 (PST)
In-Reply-To: <AANLkTimX3jovT=a2hvJvWR741t+C4x1B0WthSXcqb66t@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162662>

On Thu, Dec 2, 2010 at 9:23 AM, Martin von Zweigbergk
<martin.von.zweigbergk@gmail.com> wrote:
> On Wed, Dec 1, 2010 at 8:14 PM, Lynn Lin <lynn.xin.lin@gmail.com> wro=
te:
>> All,
>> =A0 =A0is there any tools recommended that migrate clearcase to git?
>
> Base or UCM?
  Base
>
> /Martin
>
