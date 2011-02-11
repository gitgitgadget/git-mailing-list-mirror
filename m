From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: i18n examples howto?
Date: Fri, 11 Feb 2011 21:22:30 +0100
Message-ID: <AANLkTikRMtN5s-jrgSZuwFvNtwJUmdA5UC9OtPJXE+sX@mail.gmail.com>
References: <20110211140157.150a6f10@riseup.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: kev <kev@riseup.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 11 21:23:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PnzWO-0001cP-KN
	for gcvg-git-2@lo.gmane.org; Fri, 11 Feb 2011 21:23:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757904Ab1BKUXM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 11 Feb 2011 15:23:12 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:56999 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756989Ab1BKUXL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 Feb 2011 15:23:11 -0500
Received: by iwn9 with SMTP id 9so2787566iwn.19
        for <git@vger.kernel.org>; Fri, 11 Feb 2011 12:23:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=AHpwuHesVOeU9uQH1I+o3Tcha+W11OrhOCPT2dHcwJ0=;
        b=ImEx8Fw6NHgf8ja7iTO6i+SfoXOjL+p5pqwMK0GTyFmBpvSVzTVAlD70hai/KTn6PZ
         oFN1i5sHrpiACDveG7PcMb7EB6sZId9Ij8vTPqOs/78uPuuZPipdqqeDS36279U5W8o6
         2408R1UgnnIGCcYBoa3GgInxkPlMkDVvYZFeI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=P674oT8mYHvSXGGSNn7GlQ7yRDPEqfsE+RdVBYkVhnRB7qqHZECCNHDIXAdVet2q2+
         WoBR3rpVtYEzDZewOOyvyjiVuhVpli2gtBLmroRSF7c+/vxYDXSyQQ5QuH5u9sJIRD0A
         a+qOdnKs11EpcFFTpeI4TmsPhUzOkifyRKNq8=
Received: by 10.231.33.195 with SMTP id i3mr693136ibd.161.1297455790399; Fri,
 11 Feb 2011 12:23:10 -0800 (PST)
Received: by 10.231.11.132 with HTTP; Fri, 11 Feb 2011 12:22:30 -0800 (PST)
In-Reply-To: <20110211140157.150a6f10@riseup.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166573>

Heya,

On Fri, Feb 11, 2011 at 21:01, kev <kev@riseup.net> wrote:
> i understand the ab/i18n has been gettextized and translated to at
> least a couple of languages.
>
> ive found references in the list archives to this, but nothing in the
> source code. i do see translations of git-gui, however. but im lookin=
g
> for some clue as to how to translate git itself.

Currently the ab/i18n branch has not been merged to master, so it's
not available to the general public. =C3=86var has been working on it b=
ut
we haven't heard from him recently on this topic.

--=20
Cheers,

Sverre Rabbelier
