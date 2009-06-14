From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 0/2] teach am and rebase -q/--quiet
Date: Sun, 14 Jun 2009 10:27:15 +0200
Message-ID: <fabb9a1e0906140127q3b6a7a56l9b90a1e1e19b03fa@mail.gmail.com>
References: <1244924500-27391-1-git-send-email-bebarino@gmail.com> 
	<7vk53fvini.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Stephen Boyd <bebarino@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 14 10:27:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MFl46-0007BJ-QC
	for gcvg-git-2@gmane.org; Sun, 14 Jun 2009 10:27:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753919AbZFNI1g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Jun 2009 04:27:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753877AbZFNI1g
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Jun 2009 04:27:36 -0400
Received: from mail-ew0-f210.google.com ([209.85.219.210]:43273 "EHLO
	mail-ew0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753712AbZFNI1e (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jun 2009 04:27:34 -0400
Received: by ewy6 with SMTP id 6so4154422ewy.37
        for <git@vger.kernel.org>; Sun, 14 Jun 2009 01:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=wSKO2vMn+iHdi0yb0eIuDo5aetow1jDh+n3hIBdW5yI=;
        b=q7lOmYqtq8u0APZtOCUrXs3hB/wOxXuVw/64OrYS3Wdfa8y237zkY0sirB8lBxokkV
         RpdODhVTxRnYiCuLMUJgcKuwlJhzbPWPRFqwZKGE9kTif83lIcRL9p8N6ZzXaaekcBLo
         2n8e0W+ao7x76ir/RbFK/zTew7CtRseD971NE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=uWBZcAy5fP5uDTR+ph6rpmFLes6ZH+21fetvOeuUz8N04FTYcCWeRyLWEiOac3aRsb
         YJRvmWki6bXI34oDP8LR1WVqwOzbqYjxytHq3mZ3YMiz4bltQq+AMf9rZWFwFduyl01t
         2A7X2NSy90MaT7hhd0Ag8SLAiat1OVUxbKCMQ=
Received: by 10.216.26.70 with SMTP id b48mr1916288wea.141.1244968055125; Sun, 
	14 Jun 2009 01:27:35 -0700 (PDT)
In-Reply-To: <7vk53fvini.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121545>

Heya,

On Sun, Jun 14, 2009 at 01:05, Junio C Hamano<gitster@pobox.com> wrote:
> Stephen Boyd <bebarino@gmail.com> writes:
> I do not understand why some people seem to think stderr is only for
> errors.

The name might be setting people off? ;)

-- 
Cheers,

Sverre Rabbelier
