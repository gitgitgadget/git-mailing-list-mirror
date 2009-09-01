From: Eric Raible <raible@gmail.com>
Subject: Re: Problems with GIT under Windows - "not uptodate"
Date: Tue, 1 Sep 2009 16:16:21 -0700
Message-ID: <279b37b20909011616x60fc7bfav22daca1bc7bfc714@mail.gmail.com>
References: <a21e6af7ee05f56fd8c02d0955af1c72.squirrel@localhost>
	 <loom.20090901T184650-434@post.gmane.org>
	 <alpine.DEB.1.00.0909020052550.8306@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, david.hagood@gmail.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Sep 02 01:16:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MicaT-0003o9-CG
	for gcvg-git-2@lo.gmane.org; Wed, 02 Sep 2009 01:16:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755356AbZIAXQV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Sep 2009 19:16:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755346AbZIAXQU
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Sep 2009 19:16:20 -0400
Received: from mail-vw0-f195.google.com ([209.85.212.195]:55425 "EHLO
	mail-vw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755354AbZIAXQU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Sep 2009 19:16:20 -0400
Received: by vws33 with SMTP id 33so418199vws.33
        for <git@vger.kernel.org>; Tue, 01 Sep 2009 16:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=BLXWxFq5xv7EmxiahQLKJi8N82SR7iGotZQgRC41MH0=;
        b=w8Y1i4XS/EsMLIqEK6i8V3j8ws88q6roTKkIwpu/pKlgRrfI2JY0/NUUP/m8e+A+Ff
         owjOmS2X4KC/RCKdX7rRKxM4EaTDtkeqcpmxJXKNZDDJ1MFf+ev5LBRAWIzDpf/O7QmB
         QtsaGhfRs67WIZbDVA91GZcuO9QTgf0sbVTd4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=vC5TVRsD4PRRUfiMeZWWfYbSsjhYLmQ95FTO0yM76LMJFLaGxQToOW9SprBdZQDO8A
         FNt8MiFSf/rywvAaRC+NRnvB8Bcs15bCATGq0lnuhnhfui+pa+xSEHqeV/t5HzSNH8It
         aTBKyttov5CzN9QFABXafAdXutW6LKCRVn99c=
Received: by 10.220.89.77 with SMTP id d13mr9589092vcm.91.1251846981854; Tue, 
	01 Sep 2009 16:16:21 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0909020052550.8306@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127564>

On Tue, Sep 1, 2009 at 3:56 PM, Johannes
Schindelin<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> Eric, is there any good reason you neglect netiquette? =A0I re-added =
David
> to the Cc: list.

Thanks.  Frankly I (stupidly) assumed that gmane.org would handle it.
Educate me (if you would): if I read the git list via gmane, what's the
best way to follow up?
