From: =?UTF-8?Q?Beno=C3=AEt_Person?= <benoit.person@ensimag.fr>
Subject: Re: [PATCH v4 0/5] git-remote-mediawiki: new tool to preview local
 changes without pushing
Date: Thu, 20 Jun 2013 13:21:57 +0200
Message-ID: <CAETqRCiNyfmOJRYLtY9Fa8m+16c-pcR6uLsc9mOk7u695KAivA@mail.gmail.com>
References: <1371712593-6210-1-git-send-email-benoit.person@ensimag.fr>
	<vpqa9mlduvm.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Celestin Matte <celestin.matte@ensimag.fr>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Jun 20 13:22:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpcwD-00033K-SS
	for gcvg-git-2@plane.gmane.org; Thu, 20 Jun 2013 13:22:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965220Ab3FTLV6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Jun 2013 07:21:58 -0400
Received: from mail-ie0-f172.google.com ([209.85.223.172]:57657 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965007Ab3FTLV5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Jun 2013 07:21:57 -0400
Received: by mail-ie0-f172.google.com with SMTP id 16so16293348iea.31
        for <git@vger.kernel.org>; Thu, 20 Jun 2013 04:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=vpau+E61HYPLsPBlgHA/lVHk814QIThue9gNGIZ3odA=;
        b=Kvwi71ooLcdhY7jdjFa3zzkW+mHyf7822IkGSzx0hnNEEkZghJoSLxWw3RQnT3KdjC
         FAJS6Xq5MVWCYhsu6ToQPbFmg979l5nzNJCZLi02hGjTgplZlEVav1qgE5IGXaVfFWcX
         R6xwtTU5u5ee5FYDlBW4tQwK8StZiGvVAaXCYKfbCDHuq4nkjLwXJ896m93cPnu9oNBE
         WfOz7hsTqYjmUiutOgdhnnaG+YbQuOxk/FLg+TNdZ3BnELNWdv76AFitJy6c90O+Pi1o
         5iSc0+DWHbLHTo0wcvPGp9/QtdZo+XbjuqEi9kG2z/dYyfiuilgTIPfkpvWez7vSmyeO
         Ey6w==
X-Received: by 10.50.39.76 with SMTP id n12mr3408767igk.101.1371727317070;
 Thu, 20 Jun 2013 04:21:57 -0700 (PDT)
Received: by 10.42.210.20 with HTTP; Thu, 20 Jun 2013 04:21:57 -0700 (PDT)
In-Reply-To: <vpqa9mlduvm.fsf@anie.imag.fr>
X-Google-Sender-Auth: P8xbcD7Tw0F3qQ3TJe08S33kZAY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228480>

Ok, thanks for all the reviews,

Final version (I hope :) ) will come when all the mediawiki patches
will have graduated to 'master' then.

Benoit Person
