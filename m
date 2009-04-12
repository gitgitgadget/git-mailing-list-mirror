From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [RFC PATCH] git add -p: new "quit" command at the prompt.
Date: Sun, 12 Apr 2009 14:54:22 +0200
Message-ID: <fabb9a1e0904120554n355adf26s99966c92e874880f@mail.gmail.com>
References: <1239375421-2556-1-git-send-email-Matthieu.Moy@imag.fr>
	 <7vws9rdmgd.fsf@gitster.siamese.dyndns.org>
	 <vpqfxgevy58.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Sun Apr 12 14:55:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LszE5-0003rw-Kq
	for gcvg-git-2@gmane.org; Sun, 12 Apr 2009 14:55:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760499AbZDLMyZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Apr 2009 08:54:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760479AbZDLMyY
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Apr 2009 08:54:24 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:34627 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760414AbZDLMyY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Apr 2009 08:54:24 -0400
Received: by fxm2 with SMTP id 2so1689161fxm.37
        for <git@vger.kernel.org>; Sun, 12 Apr 2009 05:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=+nWuGCnG9LSC3tk15Nid6uhfoSJYIIlcJWDl+9GqjoU=;
        b=M4WnfwWU6f7rdbVjmiJlATOx7E5MfjB8MBYAjC6AqDz9EbXqscNhvxuAuWnOlCdthm
         y86X/K/W135CslngGI4DiSf7AOwm81rekdZ0hTeNIrorUKAkvBg9eRFTJi2fODTOz9g4
         hXDRJIm7orYDy2X5yASG1wm0MwSBh5t/HY4ko=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=sFWNr4KFZGQq1hdXtY+QU00jlknEbNQa1G2HRe+XhhP/A02wo9ImiLlLMvljkjhJCH
         3p/VNuX435uyLEjYdKNy1cyVzeShsYvK52bKlW1ZeVO+BRIzyzVWT35vF+HVDQyNoxk+
         8vTyKrE6AEopRPg61B571kDmN6bGYu2RuRfTU=
Received: by 10.103.217.5 with SMTP id u5mr2779080muq.42.1239540862189; Sun, 
	12 Apr 2009 05:54:22 -0700 (PDT)
In-Reply-To: <vpqfxgevy58.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116378>

Heya,

On Sunday, April 12, 2009, Matthieu Moy <Matthieu.Moy@imag.fr> wrote:
> Sure, I can live without it, but if other people would like to have
> it, please speak now ;-).

Yes please, I would like a q command to git add -p too!

--
Cheers,

Sverre Rabbelier

-- 
Cheers,

Sverre Rabbelier
