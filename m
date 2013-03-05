From: Jiang Xin <worldhello.net@gmail.com>
Subject: Fwd: Git 1.8.2 l10n round 4
Date: Tue, 5 Mar 2013 12:57:14 +0800
Message-ID: <CANYiYbE4xu3+p91wVngNv_CjJ24Nbo3DOXtKrJouDTdS3vyCaA@mail.gmail.com>
References: <CANYiYbG81JvKFrWash0ec=UBqDWXfW9ZGGsG31WECp5aiWDfxQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Mar 05 05:57:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UCjwc-0002ej-SC
	for gcvg-git-2@plane.gmane.org; Tue, 05 Mar 2013 05:57:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933063Ab3CEE5Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Mar 2013 23:57:16 -0500
Received: from mail-wg0-f50.google.com ([74.125.82.50]:44305 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932930Ab3CEE5P (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Mar 2013 23:57:15 -0500
Received: by mail-wg0-f50.google.com with SMTP id es5so5125142wgb.29
        for <git@vger.kernel.org>; Mon, 04 Mar 2013 20:57:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:content-type;
        bh=newe+POVq1DAqAf2b1RoZzeF93pFUDCKlFcsoFtTPHs=;
        b=pkecCyRMtdcuCJGqN56C9qVd3chMDxv1HMhDOYfGtJyIvUQVbQWK1RM2Epg5jGo/ET
         p9sIpvWT5ONMDSsLaJj/Vws2cHITchXiNx5upqADD8WOhUOP07qVzuvKa46yee86TiFd
         3m3ay66MFHNDUIeQ42r3e3ospPIakXDi788FypqfvN57ilPI88gCN5nDfOFrH8MHCKgp
         7v5nQmC9NSTUUlmX7p1oGXr3fZIaCuXNnuILUkZ910RXdUVIN2DXNNgJCewZM0sSBmxx
         kIDu6jMFGgnh7mOWrRiyvod0/8Y6xgDfNZTlD3QutT/L4kb0J3xnFgWnn2KcnPXWY3il
         cKkA==
X-Received: by 10.180.8.4 with SMTP id n4mr15863620wia.13.1362459434281; Mon,
 04 Mar 2013 20:57:14 -0800 (PST)
Received: by 10.194.80.40 with HTTP; Mon, 4 Mar 2013 20:57:14 -0800 (PST)
In-Reply-To: <CANYiYbG81JvKFrWash0ec=UBqDWXfW9ZGGsG31WECp5aiWDfxQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217427>

Hi,

Leaders of Git language teams please note that a new "git.pot" is
generated from v1.8.2-rc2-4-g77995 in the master branch. See
commit:

    l10n: git.pot: v1.8.2 round 4 (1 changed)

    Generate po/git.pot from v1.8.2-rc2-4-g77995 for git v1.8.2
    l10n round 4.

    Signed-off-by: Jiang Xin <worldhello.net@gmail.com>

This update is for the l10n of the upcoming git 1.8.2. You can get it
from the usual place:

    https://github.com/git-l10n/git-po/

--
Jiang Xin
