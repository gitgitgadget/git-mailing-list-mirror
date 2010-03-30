From: Eugene Sajine <euguess@gmail.com>
Subject: Re: [ANNOUNCE] JGit 0.7.1 / EGit 0.7.1
Date: Mon, 29 Mar 2010 21:48:26 -0400
Message-ID: <76c5b8581003291848u24fc3f11ic17302d2a92b8076@mail.gmail.com>
References: <20100330012323.GD32653@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Mar 30 03:48:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NwQZK-0000oZ-0Z
	for gcvg-git-2@lo.gmane.org; Tue, 30 Mar 2010 03:48:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754842Ab0C3Bs3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 29 Mar 2010 21:48:29 -0400
Received: from mail-yw0-f172.google.com ([209.85.211.172]:58831 "EHLO
	mail-yw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753591Ab0C3Bs2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Mar 2010 21:48:28 -0400
Received: by ywh2 with SMTP id 2so5423010ywh.33
        for <git@vger.kernel.org>; Mon, 29 Mar 2010 18:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=CxMF67vALRbTIMgWy0WVhFrRtLsXRCXGFz1xjQ9Ffvo=;
        b=XlR2bV5NkFVKSbugvL7ez546or1yRaHhM0F9GZXzCylsV/WpXyqCqRSONGZ0jBFTm/
         9GBiaSN/xY1c5m3wwVBNMTNh6p8tlF2Cr9kO1nVlS8Tjrj5rAzhGNpBbKg12rYs7rdsZ
         Stx2+MF5oZvCLIgwhGEueQKL1eKq3ptw1KcfA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=iuFxGIDXMZfa/+YpcLVJskFJFT6g3cAVIlw3i44peQFHdP5MghjIvDfGLIrN8XIWP2
         17KbEXbcNH0WUlT+I2Ahr83pFuBGzh2n++P88D4m38KHzc+7zJL9h3cKxHg0uISZ6XXM
         t1bFFL6gRWtQd6WIQOLiQFrIUnc27kDLEhv04=
Received: by 10.231.155.143 with HTTP; Mon, 29 Mar 2010 18:48:26 -0700 (PDT)
In-Reply-To: <20100330012323.GD32653@spearce.org>
Received: by 10.101.190.1 with SMTP id s1mr6101955anp.32.1269913706775; Mon, 
	29 Mar 2010 18:48:26 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143534>

Great news!

Thanks a lot!

On Mon, Mar 29, 2010 at 9:23 PM, Shawn O. Pearce <spearce@spearce.org> =
wrote:
> In mid-2009 the EGit and JGit projects started to move to the
> Eclipse Foundation. =C2=A0Last week both projects shipped version 0.7=
=2E1,
> which is our first release since 0.5.0 in June 2009.
>
> Many bugs have been fixed, included the dreaded push corruption bug.
> But most of the release was us figuring out how to navigate the
> Eclipse Foundation's processes, so there aren't many new features
> relative to 0.5.0.
>
>
> About JGit:
>
> =C2=A0JGit is a 100% pure-Java reimplementation of the Git version
> =C2=A0control system, licensed under a BSD style license. =C2=A0These=
 days it
> =C2=A0can be found embedded in quite a few software products. =C2=A0A=
lthough
> =C2=A0the library development is now hosted by the Eclipse Foundation=
,
> =C2=A0it has no outside dependencies beyond the Java standard runtime=
,
> =C2=A0and the BSD licensed JSch SSH client library.
>
> =C2=A0* http://www.eclipse.org/jgit/
> =C2=A0* http://www.eclipse.org/jgit/download/
>
>
> About EGit:
>
> =C2=A0EGit is an Eclipse Team Provider plugin, providing Git features
> =C2=A0directly within an Eclipse workspace. =C2=A0It is built on top =
of the
> =C2=A0JGit library, making the plugin very portable.
>
> =C2=A0* http://www.eclipse.org/egit/
> =C2=A0* http://www.eclipse.org/egit/download/
> =C2=A0* http://download.eclipse.org/egit/updates
>
> --
> Shawn.
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>
