From: "=?ISO-8859-1?Q?Marc-Andr=E9_Lureau?=" <marcandre.lureau@gmail.com>
Subject: [RFC] git add -a
Date: Thu, 6 Mar 2008 12:23:04 +0200
Message-ID: <e29894ca0803060223p6de78b1br1aab956c2c99fc1f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 06 11:23:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXDGL-0001I3-Lt
	for gcvg-git-2@gmane.org; Thu, 06 Mar 2008 11:23:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755472AbYCFKXH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 Mar 2008 05:23:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755461AbYCFKXG
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Mar 2008 05:23:06 -0500
Received: from wf-out-1314.google.com ([209.85.200.175]:32781 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750815AbYCFKXE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Mar 2008 05:23:04 -0500
Received: by wf-out-1314.google.com with SMTP id 28so2454229wff.4
        for <git@vger.kernel.org>; Thu, 06 Mar 2008 02:23:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=90EJnUzVYSTJ3cohcK74BgQIHkgO6Tr88BlQCxmMqMg=;
        b=xehbo2FZSBKxo8XCDvBl9qH8cT4Ww0uPeY1R5gK0sM/+axy5s4OM7UJKC1AEK3cOGBYdJ31V9IoMlvXIdKvfgNDR6EijJSt+OkEvHuzKjhpScPE1+AqUtWdZP+G2XobajDDLu9loLtpiwhjkbekJUhK6ca9Z3th4EsF8fiyWL8o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=wSxehAFbAgkEv5CM0oJwSv1NHzUUtmDzKTVYYZZ78Zo/7ZB3z9HrAxXiHT14zU5Zy77U8faGCyhWZT/hiyCdK6r7b6zfiEi1Ava7S1zg0S9qaIddVj/DHuRdAmbFMrcs7uLXWRy52REXeoqFx5YiQwL0m+X0c+Zwm3Y6T6PaYAQ=
Received: by 10.142.216.9 with SMTP id o9mr662602wfg.58.1204798984081;
        Thu, 06 Mar 2008 02:23:04 -0800 (PST)
Received: by 10.143.8.21 with HTTP; Thu, 6 Mar 2008 02:23:04 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76360>

Hello,

What about "git add -a" ? I am in a situation where I'd like it :)

Of course, I could do a commit -a and amend later, but that does not
have the same meaning for me. Tell me what you think.

Thanks

--=20
Marc-Andr=E9 Lureau
