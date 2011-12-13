From: "Frans Klaver" <fransklaver@gmail.com>
Subject: Re: [PATCH v2] Update documentation for stripspace
Date: Tue, 13 Dec 2011 07:28:36 +0100
Message-ID: <op.v6ez9yyi0aolir@keputer>
References: <7vy5ui5h0k.fsf@alter.siamese.dyndns.org>
 <1323728909-7847-1-git-send-email-conrad.irwin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>,
	"Conrad Irwin" <conrad.irwin@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 13 07:28:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RaLrA-0000uV-Bd
	for gcvg-git-2@lo.gmane.org; Tue, 13 Dec 2011 07:28:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751521Ab1LMG2l convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 13 Dec 2011 01:28:41 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:53325 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750731Ab1LMG2k convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Dec 2011 01:28:40 -0500
Received: by eaaj10 with SMTP id j10so973368eaa.19
        for <git@vger.kernel.org>; Mon, 12 Dec 2011 22:28:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=content-type:to:cc:subject:references:date:mime-version
         :content-transfer-encoding:from:message-id:in-reply-to:user-agent;
        bh=4OzGSs/jP7Vc5cW7Gp/GoFycdiMm6LpJ5GzlDv/9E9Q=;
        b=dcEQYfYrT53N0XyVS1LpBIJ5c59nXLAJK1TtuJz37VmUm/oLcdVD1i9yX69r2hVKX7
         szxTemoV3sB1aAuR/+qZvPwkYuEra2AjJYN4m3ezB0GPVu5Lmnp9P7RL8UFXzyEdOBG4
         Y7AGjWM2q7Sv6XKjyaeddIolhqQBkfX9i0Ctc=
Received: by 10.14.35.80 with SMTP id t56mr3741830eea.19.1323757719410;
        Mon, 12 Dec 2011 22:28:39 -0800 (PST)
Received: from keputer (82-136-253-149.ip.telfort.nl. [82.136.253.149])
        by mx.google.com with ESMTPS id q28sm85166083eea.6.2011.12.12.22.28.38
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 12 Dec 2011 22:28:38 -0800 (PST)
In-Reply-To: <1323728909-7847-1-git-send-email-conrad.irwin@gmail.com>
User-Agent: Opera Mail/12.00 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187006>

On Mon, 12 Dec 2011 23:28:29 +0100, Conrad Irwin <conrad.irwin@gmail.co=
m> =20
wrote:

>> an incomplete line, i.e. "ensures the output does not end with an
>> incomplete line by adding '\n' at the end if needed".
>
> Hmm, I'm not sure that's the best way of describing it =E2=80=94 I've=
 gone with:
> "add a missing '\n' to the last line if necessary.".

In most editors/IDE's I know and that support this, this is called "ens=
ure =20
new-line at end of file". I find this wording clearer than the above tw=
o =20
options.

Cheers,
=46rans
