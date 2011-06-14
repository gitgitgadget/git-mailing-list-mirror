From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Using Transifex in git.git
Date: Tue, 14 Jun 2011 11:27:20 +0530
Message-ID: <BANLkTikQJYYd4sTJoDrL28Bo35+GpV3HgA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Dimitris Glezos <glezos@indifex.com>
X-From: git-owner@vger.kernel.org Tue Jun 14 07:57:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QWMdH-0002AO-RZ
	for gcvg-git-2@lo.gmane.org; Tue, 14 Jun 2011 07:57:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751699Ab1FNF5n convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Jun 2011 01:57:43 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:41825 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751507Ab1FNF5m convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Jun 2011 01:57:42 -0400
Received: by wya21 with SMTP id 21so3639001wya.19
        for <git@vger.kernel.org>; Mon, 13 Jun 2011 22:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:from:date:message-id:subject:to:cc
         :content-type:content-transfer-encoding;
        bh=Xi+bmWR7/mD79XDBs33vgZNECZlD6jXcNNEDRP5vPwc=;
        b=ZVnexak5Eq70fGlQgPrSszz4towV9uz9XMOX+OaNimpEgsaUyncfSn0qOO4fkI4j1v
         jEVAVJd5hdH2qdBTEjhnyDAbpKR++aqgts3L8k4D4YsOleQfkYzeAlPSMpsralHfvLsz
         x2RQOlxAKvkNW2dCw6HHKQx2BquAGJMIFwAr0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        b=pVFOmDW5ImMd+PinsSsDw0DYWZv7dM3oilb7WqQpor5jK/k8RFGP+jiZwVqAtxS9g5
         vvwkcaXEFttNCaTrt8zeeT5w1JLEeoSDmQvHDCWFp9nQ9kJXCzfMSY36LbFlh12GEBBs
         ksS1k/i+/L1R7DSeg7UqmipYWHDQKsPxnsNP4=
Received: by 10.216.143.7 with SMTP id k7mr5619775wej.95.1308031061126; Mon,
 13 Jun 2011 22:57:41 -0700 (PDT)
Received: by 10.216.1.20 with HTTP; Mon, 13 Jun 2011 22:57:20 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175746>

Hi Dimitris et al,

[+CC: Git List; for wider exposure]
[+CC: Jonathan Nieder; he has been involved with translations in the pa=
st]
[+CC: Junio C Hamano; for authoritative policy advice]

I think it's a good idea to use a system like Transifex to manage
translations for git.git, so that we can attract a large number of
non-technical translators.  Further, I think it's a good time to start
off on this now, since many of the i18n bits from =C3=86var's series ar=
e in
'master'.  So, I'm looking to start off a discussion about how to
adapt a translation system into our current patch workflow.  Dimitris
is the lead developer of Transifex, and can help with the details.

Thanks.

-- Ram
