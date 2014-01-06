From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 0/2] Minor convinience feature: format.defaultTo
Date: Mon, 6 Jan 2014 22:55:32 +0530
Message-ID: <CALkWK0k2ATGKtJ-93J1WL4vjSK6=hUZvciawTVHpsrwBd1ETHg@mail.gmail.com>
References: <1389028732-27760-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jan 06 18:26:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0DwQ-0004qh-25
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jan 2014 18:26:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753592AbaAFR0N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jan 2014 12:26:13 -0500
Received: from mail-ie0-f173.google.com ([209.85.223.173]:60517 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751470AbaAFR0N (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jan 2014 12:26:13 -0500
Received: by mail-ie0-f173.google.com with SMTP id to1so19004967ieb.18
        for <git@vger.kernel.org>; Mon, 06 Jan 2014 09:26:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=TI2sf9V7YrH9gVeOWQRmkJdI+Nm6QmpH5nPuoW8qmC0=;
        b=lwAE1NDD2n14zDzkz8nScNEOUukc6M5S6FfP0LD97qRUI5ohPwSDh8jiTP2RCxXzET
         oHGkr5uvNEZG3+njfLVt3xr+/BBivb9mweyFo5QvxGHAEd2fBVPQSqwzEO2Q/9U47sPH
         3v0whRFz+DJfR9Nb0Y90Fr010Umj862hfk5W+g6YOWE8drwrAG1n8BwhAEgpk/b9xHyC
         ryTxmEC92Rbd0kPj2Jnl2VmEdOQSonRiui7x41+U7w3yVdIh254nhWZeF92kxsKg9b7+
         Xgn2PMOcg/vqvWnY45qU9t7a5gg+i6zkBuALsZtRKS3LVEH4SXLM6iAn6AypVboupT1w
         fUGg==
X-Received: by 10.42.24.210 with SMTP id x18mr59813774icb.38.1389029172678;
 Mon, 06 Jan 2014 09:26:12 -0800 (PST)
Received: by 10.64.195.9 with HTTP; Mon, 6 Jan 2014 09:25:32 -0800 (PST)
In-Reply-To: <1389028732-27760-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240034>

Ramkumar Ramachandra wrote:
> Ramkumar Ramachandra (2):
>   completion: complete format.coverLetter
>   format-patch: introduce format.defaultTo

Any thoughts on checkout.defaultTo? I have a "com" alias to checkout 'master'.
