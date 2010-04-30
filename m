From: Michael Witten <mfwitten@gmail.com>
Subject: Re: Multiblobs
Date: Fri, 30 Apr 2010 13:16:55 -0500
Message-ID: <u2lb4087cc51004301116t17ba0efamf4c9b38842bad409@mail.gmail.com>
References: <loom.20100428T164432-954@post.gmane.org> <k2y32541b131004281107u6d15ed4ex54b5e5c138cc0e24@mail.gmail.com> 
	<loom.20100428T204406-308@post.gmane.org> <4BDA9F5C.2080808@itaapy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?Q?Herv=C3=A9_Cauwelier?= <herve@itaapy.com>
X-From: git-owner@vger.kernel.org Fri Apr 30 20:19:19 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O7uny-00075Z-Cw
	for gcvg-git-2@lo.gmane.org; Fri, 30 Apr 2010 20:19:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933573Ab0D3SRW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 30 Apr 2010 14:17:22 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:43064 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933464Ab0D3SRR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Apr 2010 14:17:17 -0400
Received: by fxm10 with SMTP id 10so466633fxm.19
        for <git@vger.kernel.org>; Fri, 30 Apr 2010 11:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=xaNPRSelwRoFz8unDr+qivVL7oeo5ooQliCbqUENY+U=;
        b=BuFVhx3NMBEQoRiw3Xws6A9KUmiklDIuoupMSMUre5N97PS6pTO4x3I7pW3ndsUIuF
         ZJ9lSFXG0xkqFaIel9KCK23gg6bMtYXc8hN3L5k26JwsNf1ZvXGG48dh0E0K28tIe+Dq
         ngXL/l+NuSmBx5lDjhD9GerRmE4CM494DobgI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=P0d8pOtmqEMSwfiNWKYAlTMUFgDdTVPW6ZuAgJI5IhB45Jdwnt/hxaljeY+SqHLKmh
         udqtSfmkxclG1Ox2TtQWauo6vhgryKVQYLoNR8k9fcUJ1/wUiD2lsfAaNTF4lM4XjVWA
         J6oL1cnO7RWWlJONYig1qcEBLMVlL3LHACpmE=
Received: by 10.239.142.18 with SMTP id e18mr201941hba.52.1272651435163; Fri, 
	30 Apr 2010 11:17:15 -0700 (PDT)
Received: by 10.239.189.143 with HTTP; Fri, 30 Apr 2010 11:16:55 -0700 (PDT)
In-Reply-To: <4BDA9F5C.2080808@itaapy.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146040>

2010/4/30 Herv=C3=A9 Cauwelier <herve@itaapy.com>:
>
> Unless you are talking about a dedicated application to store and gen=
erate
> on-the-fly office documents, built on top of Git, you're better not t=
ouching
> the contents the user is entrusting git to store, and write a .gitatt=
ribute
> not to compress them in a pack.

Doesn't OOo provide at least some library of official code for
handling such files, so that other programs might be able to
interoperate?

If so, then it would be almost trivial for an OpenDocument 'plugin' to
be 'built on top of Git'.

If not, then OOo is crap.
