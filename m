From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v3 0/7] New remote-bzr remote helper
Date: Sat, 24 Nov 2012 11:21:04 +0100
Message-ID: <CAMP44s2F9C4cr6v===M3AWHieaiUk1adigcU8txpZPL0wN81Ow@mail.gmail.com>
References: <1352643598-8500-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 24 11:21:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TcCrV-0000RL-Qz
	for gcvg-git-2@plane.gmane.org; Sat, 24 Nov 2012 11:21:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750987Ab2KXKVI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Nov 2012 05:21:08 -0500
Received: from mail-vb0-f46.google.com ([209.85.212.46]:50276 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750946Ab2KXKVG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Nov 2012 05:21:06 -0500
Received: by mail-vb0-f46.google.com with SMTP id ff1so4283015vbb.19
        for <git@vger.kernel.org>; Sat, 24 Nov 2012 02:21:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=T2b7rUmb8sOi3FUzqCAmEF63zSsiGctlX0wRd4cNFjA=;
        b=cDgGuP3+HZHNjwoSuAt4p+61AIdUhyLV5Z86JHvkfqDweLd2zp+zq6zQ+40/hU6jSy
         2AAxBw28cXWH4qvqYyyoEe3g1oj6jXydsrZRWHtGIHivg/NdnfztXVcyeUdksf2gp/3H
         Nm90r722VRl5VUMR2gPULr3CiSvJ0XSLTrdhVTwic6Y4lixz1gHs+bCN0TUYpTHIRab/
         VfrXWDFMCgO2fcAVsPc6pNZsYWtZKvDrqfRswjz/EfX6ObHBaJMZdpK5oHAtUnReNlpg
         PRAKIF++ZISlzMNwrxPDn0XiE5+12RQu5cIWvHVOHm2IuJSYhvKJEFFJVajD7wi5+b95
         WR6w==
Received: by 10.52.75.105 with SMTP id b9mr8618923vdw.28.1353752465055; Sat,
 24 Nov 2012 02:21:05 -0800 (PST)
Received: by 10.58.34.51 with HTTP; Sat, 24 Nov 2012 02:21:04 -0800 (PST)
In-Reply-To: <1352643598-8500-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210318>

On Sun, Nov 11, 2012 at 3:19 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> This is a re-roll of the previous series to add support to fetch and push
> special modes, and refactor some related code.

It seems this one got forgotten, I only see v2 in pu.

Cheers.

-- 
Felipe Contreras
