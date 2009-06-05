From: Rostislav Svoboda <rostislav.svoboda@gmail.com>
Subject: Re: Best way to merge two repos with same content, different history
Date: Fri, 5 Jun 2009 18:53:56 +0200
Message-ID: <286817520906050953n1afed29cn6c85f219a0c9b8b5@mail.gmail.com>
References: <63BEA5E623E09F4D92233FB12A9F794303117DBF@emailmn.mqsoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Kelly F. Hickel" <kfh@mqsoftware.com>
X-From: git-owner@vger.kernel.org Fri Jun 05 18:54:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCcg9-0008Ul-Lx
	for gcvg-git-2@gmane.org; Fri, 05 Jun 2009 18:54:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753448AbZFEQx5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Jun 2009 12:53:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752841AbZFEQx4
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jun 2009 12:53:56 -0400
Received: from mail-fx0-f213.google.com ([209.85.220.213]:35663 "EHLO
	mail-fx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751960AbZFEQxz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Jun 2009 12:53:55 -0400
Received: by fxm9 with SMTP id 9so709182fxm.37
        for <git@vger.kernel.org>; Fri, 05 Jun 2009 09:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=YY5qbhgCEH3ae0+QW7Ms7gPmc0OzryGoelflpT/mr60=;
        b=sBQ6ydva2Jbsxm6L0pF8RiMFEFx57YY0lBt40cY5at5U+86wE5vsecIwtQmnh28Dh4
         ADR37fAMegtGkoChH0B85yn379wrYQkfCM4r2JQGowmfyPTT/qVAHbc+XTRXpuI5rNTf
         cM/0F8WYAeW1a4TGlwEsxMFArVzWtN4qzGrfQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=mJUp7TP40BAd9+uSKAr5ZKA27w66IeWTqQ/3QU+JZvNUYrIBnWXos/1hTGb/oOCe2z
         X3kxRvaxd26hszPvYazJY3m7BkW1cn43RwEZxOwjL3ayPCeUsd0ybA0xyMyKfMCb7e8k
         n72ICQ0iDmmxyYbKxISX4CuQlBGngrl2elgug=
Received: by 10.204.116.8 with SMTP id k8mr3312636bkq.110.1244220836421; Fri, 
	05 Jun 2009 09:53:56 -0700 (PDT)
In-Reply-To: <63BEA5E623E09F4D92233FB12A9F794303117DBF@emailmn.mqsoftware.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120809>

On Fri, Jun 5, 2009 at 18:30, Kelly F. Hickel<kfh@mqsoftware.com> wrote=
:
> =A0 =A0 =A0 =A0We're converting out of CVS after 10 years... The cvs2=
git
> conversion takes around 4-5 days, and there doesn't seem to be any wa=
y
> to speed that up.

try google:
"cvs2git migration - cloning CVS repository"

Bost
