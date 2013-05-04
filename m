From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 0/2] remote-bzr: couple of fixes
Date: Fri, 3 May 2013 19:32:16 -0500
Message-ID: <CAMP44s02Mf2PqGg=zJe-szKdUYb1tg5ryU8ykWcMPTSEB7qsgw@mail.gmail.com>
References: <1367626957-13858-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 04 02:32:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UYQOw-00081f-0E
	for gcvg-git-2@plane.gmane.org; Sat, 04 May 2013 02:32:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762502Ab3EDAcS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 May 2013 20:32:18 -0400
Received: from mail-lb0-f176.google.com ([209.85.217.176]:55939 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755932Ab3EDAcR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 May 2013 20:32:17 -0400
Received: by mail-lb0-f176.google.com with SMTP id v20so1986459lbc.7
        for <git@vger.kernel.org>; Fri, 03 May 2013 17:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=cR5Zt1aIsr40FehkJy9PLPj8DylSzY0pYHVnmztOFfI=;
        b=veBtW6cxB6hkkOQoNk4aMSu7KjewiSqI9eLoedKRdLR5+Gk6tFvmXFVVVLrr6NpWDP
         EFG0ZflzWgSTNSBrWH3sbPTPMDvL8EOH7enJC1mXb7FqGJMaGZgwFCMDbiDhjh9X0AwL
         UbP2DWA3Qz3C+sZe48oh4helQqQaj1NfCcXJSK7XyoduHTeeB9i52qwk5Pp53Ot7aC+Q
         JHNXXZW9rDh1+VxtY2Pmg5IHd7zVs3W5uNfr67xLbL/O5vxZqxFgGfkdDujq8rjTgeg6
         N6X/DW0TQwcSiWnQ9E8hCDJoJ6YlwgkVLQ9mIB5S3n/Gg6FRiZMReX3Aa6mvm7qVul5P
         m33w==
X-Received: by 10.112.145.72 with SMTP id ss8mr4315363lbb.12.1367627536280;
 Fri, 03 May 2013 17:32:16 -0700 (PDT)
Received: by 10.114.184.3 with HTTP; Fri, 3 May 2013 17:32:16 -0700 (PDT)
In-Reply-To: <1367626957-13858-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223344>

On Fri, May 3, 2013 at 7:22 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> A few fixes to be applied on top of the massive changes already queued. Nothing major.
>
> Felipe Contreras (2):
>   remote-bzr: convert all unicode keys to str
>   remote-bzr: avoid bad refs

There's a problem with the second patch. Re-rolling.

-- 
Felipe Contreras
