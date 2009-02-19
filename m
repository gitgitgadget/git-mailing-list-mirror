From: Rostislav Svoboda <rostislav.svoboda@gmail.com>
Subject: Re: [PATCH 4/4] remote: new show output style
Date: Thu, 19 Feb 2009 17:17:27 +0100
Message-ID: <286817520902190817h28509c18m6140785ecc96faa9@mail.gmail.com>
References: <1235020471-59982-1-git-send-email-jaysoffian@gmail.com>
	 <1235020471-59982-2-git-send-email-jaysoffian@gmail.com>
	 <1235020471-59982-3-git-send-email-jaysoffian@gmail.com>
	 <1235020471-59982-4-git-send-email-jaysoffian@gmail.com>
	 <1235020471-59982-5-git-send-email-jaysoffian@gmail.com>
	 <499D82BC.7020500@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Thu Feb 19 17:19:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LaBcJ-0000Aw-02
	for gcvg-git-2@gmane.org; Thu, 19 Feb 2009 17:19:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754138AbZBSQRa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2009 11:17:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754057AbZBSQR3
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Feb 2009 11:17:29 -0500
Received: from mail-ew0-f21.google.com ([209.85.219.21]:55573 "EHLO
	mail-ew0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753573AbZBSQR2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Feb 2009 11:17:28 -0500
Received: by ewy14 with SMTP id 14so451468ewy.13
        for <git@vger.kernel.org>; Thu, 19 Feb 2009 08:17:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=KW7xteAwHSTq2fCpxHrORK1T6gLxGL4++1SUzC+8Efc=;
        b=BXMyPcJGOPY0BNYGd8vA2fppxRXVcVfmT3n3b0ASAPfGs2JNxpp6pO1yNrco+4Mn+u
         kxnjZjvst1etFeRNwwuTJZb8+UFX+lblwQL14SutHFXVCLR895CWFSZsbHV8LvsCeBtL
         MMfRYyQHG8cIcoyL0Zrkyz73XkYzXMqWon5dg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=rgpA3bo6RjeKzqAvrvFOoV8I9e/942EHlPe4xbbNkcTu8n66nUi+5pof1aqSx/TsBN
         5d5yVsNHA362MCMbMqhAGZKe3ydwL/UIPXx6SkW7TBDNd+Wt1b2fEjnqffAsF5HgiTXV
         SkyRTIgpSafxnVTHh21ILPWBAuuEczsFnZXUM=
Received: by 10.210.29.17 with SMTP id c17mr300046ebc.177.1235060247256; Thu, 
	19 Feb 2009 08:17:27 -0800 (PST)
In-Reply-To: <499D82BC.7020500@xiplink.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110715>

On Thu, Feb 19, 2009 at 17:03, Marc Branchaud <marcnarc@xiplink.com> wrote:

> First, a nit: I don't know if the "w/remote" notation makes sense to
> non-English speakers.

No it doesn't :)

Bost
