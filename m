From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: Please pull mergetool.git
Date: Mon, 11 Jun 2007 13:55:25 +1200
Message-ID: <46a038f90706101855g639656f3qe80adeeb3a7d6dc2@mail.gmail.com>
References: <E1HxPt7-0007jV-6V@candygram.thunk.org>
	 <7v1wgj8tzy.fsf@assigned-by-dhcp.cox.net>
	 <26568045-F443-415E-A250-29C7DD3998A9@silverinsanity.com>
	 <7vabv74838.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Brian Gernhardt" <benji@silverinsanity.com>,
	"Theodore Ts'o" <tytso@mit.edu>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 11 03:55:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxZ81-0005mX-Fq
	for gcvg-git@gmane.org; Mon, 11 Jun 2007 03:55:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761939AbXFKBz0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jun 2007 21:55:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760999AbXFKBz0
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jun 2007 21:55:26 -0400
Received: from wx-out-0506.google.com ([66.249.82.237]:36033 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758585AbXFKBz0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2007 21:55:26 -0400
Received: by wx-out-0506.google.com with SMTP id t15so1290163wxc
        for <git@vger.kernel.org>; Sun, 10 Jun 2007 18:55:25 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=DXEaiae9WRjtHDm+FIROMlk465f55o4SLDDP3RmduAh4VsOXS7aVyGC8hsf1eHzWkCJfYIz9W6xmLRzRwDSSHRG6JwSgWxpkBIMcorPZZkhdYSxXfZqMpOlFpuwR3YaLc+VPW64mcU9mbtYgIr4aa//csodRk/hWr2BKQQ6rMh8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=h+wPA0NosUPFkP3xGxsgzvs++chE2Vsy6iTcsltCgg52c0WC5F+G/ViaVJpMSslX5ZyIKGWYdfMnExkuBmMjToKtoT2tdYHB7iA+GdGBvbNZDDORAdnq87eMZy/YZUZyiLKWbDBrJFMSRFyeFqecgqd+9AE9zpawwm2AjftV5Z8=
Received: by 10.90.80.8 with SMTP id d8mr4749051agb.1181526925383;
        Sun, 10 Jun 2007 18:55:25 -0700 (PDT)
Received: by 10.90.35.4 with HTTP; Sun, 10 Jun 2007 18:55:25 -0700 (PDT)
In-Reply-To: <7vabv74838.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49812>

On 6/11/07, Junio C Hamano <gitster@pobox.com> wrote:
> Brian Gernhardt <benji@silverinsanity.com> writes:
> > Actually, opendiff (as FileMerge.app) is available under OS X, where
> > $DISPLAY is not set.
>
> Heh, a graphical environment that does not use DISPLAY...

FWIW, it depends on whether you are using xterm (DISPLAY is set) or
Terminal.app (DISPLAY may not be set). In any case FileMerge.app will
ignore DISPLAY.

cheers,


m
