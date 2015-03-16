From: Stefan Beller <sbeller@google.com>
Subject: Re: Promoting Git developers
Date: Mon, 16 Mar 2015 10:06:36 -0700
Message-ID: <CAGZ79kbOkgA2pfsh3Av-iuHe4qRz2XWDu6Onm9QTXJRtAoABXg@mail.gmail.com>
References: <CAP8UFD1+rC0FjisSddDcyn1E_75wtBU9pEpUcQX5zNtd4zKYFQ@mail.gmail.com>
	<54FDA6B5.8050505@drmicha.warpmail.net>
	<CAP8UFD0KNbPBB_dOzw_dAj+ws190_cO8g7_jb_V33x1jxgvnqQ@mail.gmail.com>
	<xmqqk2yo22ce.fsf@gitster.dls.corp.google.com>
	<CAP8UFD37v_zOjRkUPLy-ChDs=+NetsDY7Q14-4rYA-WhnTRYyA@mail.gmail.com>
	<xmqqfv9b5krc.fsf@gitster.dls.corp.google.com>
	<CAP8UFD2ba3jQSsQrGGWM-8HTfGR+zZhmbkxiEBhSR+Ho=B0MuA@mail.gmail.com>
	<xmqqvbi1sy4h.fsf@gitster.dls.corp.google.com>
	<003001d05f71$81845160$848cf420$@nexbridge.com>
	<CAP8UFD08xoJ2H8XgfDbPfHddX9YFpFgbrY+PZ5Tphuot7JwGvw@mail.gmail.com>
	<87a8zdguxp.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Christian Couder <christian.couder@gmail.com>,
	"Randall S. Becker" <rsbecker@nexbridge.com>,
	Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Scott Chacon <schacon@gmail.com>
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Mon Mar 16 18:06:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YXYTT-0002V6-JE
	for gcvg-git-2@plane.gmane.org; Mon, 16 Mar 2015 18:06:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932454AbbCPRGi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Mar 2015 13:06:38 -0400
Received: from mail-ig0-f176.google.com ([209.85.213.176]:37762 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753775AbbCPRGh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Mar 2015 13:06:37 -0400
Received: by igcqo1 with SMTP id qo1so48283853igc.0
        for <git@vger.kernel.org>; Mon, 16 Mar 2015 10:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=aIGG4X918o1kbcL6AACIaZuy9HJt5mEE3Xy9nciNG9U=;
        b=IDbpTbPdKNUztOsgPfBdx1v8ZPb4DAR+8s5Zh2b7qB3x/lyKcl1whYOQpoJHAnXMAS
         Mif4Q+JW+PDFPvMFa7Cs2e4I2HIMElWqucvREKGIIpvhdX4gEc5mCioLNP20qd6DaO6g
         A3g+dOmnTxkqj2Jx89j0mlah99l48N7tpzfLuW1sc42DrAN619hWbF/iFhzHEZKJG0Yw
         uSl5TmHzs9By+3NN+3T+Pizo9OKmjGuk4AGhfG/GKte2ZKi7Iu5iqBIkf3+MTe/V9cGP
         vGhws24RRYEFPotVE6pHdrpEyb3JPgOjC+lc73pX/z2Wo3SCRWl3zXlh3Qyr9pTCdDZf
         XKzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=aIGG4X918o1kbcL6AACIaZuy9HJt5mEE3Xy9nciNG9U=;
        b=LtWZW4bOaB0bLCm5A/3ObsSLfCYx4yaLanlem7gI07JmXVjQOGlqonmoDSs0jIfW0X
         +tbeLayqrY/dpDtoijPRIDKLLy6/lpZZ4HtiS6hcA7Zry6kv8UNPS9ijctwC/obGFBN7
         68jETi8Gthnyo8ckR/16GYb56lhrf//jmm5BgqdZCL95HtzfptAtzEzApnpCeoI+hM2C
         bKuq16r0luLBnaM9DUU023CxeELVHClResvfzQOPigNEHIrkqDRfgxXMLZ3cUTMN+hYd
         JKPXv127gZYRqhgOnrkgIhPgDnTD3yhg/OYMPDXt36gb+hivwhbexHS6o1E1jSCmdatX
         +Btg==
X-Gm-Message-State: ALoCoQnE5ys8INEjk1Qn8ThUPD0Go93jiZ9cscfeA22P36YBz9VkRNSrRBJws+94GzFALpHWDMvn
X-Received: by 10.107.15.155 with SMTP id 27mr93476197iop.49.1426525596978;
 Mon, 16 Mar 2015 10:06:36 -0700 (PDT)
Received: by 10.107.46.31 with HTTP; Mon, 16 Mar 2015 10:06:36 -0700 (PDT)
In-Reply-To: <87a8zdguxp.fsf@fencepost.gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265576>

On Mon, Mar 16, 2015 at 2:20 AM, David Kastrup <dak@gnu.org> wrote:
>
> "Git Annotate"?
>

"Git Praise" as opposed to blame?
"Git Who" as a pun on the subcommand structure which doesn't always
follows grammar?
