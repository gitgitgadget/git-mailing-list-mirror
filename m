From: Vitor Antunes <vitor.hda@gmail.com>
Subject: Re: [PATCH v3 1/5] git-p4: Allow setting rename/copy detection threshold
Date: Mon, 22 Aug 2011 13:44:54 +0100
Message-ID: <CAOpHH-X7D4SCCTuqu_DxY4F6N3kY0x7pb_qS+5D6+1bwGK_60w@mail.gmail.com>
References: <1314001989-29017-1-git-send-email-vitor.hda@gmail.com>
 <1314001989-29017-2-git-send-email-vitor.hda@gmail.com> <20110822121837.GA3761@arf.padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Tor Arvid Lund <torarvid@gmail.com>
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Mon Aug 22 14:45:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QvTsg-0006ZU-Nv
	for gcvg-git-2@lo.gmane.org; Mon, 22 Aug 2011 14:45:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752262Ab1HVMp0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 22 Aug 2011 08:45:26 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:43839 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752091Ab1HVMpY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Aug 2011 08:45:24 -0400
Received: by gxk21 with SMTP id 21so3523201gxk.19
        for <git@vger.kernel.org>; Mon, 22 Aug 2011 05:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=utdaJNKyjtePPAE5WbEbxNLcZoLIW2K1zsybB4qpXvo=;
        b=m9YGtcUmaJtqo1ZnqD5/32yt+Hwu5wroQ/tc8W2pLq7W51lQENEIzQkOy/+t0LFXzU
         W/ePO1/Eb99188twA2wMZ7h4RibNz9UdNLLfqcl7wXJo+R8Dhwpk56uw6vglxwDEp/B6
         l2fiQ+GlCvaLr7DiJvfNA/h/NQidESSYBijSA=
Received: by 10.42.150.66 with SMTP id z2mr2457138icv.383.1314017124232; Mon,
 22 Aug 2011 05:45:24 -0700 (PDT)
Received: by 10.231.30.205 with HTTP; Mon, 22 Aug 2011 05:44:54 -0700 (PDT)
In-Reply-To: <20110822121837.GA3761@arf.padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179861>

On Mon, Aug 22, 2011 at 1:18 PM, Pete Wyckoff <pw@padd.com> wrote:
> This series looks great. =A0Thanks for fixing the --bool issue and
> the tests.

Thank *you* for the help and suggestions.
--=20
Vitor Antunes
