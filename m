From: =?ISO-8859-1?Q?Maxime_L=E9vesque?= <maxime.levesque@gmail.com>
Subject: Re: Modern Git GUI
Date: Thu, 28 Jan 2010 10:11:16 -0500
Message-ID: <554f5f781001280711j67753654w10651b53999cab9f@mail.gmail.com>
References: <e39c1dcf1001231340p67448584pfdbc453cc8fb9ca7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?ISO-8859-1?Q?Andr=E9_Harms?= <andre.harms@kuhlsolutions.de>
X-From: git-owner@vger.kernel.org Thu Jan 28 16:11:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NaW1l-00006q-9l
	for gcvg-git-2@lo.gmane.org; Thu, 28 Jan 2010 16:11:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753370Ab0A1PLT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 Jan 2010 10:11:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932158Ab0A1PLT
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jan 2010 10:11:19 -0500
Received: from mail-px0-f182.google.com ([209.85.216.182]:40396 "EHLO
	mail-px0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752863Ab0A1PLR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Jan 2010 10:11:17 -0500
Received: by pxi12 with SMTP id 12so617672pxi.33
        for <git@vger.kernel.org>; Thu, 28 Jan 2010 07:11:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=5j0yKV3sYYhSmz4cutE63QVi6AISq8dQEENcDvNeU2s=;
        b=umEUaIAnNbf18bUigwNnX00BLlgwuSAl0VR1FNXaQjwqrj4h/jAUHYTh7J6rE2L+l3
         TBi6Vqlf1wLg0E2m/VFS8fes2CoQZVnlVAkA51Dyop+0/WTtAHwK/VjwfF9yjXWhnuPB
         kySzkmaHgn82DC7aAGVwuhrBFbGOPHo+rYfK8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=SaQkwONPyM7JbNjchqzujvdXjT6mX9/tBJ3GrLSudPji97fW6Jr2w60NyPepvf3Nt5
         fw/xqHk+3KTX/JcCC6cfmGwT5nT6Ndpz7Uzh25prASgDXmn4q8xhDe0eMZxff3g/0F0l
         gDphl1oeUQGlX3xtFL3okbeYraPy89pjR+UkE=
Received: by 10.142.119.20 with SMTP id r20mr1359787wfc.96.1264691476547; Thu, 
	28 Jan 2010 07:11:16 -0800 (PST)
In-Reply-To: <e39c1dcf1001231340p67448584pfdbc453cc8fb9ca7@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138254>

  On one hand, the proliferation of GUIs for Guit should be good
in a darwinian sense. On the other hand, for a new commer there
are so many to try out that the 'better' ones get a diluted visibility.
 After trying a few I concluded that the Guit GUIs were in the medieval
stage, then I stumbled upon SmartGit and I found it pretty decent.
One good explanation for why there are so many is that to provide
a GUI that is "as simple as possible but no simpler"  is not an easy
problem to solve in terms of UI design, but it is an interesting one.

  Cheers

On Sat, Jan 23, 2010 at 4:40 PM, Andr=E9 Harms
<andre.harms@kuhlsolutions.de> wrote:
> Hi,
>
> I know there are several GUIs out there for Git. They are all
> functional and most of them can be used in the daily work with Git.
> In my opinion one thing combines them: they aren't very pretty.
> I currently prefer the CLI to work with Git because it's quick and I
> am happy with it. But I think there are people out there, who don't
> want to use the command-line because they are afraid of doing
> something wrong or anything like this. Additionally the CLI and
> unattractive GUIs are barriers to people who are not familar with a
> SCM-system.
> So I thought about developing a new kind of GUI for Git that looks
> modern and attractive (you know... some eye-candy stuff) and that is
> easy to use. In addition I thought about a built-in console (like we
> know it from first person shooters) so that also people who prefer th=
e
> CLI might use this GUI application too.
>
> Is there anybody who agrees or disagrees? I really would appreciate
> some feedback about that idea.
>
> P.S.:
> Normally I come up with such ideas to the public and ask what others
> think about it when I have some mockups. I am sorry that I haven't an=
y
> right now.
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
