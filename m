From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [PATCH 3/3] git-gui: update russian translation
Date: Wed, 19 Jan 2011 03:16:44 +0300
Message-ID: <20110119001644.GB29212@dpotapov.dyndns.org>
References: <cover.1295295897.git.raa.lkml@gmail.com>
 <1c96343bbf6fb30e7453c3df7b49ea31667e0469.1295295897.git.raa.lkml@gmail.com>
 <eeaaba6d48de958b374cb06f1b12db3b8e0550ea.1295295897.git.raa.lkml@gmail.com>
 <20110117210855.GD27029@blimp.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Pat Thoyts <patthoyts@users.sourceforge.net>,
	Serge Ziryukin <ftrvxmtrx@gmail.com>,
	Alexander Gavrilov <angavrilov@gmail.com>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 19 01:16:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PfLjK-0000bo-P6
	for gcvg-git-2@lo.gmane.org; Wed, 19 Jan 2011 01:16:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752719Ab1ASAQu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 18 Jan 2011 19:16:50 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:55210 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752153Ab1ASAQt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jan 2011 19:16:49 -0500
Received: by eye27 with SMTP id 27so147427eye.19
        for <git@vger.kernel.org>; Tue, 18 Jan 2011 16:16:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=ejh3ojDzVGJ2PcAiT7FV3cHKTIvT11pHi2b1UX4FG3E=;
        b=udtrPQi8kPAV7l893dIZVDIDwPC+vdLRsXHlU42HK2w2iroajDehVUIEVUsXqi+4ll
         63arlWp2bk5TXemhMRNjBzIl7s80K45cgF3mVWRGyidsWPJw7zL8vemFVS/lhFErq54q
         7FP7OHXtdm3yD5KQmud7Vz1nkbQt3LiDlpcpM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=FEoiGy5lmxqTZ+kSU/dIKTj4OsDDnWsrovN6nMPiPcEIMNASqcUqbfwynS4ncIAlTt
         c7XhBp6FGSUNYPxBVcL3adMvGWBuEgUXazMXBw1qpGyrrxh+yUD/4HogzNtlato9jmxG
         LB289vqrgSqw53mRkEJmMj4YtPvwVCNx+5FxI=
Received: by 10.14.37.7 with SMTP id x7mr5492860eea.48.1295396208405;
        Tue, 18 Jan 2011 16:16:48 -0800 (PST)
Received: from localhost (ppp22-69.pppoe.mtu-net.ru [81.195.22.69])
        by mx.google.com with ESMTPS id b52sm5021995eei.7.2011.01.18.16.16.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 18 Jan 2011 16:16:46 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110117210855.GD27029@blimp.localdomain>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165234>

On Mon, Jan 17, 2011 at 10:08:55PM +0100, Alex Riesen wrote:
> -#: git-gui.sh:1367
> +#: git-gui.sh:1454
>  msgid "Calling prepare-commit-msg hook..."
>  msgstr "=F7=D9=DA=CF=D7 =D0=D2=CF=C7=D2=C1=CD=CD=D9 =D0=CF=C4=C4=C5=D2=
=D6=CB=C9 =D2=C5=D0=CF=DA=C9=D4=CF=D2=C9=D1 prepare-commit-msg..."

'hook' is usually translated as '=D0=D2=CF=C7=D2=C1=CD=CD=C1 =D0=C5=D2=C5=
=C8=D7=C1=D4=C1'

Dmitry
