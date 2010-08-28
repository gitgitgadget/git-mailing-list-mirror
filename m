From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCHv2] completion: make compatible with zsh
Date: Sat, 28 Aug 2010 10:43:13 +0000
Message-ID: <AANLkTin7rARxLbCUvKOgQUG0s8KhVYZmYxhs+ZafTPW8@mail.gmail.com>
References: <1282877156-16149-1-git-send-email-lodatom@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>,
	Andrew Sayers <andrew-git@pileofstuff.org>,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
To: Mark Lodato <lodatom@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 28 12:43:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OpIse-0005R8-L5
	for gcvg-git-2@lo.gmane.org; Sat, 28 Aug 2010 12:43:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752749Ab0H1KnT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 28 Aug 2010 06:43:19 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:34448 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752095Ab0H1KnT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 28 Aug 2010 06:43:19 -0400
Received: by iwn5 with SMTP id 5so3404201iwn.19
        for <git@vger.kernel.org>; Sat, 28 Aug 2010 03:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=QuAMX6zg692JXbBE/Jh/VrNw2PfwLj21Td1g9lmu61A=;
        b=ZHEX8Stk298FXsNnfJau1t78lrt+NhvuMqKyGSnA7pXrRfg9XmwwBZew2U8aVe2kgG
         5+ME9HnrbaA0CkQn94R5QtN6kPdWo2qnS7SXdnaC1xhkr2DnqLsBVf4kkZURWNXt/6zb
         yiET4hCiBmMs3bCcDkDLkSjeC/JI5LnobUJ8k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=PPEfpCBDf8Ou2kYUaUl92Iq2BPDeSZEI+UjrHYPYTOM1PkIoRuv0H2E2zcxQvpzXrS
         5XWqO+L/t0jXy4zALoJZh3E4ghOmIYHkep1JT3oBWaIFE3yq6W1bSLhavP29ZJ3H/ME1
         s9F80SVePfJW9yUPZtMWGYl/TTdx4mo67chFg=
Received: by 10.231.161.73 with SMTP id q9mr2597787ibx.70.1282992193772; Sat,
 28 Aug 2010 03:43:13 -0700 (PDT)
Received: by 10.231.171.145 with HTTP; Sat, 28 Aug 2010 03:43:13 -0700 (PDT)
In-Reply-To: <1282877156-16149-1-git-send-email-lodatom@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154642>

On Fri, Aug 27, 2010 at 02:45, Mark Lodato <lodatom@gmail.com> wrote:
> Modify git-completion.bash so that it also works with zsh when using
> bashcompinit. =C2=A0In particular:

=46WIW:

Reviewed-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
