From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [QGIT PATCH] Rework the commit confirmation box a bit
Date: Mon, 6 Oct 2008 21:03:54 +0200
Message-ID: <e5bfff550810061203udf32302y94ea9c44fec3fe2b@mail.gmail.com>
References: <48E9D659.1090503@lyx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Abdelrazak Younes" <younes@lyx.org>
X-From: git-owner@vger.kernel.org Mon Oct 06 21:06:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KmvPB-0005nF-LF
	for gcvg-git-2@gmane.org; Mon, 06 Oct 2008 21:06:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752206AbYJFTD5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Oct 2008 15:03:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752178AbYJFTD4
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Oct 2008 15:03:56 -0400
Received: from mu-out-0910.google.com ([209.85.134.190]:14466 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752173AbYJFTD4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Oct 2008 15:03:56 -0400
Received: by mu-out-0910.google.com with SMTP id g7so2425983muf.1
        for <git@vger.kernel.org>; Mon, 06 Oct 2008 12:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=SwLaF78rZdRsWGZ6c1obHsprE+v3bBQ1Y8N+AMkF7jw=;
        b=VD2LDapKMKG39hocN4IflOiGz2V1A5pimVI2hSsUJXSvAkkOWpQNT7BMcyw1sg9Z7Q
         FnShzOpTXxJeR9F1/65zKzwUhK+oDUAXKlwOzG2MZYHvKmofdUKsUasuB4d+iMyiwia/
         XbabKm/5NE+x7TQiTq6n2EhOxJimnkxCnjZE0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=JptmRYwVRMbmrZwgNBwyMK4mD6J9pJBEMV9L7YVTepTKsXZYG7/Kn+ygTqdl/M5srl
         KqkZc8FWQAazfVL0tfVA4QNaoD2WeK8GW8QcrB54qOVIV89WdlddCP0Kgu++c8yZIbEQ
         Vy88WB4ZtGou9UOgREVEfpYciBO1ZWqYCFrQM=
Received: by 10.181.2.10 with SMTP id e10mr4043848bki.107.1223319834084;
        Mon, 06 Oct 2008 12:03:54 -0700 (PDT)
Received: by 10.180.220.15 with HTTP; Mon, 6 Oct 2008 12:03:54 -0700 (PDT)
In-Reply-To: <48E9D659.1090503@lyx.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97617>

On Mon, Oct 6, 2008 at 11:11 AM, Abdelrazak Younes <younes@lyx.org> wrote:
> The problem was that the dialog was too big for my whenever too many files
> were changed. Now, the list of changed files is only shown whenever they are
> less than 20; otherwise it is shown in the detailed text accessible though
> the 'Show Detail' button.
> ---

Thanks,

   patch applied and pushed.

Marco
