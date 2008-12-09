From: "Sverre Rabbelier" <alturin@gmail.com>
Subject: Re: is gitosis secure?
Date: Tue, 9 Dec 2008 10:38:50 +0100
Message-ID: <bd6139dc0812090138l5dbaf20bsd1cde00f52bb94e5@mail.gmail.com>
References: <200812090956.48613.thomas@koch.ro>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>, dabe@ymc.ch
To: "Thomas Koch" <thomas@koch.ro>
X-From: git-owner@vger.kernel.org Tue Dec 09 10:40:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L9z4b-00089c-Ql
	for gcvg-git-2@gmane.org; Tue, 09 Dec 2008 10:40:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751736AbYLIJiw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Dec 2008 04:38:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752219AbYLIJiw
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Dec 2008 04:38:52 -0500
Received: from yw-out-2324.google.com ([74.125.46.30]:25853 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751566AbYLIJiv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Dec 2008 04:38:51 -0500
Received: by yw-out-2324.google.com with SMTP id 9so641226ywe.1
        for <git@vger.kernel.org>; Tue, 09 Dec 2008 01:38:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=rxONE+9XLIC9pznMlY3z3PnrRfUg/fVk1wvluYID58g=;
        b=k/RC+wSOog/rsHljjF0BJ4YEpX/vlxljaZprJNUungB9qLIzfbfnFdYAmNawismmFM
         CjJk26Zm8jLg/Iwe/Q57IBWx29tMZCrPCgpXU7/m4HAmgKINkjbd2F3ttrbC5IfZMKU0
         WykV7VYTp+3xWvNfBgvs67nEqTmmJrvAP7hMI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:references;
        b=eNzypV4tWyyr6unvMEN/bu/BkuNqoQvaQzB4K7uLJjXykYmX7MUKvu7syueFxoIBWA
         mckGdhbXvfEtsXALaesvOjJviCAJXSPxyp0iXc9rVnx9cu0oVnJIhqzU5WOVD9L50in4
         AMWQt7veyuFsWECuixp4NvJFepwcd55YjqvQU=
Received: by 10.151.108.13 with SMTP id k13mr9705236ybm.238.1228815530367;
        Tue, 09 Dec 2008 01:38:50 -0800 (PST)
Received: by 10.151.108.18 with HTTP; Tue, 9 Dec 2008 01:38:50 -0800 (PST)
In-Reply-To: <200812090956.48613.thomas@koch.ro>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102612>

On Tue, Dec 9, 2008 at 09:56, Thomas Koch <thomas@koch.ro> wrote:
> Our admin would prefer to not open SSH at all outside our LAN, but
> developers would need to have write access also outside the office.

What safer to connect to the LAN than with SSH? What _would_ your
system admin be happy with using?

-- 
Cheers,

Sverre Rabbelier
