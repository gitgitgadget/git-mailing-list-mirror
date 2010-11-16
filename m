From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 000/160] [PULL] ab/i18n rebased on ab/i18n-prereqs
Date: Tue, 16 Nov 2010 01:53:23 +0100
Message-ID: <AANLkTikqG5mkAbF4+xtBkDs8_ML9Uwn=xLvtcnDFXXuB@mail.gmail.com>
References: <1289747245-23263-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 16 01:53:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PI9ng-0007Ba-4S
	for gcvg-git-2@lo.gmane.org; Tue, 16 Nov 2010 01:53:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758963Ab0KPAxZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Nov 2010 19:53:25 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:48761 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754116Ab0KPAxZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Nov 2010 19:53:25 -0500
Received: by fxm6 with SMTP id 6so69054fxm.19
        for <git@vger.kernel.org>; Mon, 15 Nov 2010 16:53:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=1rXPaM2NEXnPltV0WdbGSrM59wZLQPZuGZwQxY+4L38=;
        b=tFfxCZKvWY1h35W1yre7QZbeE+KzaN0jUgJ9s4ZLHtu9sq+ut8MVMI6XGzTuZGAjGg
         IcUbBbEnTOY7yPnMRnsZ3/oBk5paLWy2Zt0HDs1Ju0m4royznKWQw2bzm/dXKpioNnjk
         G64kDhXAVQPFZcq/V8QuSsFsQlq5mqHn+E69Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=RiPRW9BNyuOuqttkWBSxdoS09b/oTxqmUg0jz/O8oHf1bGlbJL3YVdH0qMsvARAVdh
         /UYfuPHCA6cwifn+ZKK0C0N3yNNjZY9G4+eNXwtt2bRZDXfNlPuIawlNZj2jWu8/dDtV
         tKRSIFXrq8H0SdX6fylnqLx+8xYOO1A3hXJLA=
Received: by 10.223.101.131 with SMTP id c3mr5469455fao.95.1289868803531; Mon,
 15 Nov 2010 16:53:23 -0800 (PST)
Received: by 10.223.105.78 with HTTP; Mon, 15 Nov 2010 16:53:23 -0800 (PST)
In-Reply-To: <1289747245-23263-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161527>

On Sun, Nov 14, 2010 at 16:07, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <=
avarab@gmail.com> wrote:
> Here's an updated ab/i18n rebased on the new ab/i18n-prereqs
> series. The major change here is this patch:

I've rebased ab/i18n and ab/i18n-prereqs again to account for the
master Junio pushed out which contains two of the ab/i18n-prereqs
patches.
