From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCH] Popup menu
Date: Sun, 22 Feb 2009 14:00:50 +0100
Message-ID: <cb7bb73a0902220500x51aa4345hee7e6805989a065b@mail.gmail.com>
References: <1235302820-32526-1-git-send-email-giuseppe.bilotta@gmail.com>
	 <94a0d4530902220426p3fae124cl2210fbfc04968033@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jonas Fonseca <jonas.fonseca@gmail.com>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 22 14:02:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbDyP-0007T8-8Y
	for gcvg-git-2@gmane.org; Sun, 22 Feb 2009 14:02:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751629AbZBVNAx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Feb 2009 08:00:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751158AbZBVNAw
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Feb 2009 08:00:52 -0500
Received: from ey-out-2122.google.com ([74.125.78.24]:27483 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751247AbZBVNAw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Feb 2009 08:00:52 -0500
Received: by ey-out-2122.google.com with SMTP id 25so332374eya.37
        for <git@vger.kernel.org>; Sun, 22 Feb 2009 05:00:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=+wyywleH/A7ypqjFgDBkPQGhaH0LGhYocATn5VVLsk0=;
        b=F7+qNfxsEoTo0SGcGc+D0o0wDosyshw+qXg9WgNYKGGHxhYavoQSbVwNUD57KTb1f9
         h3Fx21FSER25iNwst1m0x4dJPAbYGTxvDBI7yP0WrlkP4LC3wNryHTfU4W+VZSACZV7O
         ntPp5v0ml0w4+ip4i06KBtwbWo26pBzkgMU78=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=e6/CF8iTrE0WQETVU3fCokwuHW+1Vt/E1CPBjkU+UWhAGmqfkthFtBbjuUK9LNIWo8
         M3AU/8PaYfJjkOV6NVjWSg0zXsHbCu7/z89Dzw0bviba2sUSTmx8yHWofj0PTuelF1aO
         pB24HvHzihPpIaKvAIPaM07zSpCKSHI2xFsQY=
Received: by 10.210.120.7 with SMTP id s7mr2491401ebc.187.1235307650425; Sun, 
	22 Feb 2009 05:00:50 -0800 (PST)
In-Reply-To: <94a0d4530902220426p3fae124cl2210fbfc04968033@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111004>

On Sun, Feb 22, 2009 at 1:26 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> On Sun, Feb 22, 2009 at 1:40 PM, Giuseppe Bilotta
> <giuseppe.bilotta@gmail.com> wrote:
>> Make the menu into a popup window that complements the status prompt.
>
> Popup menu of what? Please prefix "tig: " in your subject.

Awfully sorry, I forgot the "[tig " part in the subject prefix, I'd
better set it in the git config. Thanks for the reminder.


-- 
Giuseppe "Oblomov" Bilotta
