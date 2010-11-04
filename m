From: =?utf-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@gmail.com>
Subject: Re: The linkgit: Asciidoc macro broken (for some backends)?
Date: Thu, 04 Nov 2010 23:49:26 +0100
Message-ID: <87sjzgg0w9.fsf@gmail.com>
References: <87wrosg2ox.fsf@gmail.com> <20101104222159.GB18475@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 04 23:51:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PE8eV-00033j-Ne
	for gcvg-git-2@lo.gmane.org; Thu, 04 Nov 2010 23:51:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753341Ab0KDWu4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Nov 2010 18:50:56 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:44052 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752385Ab0KDWuy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Nov 2010 18:50:54 -0400
Received: by bwz11 with SMTP id 11so2162948bwz.19
        for <git@vger.kernel.org>; Thu, 04 Nov 2010 15:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject
         :in-reply-to:references:user-agent:date:message-id:mime-version
         :content-type:content-transfer-encoding;
        bh=+J/8ivdXS8HN++m+Ku0+IZuI3GQFFAtBerAkBB/Q3oM=;
        b=HtzssRTg3rmxN/XqhJQpmzPoR6e44V9sb9sQVPibIH4HB3YDcoQ6u2wT8Hp90FsSVO
         wQ2rQCeOzAuNcB4QjiCRYoNTuWV3MIv6wr+GFJ5zIhtHSjvW+6K35dFgfsqbcinaqBIs
         ShQyS8BdYE5u4C6OSf74/G5bD90VMiz/WSEP4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:in-reply-to:references:user-agent:date
         :message-id:mime-version:content-type:content-transfer-encoding;
        b=vxtkt1oYOt9h4QB7jAb7r98lCxN+Ng7Bk9VgQXp4bDeEEDSsJFVjNYsm42zEirCncn
         ffr97K6IsndpliGaL38uNK82WYWzbFh4Ginectnx97WD8VGM/uW+wGswoaBNKmqPkBOz
         U1AcNcv5YpV38IlCHNaM/o6UGFWLW+GW0MSZQ=
Received: by 10.204.117.199 with SMTP id s7mr1197570bkq.15.1288911053455;
        Thu, 04 Nov 2010 15:50:53 -0700 (PDT)
Received: from localhost (176.119.broadband10.iol.cz [90.177.119.176])
        by mx.google.com with ESMTPS id v25sm429955bkt.6.2010.11.04.15.50.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 04 Nov 2010 15:50:52 -0700 (PDT)
In-Reply-To: <20101104222159.GB18475@burratino> (Jonathan Nieder's message of
	"Thu, 4 Nov 2010 17:23:18 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160790>

Jonathan Nieder <jrnieder@gmail.com> writes:

>> I noticed that even though all the links to gitrevisions(7) in the
>> documentation sources point correctly to manual section 7 (where it
>> belongs and is actually installed), the links are rendered in manpag=
es
>> as gitrevisions(1)
>
> Probably your copy of the reference manual precedes v1.7.3.2~12 (Docu=
mentation:
> gitrevisions is in section 7, 2010-10-11).

Ah, so it _is_ a PEBKAC after all... I was wondering :-)
Thank you and sorry for the noise.

=C5=A0t=C4=9Bp=C3=A1n
