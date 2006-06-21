From: "Jakub Narebski" <jnareb@gmail.com>
Subject: Re: [PATCH 1/3] gitweb: whitespace cleanup
Date: Wed, 21 Jun 2006 10:05:10 +0200
Message-ID: <8fe92b430606210105r29a1691bk1c605de715af091c@mail.gmail.com>
References: <11508760843417-git-send-email-jnareb@gmail.com>
	 <11508760842024-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Jun 21 10:05:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FsxiL-0002jp-Qh
	for gcvg-git@gmane.org; Wed, 21 Jun 2006 10:05:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751275AbWFUIFO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Jun 2006 04:05:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751289AbWFUIFO
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jun 2006 04:05:14 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:14777 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751275AbWFUIFM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jun 2006 04:05:12 -0400
Received: by nf-out-0910.google.com with SMTP id o60so59511nfa
        for <git@vger.kernel.org>; Wed, 21 Jun 2006 01:05:10 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IV1k+v3Hw0PuzSU+AnoXWdtPHU6r0HsNzRgT4Y/U1OBOjf//WW52u8vIpt1v0KId2b8Dr2Vi/HUg6KabaYAbCs06ictMbTJrfOkcaATF+oIyqqaGPrYathwnTSIDQ0/XtnkKAlvKas2jVrfCxvM3PlEdPX97J7saNjHzZZF0PaQ=
Received: by 10.49.64.2 with SMTP id r2mr307174nfk;
        Wed, 21 Jun 2006 01:05:10 -0700 (PDT)
Received: by 10.48.12.18 with HTTP; Wed, 21 Jun 2006 01:05:10 -0700 (PDT)
To: git@vger.kernel.org
In-Reply-To: <11508760842024-git-send-email-jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22237>

Jakub Narebski <jnareb@gmail.com> wrote:
>
> Signed-off-by: Jakub Narebski <jnareb.com>

It should be of course

 Signed-off-by: Jakub Narebski <jnareb@gmail.com>


Somehow cover letter got lost, and patches did not appear on mailing
list archives.
If the mail will not appear in few hours, I'll resend it to mailing list only.

Probably because git-send-email should ensure LC_ALL=C for Date:
header generation...
-- 
Jakub Narebski
ShadeHawk on #git
