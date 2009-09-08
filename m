From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: What's cooking in git.git (Sep 2009, #02; Mon, 07)
Date: Tue, 8 Sep 2009 15:17:20 +0200
Message-ID: <fabb9a1e0909080617ga2c1c4v383987961156d778@mail.gmail.com>
References: <7vtyzexnhm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 08 15:17:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ml0Zw-0003h3-A9
	for gcvg-git-2@lo.gmane.org; Tue, 08 Sep 2009 15:17:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753462AbZIHNRj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Sep 2009 09:17:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753454AbZIHNRj
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Sep 2009 09:17:39 -0400
Received: from ey-out-2122.google.com ([74.125.78.24]:12965 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752912AbZIHNRi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Sep 2009 09:17:38 -0400
Received: by ey-out-2122.google.com with SMTP id 25so1052684eya.19
        for <git@vger.kernel.org>; Tue, 08 Sep 2009 06:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=E4d07T3htaqUfUocH7ii1Ic2VMsApB+RCfbkRBBkFUk=;
        b=AAnqvt24u6mVZLOJLPZUXjIl0JhiI2VR7APCEHWFM2nyDuXeVY1iuqU2lEEIurHG69
         dqjF6Pow8IRak0FFedHuPuC39nCf1FU8nTMtc3jVAA+r0L8lkwXT5kF5dbZFQYrb8pic
         7GKOsD1zTF0RpgxWPqXXvvhSvLS3X+J/fTn80=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=Ci4A8rIhkQNrMTVhI/D5RrCaPtVd07+FFNx2ZaB4oGREf46JfogS/DNo+0umRKsadV
         rJNQeTnNzo2he3sBQOaumxf0Y4xCx33vYmY1npLkGhIhk4Sf6JmsmGXSf3HVZsOEituh
         htXlcBzFQTxUyU9up1bVVkSqTR2m6j7W9jeOU=
Received: by 10.216.11.211 with SMTP id 61mr1870646wex.68.1252415860150; Tue, 
	08 Sep 2009 06:17:40 -0700 (PDT)
In-Reply-To: <7vtyzexnhm.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128005>

Heya,

On Tue, Sep 8, 2009 at 02:56, Junio C Hamano<gitster@pobox.com> wrote:
> * sr/gfi-options (2009-09-06) 6 commits
> =A0(merged to 'next' on 2009-09-07 at 5f6b0ff)
> =A0+ fast-import: test the new option command
> =A0+ fast-import: add option command
> =A0+ fast-import: test the new feature command
> =A0+ fast-import: add feature command
> =A0+ fast-import: put marks reading in it's own function
> =A0+ fast-import: put option parsing code in separate functions
>
> Perhaps 1.6.5 material but I wasn't sure.

Shawn, what's your opinion of v7? I think it handles pretty much
everything we need for at least a draft and is good for 1.6.5, but
it's up to you of course :).

--=20
Cheers,

Sverre Rabbelier
