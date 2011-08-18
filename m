From: Ray Chen <rchen@cs.umd.edu>
Subject: Re: [RFC/PATCH v3] git-svn: New flag to emulate empty directories
Date: Thu, 18 Aug 2011 03:55:47 -0400
Message-ID: <CANtO-4O7quAgLHZaPa_LrwPdwO1GXXHHVQpjxYcmVr96jGhx3Q@mail.gmail.com>
References: <1311201446-26895-1-git-send-email-rchen@cs.umd.edu> <20110817203934.GC24581@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Thu Aug 18 09:56:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QtxSY-0001Va-K9
	for gcvg-git-2@lo.gmane.org; Thu, 18 Aug 2011 09:56:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755264Ab1HRH4K convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Aug 2011 03:56:10 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:53104 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755263Ab1HRH4H convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Aug 2011 03:56:07 -0400
Received: by ywf7 with SMTP id 7so1301508ywf.19
        for <git@vger.kernel.org>; Thu, 18 Aug 2011 00:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=Kzkw6EbYZC2jKgVK95f6J8PEAV206JsIAFYujRBzerA=;
        b=ThTGpeQE9MIYKQzK0U0amhl3RfzdYI0SLRuCjwuEVlWKkoUk/L7+8J1AG2k39EawGo
         OA+4pMZob1HwhDNngfpH7uTO4GvwpkWb53T6wHxEm0UZ1Sv+Uj6Vz6AHDLJie0svOtT1
         XvI13PJjbKRVTlNzoYBbqvKcZ33IBGUk11k2c=
Received: by 10.236.181.166 with SMTP id l26mr1961743yhm.89.1313654167071;
 Thu, 18 Aug 2011 00:56:07 -0700 (PDT)
Received: by 10.236.145.65 with HTTP; Thu, 18 Aug 2011 00:55:47 -0700 (PDT)
In-Reply-To: <20110817203934.GC24581@dcvr.yhbt.net>
X-Google-Sender-Auth: W-ayIVMJMR5oWH8tXfIc1v5hJjI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179578>

On Wed, Aug 17, 2011 at 4:39 PM, Eric Wong <normalperson@yhbt.net> wrot=
e:
>
> We haven't heard anything in a few weeks. =A0Everything looks accepta=
ble
> to me. =A0I'm inclined to just accept it since it's unlikely to break
> existing functionality.
>

Great.  Thanks for keeping this patch in mind, Eric.

Let me know if there's anything else I should do,
- Ray
