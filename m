From: "Gerb Stralko" <gerb.stralko@gmail.com>
Subject: Re: list all the untrack files in a git respo
Date: Wed, 4 Jun 2008 10:41:08 -0400
Message-ID: <75b57c110806040741x17cabe91j9863a471ef1670c@mail.gmail.com>
References: <75b57c110806040705mc324d9dx9ce099593ce967dd@mail.gmail.com>
	 <200806041620.54890.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Johan Herland" <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Jun 04 16:42:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3uBh-0004Ur-R4
	for gcvg-git-2@gmane.org; Wed, 04 Jun 2008 16:42:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753596AbYFDOlL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jun 2008 10:41:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753549AbYFDOlK
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jun 2008 10:41:10 -0400
Received: from rv-out-0506.google.com ([209.85.198.230]:28989 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753446AbYFDOlI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jun 2008 10:41:08 -0400
Received: by rv-out-0506.google.com with SMTP id l9so144001rvb.1
        for <git@vger.kernel.org>; Wed, 04 Jun 2008 07:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=UUS7+4Gn5XgKuaDFSifRi41OJ0LeLheKzA0JcB2cv8Y=;
        b=crZTn7Nq4+j1dRamvuGOCR9D46FmqWX7T27X21vwa4CPzx+jiG5JHe7giDxsOWRWeG
         04vJSfdtqYoz3OdJT+5ELw+pJTQxKqEgpLXUMuBoTUZyYcfnyNKMi0Dh93G5oTplXUCP
         ZfPHAedYfQOzoDNbr/pdKoHhIjiStI5INDYQY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=umfTzmUOoJdAcfWNwtKT6cCEfk3dNu/G4XRou8zRsNVUfHuLTbkJ6xgj47KttksN+k
         dgWGLYgBgImLCBHMqZUg3+jGzgheCIw+SuSJw35oMtQVbLecexY+x5qv/ka3dUuj0/ko
         pXVo2ITsLJB/eb51uoAFpWgwrytG0z4SnHKog=
Received: by 10.141.69.1 with SMTP id w1mr6664962rvk.185.1212590468084;
        Wed, 04 Jun 2008 07:41:08 -0700 (PDT)
Received: by 10.141.50.6 with HTTP; Wed, 4 Jun 2008 07:41:08 -0700 (PDT)
In-Reply-To: <200806041620.54890.johan@herland.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83785>

>        git ls-files -o
>
> ...Johan

This is exactly what i want.  Thanks Johan.

Jerry
