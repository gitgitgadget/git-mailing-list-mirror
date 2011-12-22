From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: Re: Gitk: shortcut to jump to the current HEAD (yellow spot)?
Date: Thu, 22 Dec 2011 09:09:27 -0800
Message-ID: <CAOeW2eGFw0RfU0FHL4CEMVPwSNvrRLv9_iG7Gy_qCheY3GxWxw@mail.gmail.com>
References: <4EF3517A.8030108@dirk.my1.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?UTF-8?Q?Dirk_S=C3=BCsserott?= <newsletter@dirk.my1.cc>
X-From: git-owner@vger.kernel.org Thu Dec 22 18:09:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rdm96-00067A-DP
	for gcvg-git-2@lo.gmane.org; Thu, 22 Dec 2011 18:09:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755434Ab1LVRJ3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 22 Dec 2011 12:09:29 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:42705 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751966Ab1LVRJ1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Dec 2011 12:09:27 -0500
Received: by iaeh11 with SMTP id h11so13756642iae.19
        for <git@vger.kernel.org>; Thu, 22 Dec 2011 09:09:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=i1Jkyb3FzRL0PAvkV8XC8Ey6XWuc7HsSdgBQhdT6Ecg=;
        b=IWkPD5xuGkDZ2IzQLkMjlCB5XGqyedspzomr2PpOwL78JuMDoW1DPwMFikl590rrwI
         VGi/jriaAcul/JiF3Cy+foWWhX24Hjg/Vci26NVv20+0EeykHcST/KUsFmiEG14mqXsX
         auyl/U6oRR+ratwAnaUM2ebWm6ZkUXCbUxUhg=
Received: by 10.50.185.201 with SMTP id fe9mr9468276igc.26.1324573767364; Thu,
 22 Dec 2011 09:09:27 -0800 (PST)
Received: by 10.231.23.213 with HTTP; Thu, 22 Dec 2011 09:09:27 -0800 (PST)
In-Reply-To: <4EF3517A.8030108@dirk.my1.cc>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187610>

2011/12/22 Dirk S=C3=BCsserott <newsletter@dirk.my1.cc>:
> Does anybody know about a shortcut in gitk to "jump to the yellow spo=
t"?

Not sure it's fast enough for you, but you can always enter "HEAD" in
the "SHA1 ID" box (and press Enter).
