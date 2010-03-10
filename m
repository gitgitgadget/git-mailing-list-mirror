From: Christian MICHON <christian.michon@gmail.com>
Subject: Re: ANN: Git for Windows 1.7.0.2 preview 20100309
Date: Wed, 10 Mar 2010 23:27:59 +0100
Message-ID: <46d6db661003101427h78cd29b2g2e7147a58130dda0@mail.gmail.com>
References: <alpine.DEB.1.00.1003091921140.18499@intel-tinevez-2-302>
	 <vpqtyso5nfl.fsf@bauges.imag.fr>
	 <alpine.DEB.1.00.1003101741350.3006@intel-tinevez-2-302>
	 <4B9809C7.6060304@obry.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	msysgit@googlegroups.com, git@vger.kernel.org
To: pascal@obry.net
X-From: git-owner@vger.kernel.org Wed Mar 10 23:28:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NpUO1-000649-Pa
	for gcvg-git-2@lo.gmane.org; Wed, 10 Mar 2010 23:28:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757365Ab0CJW2F convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Mar 2010 17:28:05 -0500
Received: from mail-bw0-f209.google.com ([209.85.218.209]:59491 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757362Ab0CJW2B convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Mar 2010 17:28:01 -0500
Received: by bwz1 with SMTP id 1so5459912bwz.21
        for <git@vger.kernel.org>; Wed, 10 Mar 2010 14:28:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=MtERxN/iAm4D1cpYGVEG9741yL92dwFdVqkWUqhV99c=;
        b=Cj4ldvw4zvVEiKjJTwzvz49/3/IgxDhNcwAfXueAjqjOtFRE/Dm0BkL34n7a5O2IuN
         4Vy3BdCCnDODzXUe6ayMLNxSfXHDl2OgrP21r+8xIa/RJ+/LT6UzB1UNU3wo46nivJIS
         OzWz6BfJoWdiNWUYoJBFHxTV+mGvHgZxu3xIo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=fFu0CRU4f/HqRPj3Cp7VrCYcfaS7a9oAWds5bDLXoXACyQvr0hzVrtyAP5sWORCrdO
         Vwz4nEbgB7+8g8auGpk4R2jToQwOqFkBSXKDXRW8fbZSY2HqdwcTG0cEz7XA/TcRoBg+
         O2swBK+mbUIeRnU/rBxQDCXP0Xedu+xKqvidw=
Received: by 10.204.20.77 with SMTP id e13mr2584005bkb.163.1268260079100; Wed, 
	10 Mar 2010 14:27:59 -0800 (PST)
In-Reply-To: <4B9809C7.6060304@obry.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141926>

On Wed, Mar 10, 2010 at 10:06 PM, Pascal Obry <pascal@obry.net> wrote:
> Le 10/03/2010 17:44, Johannes Schindelin a =E9crit :
>> I cannot say anything about the Cygwin version, as I haven't used it=
 in
>> ages.
>
> I'm using Cygwin version since years now. I'm building Git daily from
> master on Cygwin. No problem on my side with Git.
>
> I have some issues with git-svn from time to time because some DLL ar=
e
> not properly relocated. I need to call Cygwin "rebaseall". This is of=
ten
> the case after installing a new version of SVN (under Cygwin) and/or
> Perl. But apart from that git-svn run like a charm on Cygwin too. I
> would expect Git on Cygwin a bit slower than a native version, but Gi=
t
> is so fast (and much faster than SVN) than it is just ok as-is.
>
> Pascal.
>
> --
>
> --|------------------------------------------------------
> --| Pascal Obry =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 T=
eam-Ada Member
> --| 45, rue Gabriel Peri - 78114 Magny Les Hameaux FRANCE
> --|------------------------------------------------------
> --| =A0 =A0http://www.obry.net =A0- =A0http://v2p.fr.eu.org
> --| "The best way to travel is by means of imagination"
> --|
> --| gpg --keyserver keys.gnupg.net --recv-key F949BD3B
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>

I did set up git from cygwin on windows 2003 server with gitolite, and
I'm using msysgit on the clients side.

Clearly I'll try sooner or later to remove cygwin from the equation to
gain speed...

--=20
Christian
--
http://detaolb.sourceforge.net/, a linux distribution for Qemu with Git=
 inside !
