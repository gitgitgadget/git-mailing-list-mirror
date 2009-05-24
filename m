From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 0/2] StGit patch series import
Date: Sun, 24 May 2009 23:55:32 +0200
Message-ID: <fabb9a1e0905241455j7045a920m11e7dcd6a92dd80a@mail.gmail.com>
References: <1243149558-17160-1-git-send-email-giuseppe.bilotta@gmail.com> 
	<7voctirzu6.fsf@alter.siamese.dyndns.org> <cb7bb73a0905241443m6b5d6ba4vab438c856e47a947@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 24 23:56:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M8Lfk-0006cJ-V1
	for gcvg-git-2@gmane.org; Sun, 24 May 2009 23:56:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753709AbZEXVzx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 May 2009 17:55:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753546AbZEXVzw
	(ORCPT <rfc822;git-outgoing>); Sun, 24 May 2009 17:55:52 -0400
Received: from mail-ew0-f176.google.com ([209.85.219.176]:57553 "EHLO
	mail-ew0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753484AbZEXVzv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 May 2009 17:55:51 -0400
Received: by ewy24 with SMTP id 24so2778359ewy.37
        for <git@vger.kernel.org>; Sun, 24 May 2009 14:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=Y3oNAYxPM3nOvPOChd+IpSx8LM+zQ5XI1n6wiHsIMT8=;
        b=JHLhWPJlk1s0N54/ZlBoPFV76Gmi9dRdhYgGG2p/FooOUtiObV/KkEr/pHvpl84cUr
         sl8JupT10ui12SGlBzNxMBG88LpmsS7Y2gvB8IRwBZ5Tsq3q12v+rIByqNXoeT7ygKUW
         x5tpw6G4u7NAgGC10XG4vdro1apJ2uTnj7zTs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=Uz5QPyTUFww04NEQgDIx4UPXGZfc+YHPsJLeos2TiXldV4G9X5jraQbqev6ifL5Ks8
         nVZiUca607drEIMGP0Gp8h+FEnmqhHGHrVVDUOPEpnEaqvYMYAroMqZoOrJUabluKci5
         RQTJE+RxnqSUxn0TFJEMrPneaP9D/KJcnIBt8=
Received: by 10.216.35.204 with SMTP id u54mr1246470wea.182.1243202152259; 
	Sun, 24 May 2009 14:55:52 -0700 (PDT)
In-Reply-To: <cb7bb73a0905241443m6b5d6ba4vab438c856e47a947@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119865>

Heya,

On Sun, May 24, 2009 at 23:43, Giuseppe Bilotta
<giuseppe.bilotta@gmail.com> wrote:
> As I mentioned, Wine uses plain git, and we've tried asking this
> (non-core) developer to expose a standard git tree. But he finds StGIT
> much more comfortable for the task.

Silly question, doesn't StGit have an export option? Methinks if all
the developer has to do is run 'stgit export' and then attach those
patches instead of the raw patches, it'd be really lame of him not to
do at least that?

-- 
Cheers,

Sverre Rabbelier
