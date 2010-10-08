From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 0/6] Unify argument and option notation in the docs
Date: Fri, 8 Oct 2010 12:44:57 -0500
Message-ID: <20101008174457.GB13738@burratino>
References: <87fwwhszsf.fsf@gmail.com>
 <1286559080-27257-1-git-send-email-stepnem@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: =?utf-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepan.nemec@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 08 19:48:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P4H3J-00052A-J0
	for gcvg-git-2@lo.gmane.org; Fri, 08 Oct 2010 19:48:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759220Ab0JHRsK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 Oct 2010 13:48:10 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:44702 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759186Ab0JHRsJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Oct 2010 13:48:09 -0400
Received: by ewy23 with SMTP id 23so776944ewy.19
        for <git@vger.kernel.org>; Fri, 08 Oct 2010 10:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=OnDdnFrl/04IXn1WwsV0+rHV7lVnO6mAV0ZCXuOav/M=;
        b=KqFp/Vx3P+clbjBBEFFOwrYFlGP1j6BhORLiVrpUNzKvnEMG0Y+EhX5+Vi2dmDdq0X
         w509+I+Wr/9Jxm94AjAkUTan6Y4WPm4D9+G6XFkyxQNUVOnOpTlPfi5HWLakeYWP9x8j
         iGqezsMFrCEk/9i9vHN7qA2WyAwJqinU8Qt8E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=URDByJIwGkaV4DOR1qHDMursjG/0HZos15cRaRvsL4GHf1ID56ZHb9L3oq0UPGpUbx
         mAvStXUQU9rqRtKmrUc+gQvLigqJ4acxLdQun6bIdmZ5+lL6JfFIk1euF02swBQVmM8u
         +LhDvsZfTsxXg6fkiMLnakrEEdRHnHVTzWRsE=
Received: by 10.213.41.133 with SMTP id o5mr156870ebe.54.1286560087310;
        Fri, 08 Oct 2010 10:48:07 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id y14sm1448939vch.28.2010.10.08.10.48.06
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 08 Oct 2010 10:48:06 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1286559080-27257-1-git-send-email-stepnem@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158516>

=C5=A0t=C4=9Bp=C3=A1n N=C4=9Bmec wrote:

> [PATCH 1/6] Use angles for placeholders consistently
> [PATCH 2/6] Fix odd markup in --diff-filter documentation
> [PATCH 3/6] Use parentheses and `...' where appropriate
> [PATCH 4/6] Remove stray quotes in --pretty and --format documentatio=
n
> [PATCH 5/6] Put a space between `<' and argument in pack-objects usag=
e string
> [PATCH 6/6] Fix {update,checkout}-index usage strings

All these seem like improvements to me.  So:
Acked-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.
