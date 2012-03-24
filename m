From: chaitanyaa nalla <nallachaitu@gmail.com>
Subject: Re: Designing a faster index format GSoC 2012
Date: Sun, 25 Mar 2012 00:32:07 +0530
Message-ID: <CACeyogfjgASroy8b5maeS8C_opGLURgvNF4DBohGyTyBeC1VUA@mail.gmail.com>
References: <CAOx2=+fUU5rMuix6XHWgtMwBwUgCtBEokXAgnMRxB9j3YSmz8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Mauricio Galindo <up.mauricio.g@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 24 20:02:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SBWEB-00080G-1R
	for gcvg-git-2@plane.gmane.org; Sat, 24 Mar 2012 20:02:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755739Ab2CXTCJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 24 Mar 2012 15:02:09 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:57561 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752138Ab2CXTCI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 Mar 2012 15:02:08 -0400
Received: by obbeh20 with SMTP id eh20so3524370obb.19
        for <git@vger.kernel.org>; Sat, 24 Mar 2012 12:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=Tgss+IjVkdWZgOrB7t/7/GRx6AbdtI9vM2rLOgFkO38=;
        b=YBSH5yqbLUn/IeqaOt+6bmVLj8+HNAfTlcqjOACAfttNgFtMu9Jw6edA2Haw3Q+eDK
         MKrPwks8OzTvkedCy9v8izVyw5AEhrwNPa7RKwrbHkvr51q/bxvuJK92rIeUyTLEgchZ
         bIOx2EyJSAbe0iAmvUDU3Cieln68Lb+ynZKqeNDVFlRnHQVjvbnFXHfM5lQpvXCXrqWF
         QFuaml8G6VHlHL6yM5nSsR9hevpdbBknYYJtjSCkpEYd6uiIwxzbc8H3a+UZWhxXr7Dt
         S3fYezFLZO/fp13EDDTNrR98oF7l+8xNjAq5YRkxAkx45nPw6MlySdtUgcH+5fhwrOVS
         bTog==
Received: by 10.60.19.106 with SMTP id d10mr10482572oee.40.1332615727830; Sat,
 24 Mar 2012 12:02:07 -0700 (PDT)
Received: by 10.182.39.234 with HTTP; Sat, 24 Mar 2012 12:02:07 -0700 (PDT)
In-Reply-To: <CAOx2=+fUU5rMuix6XHWgtMwBwUgCtBEokXAgnMRxB9j3YSmz8g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193840>

please refer the recent archive, Gmane, that contains the discussion
on designing a faster index format .Hope that helps .

chaitanya nalla.
On Sun, Mar 25, 2012 at 12:05 AM, Mauricio Galindo
<up.mauricio.g@gmail.com> wrote:
> Hi
>
> I'm a third year computer engineering major wanting to participate at
> GSoC 2012 working on the Git project of designing a faster index
> format.
> I was hoping if someone could give some pointers on where to begin.
> I've already started looking around and found some files that I think
> are important <add.c, read-cache.c, index-format.txt>.
> Is there something I'm missing or that you think I should also check =
out?
> Any pointer would be greatly appreciated.
>
> Thank you.
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
