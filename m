From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCHv2] am: fix patch format detection for Thunderbird "Save 
	As" emails
Date: Thu, 21 Jan 2010 10:51:31 -0800
Message-ID: <780e0a6b1001211051h762003f1i9e34f493cb5fd755@mail.gmail.com>
References: <7vtyvpcf36.fsf@alter.siamese.dyndns.org> <1261172078-9174-1-git-send-email-bebarino@gmail.com> 
	<20100106073822.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Thu Jan 21 19:52:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NY28N-0002gY-Pr
	for gcvg-git-2@lo.gmane.org; Thu, 21 Jan 2010 19:52:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753445Ab0AUSvx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jan 2010 13:51:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753256Ab0AUSvw
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jan 2010 13:51:52 -0500
Received: from mail-pw0-f42.google.com ([209.85.160.42]:58364 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750903Ab0AUSvw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jan 2010 13:51:52 -0500
Received: by pwi21 with SMTP id 21so177806pwi.21
        for <git@vger.kernel.org>; Thu, 21 Jan 2010 10:51:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=EqLzhjHAIslQCyAGLQQo7p5u11zLzAX1dKw1MI+bpxs=;
        b=wHefPjiDdKmKiXvd4CNM+zKbWrCwpg2+Zc+de6a98lLrFuOzQVi4KiyWQDKLo2HC2y
         UxTndSoEDKPtlsrJEwXWedj8+4jz1Nhbnj996S4SW3+iVDbr/Fr1ZFtfFzKANt1j4hwC
         m2dIs0gEwGbzOOOeQCR1PLX/tJ4Hrhxs+eSJU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=BiWAiDBhr8mZ41praKTGbdzWozqlmdlZ0TQBQ33FOkcQ27Z0DO1J39dX5puM0+ByPh
         npgnmQaq5UFtNH3gxzEqQRHBiLMfxHU4Fw95VNte7Im3E8P6APv1GyyCtkuY83D+Wg78
         81mbgIr3aWVZY+bx02HpUN+UgFeqh+YClffZk=
Received: by 10.142.4.11 with SMTP id 11mr1243010wfd.128.1264099911147; Thu, 
	21 Jan 2010 10:51:51 -0800 (PST)
In-Reply-To: <20100106073822.6117@nanako3.lavabit.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137684>

On Tue, Jan 5, 2010 at 2:38 PM, Nanako Shiraishi <nanako3@lavabit.com> wrote:
> Junio, could you tell us what happened to this thread?
>
> After a lengthy discussion, nothing happened.
>

Sorry. I lost interest during the holidays and then went on a vacation
after. I've returned and will try and get back to it this weekend.
