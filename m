From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH v5 04/12] wildmatch: remove unnecessary functions
Date: Sun, 14 Oct 2012 13:29:36 +0700
Message-ID: <CACsJy8DsH9OfkdJw3MnkvUidjgdUFP_ODdjLnj25jgKbB9yr7w@mail.gmail.com>
References: <1350182110-25936-1-git-send-email-pclouds@gmail.com>
 <1350182110-25936-5-git-send-email-pclouds@gmail.com> <7vr4p1zl2s.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Oct 14 08:30:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNHiO-0001ps-Og
	for gcvg-git-2@plane.gmane.org; Sun, 14 Oct 2012 08:30:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751292Ab2JNGaI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Oct 2012 02:30:08 -0400
Received: from mail-ia0-f174.google.com ([209.85.210.174]:42730 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751216Ab2JNGaH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Oct 2012 02:30:07 -0400
Received: by mail-ia0-f174.google.com with SMTP id y32so2952274iag.19
        for <git@vger.kernel.org>; Sat, 13 Oct 2012 23:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=retP6cWYpOr4ORD7xrEwlnsGxwguL6FIII7uSpcKY5g=;
        b=a2N5av1MohIOZuuD9P4A88xanQ+X91f4PVgSk7DcC77sBTu1XOgtV1PL1TnnVYiuZh
         3SFDrtB3058Rhsx4TCDlKuNfWMqeJg9YsnmwR6lQLrKYmIBxPic0Jk2lQz6EpZ27ufXS
         LHTll0hA+CmUPNLHnVXO5b9jDFxRfIe2VxfeatMJwTSEF2dOWQ3GhweOMQpbPA3fLYqt
         KwqfGeOYfKNmrNI3hte1LIAWcNLu0vp3dC4iNeFsaI1oo7y+SBBg22SaDco3R1ccar5T
         6wEOSOLMe8uxA1VFokPy0d2OGlWBeYu9/iH53Vdh+WGtedzQOmaK/orbyZ4qMkXqV5p+
         tdsw==
Received: by 10.50.0.241 with SMTP id 17mr5923116igh.40.1350196206488; Sat, 13
 Oct 2012 23:30:06 -0700 (PDT)
Received: by 10.64.143.168 with HTTP; Sat, 13 Oct 2012 23:29:36 -0700 (PDT)
In-Reply-To: <7vr4p1zl2s.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207642>

On Sun, Oct 14, 2012 at 12:04 PM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes=
:
>
>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gm=
ail.com>
>> ---
>
> The comment-fix seems to be new but otherwise this is unchanged,
> right?

Right.--
Duy
