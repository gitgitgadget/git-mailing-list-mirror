From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: What's cooking in git.git (Oct 2009, #02; Sun, 11)
Date: Mon, 12 Oct 2009 08:23:02 +0200
Message-ID: <fabb9a1e0910112323x35798972qe213025f37af82b3@mail.gmail.com>
References: <7vfx9pmhae.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 12 08:32:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxESV-0001wI-Pg
	for gcvg-git-2@lo.gmane.org; Mon, 12 Oct 2009 08:32:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753061AbZJLGYA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 12 Oct 2009 02:24:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752895AbZJLGX7
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Oct 2009 02:23:59 -0400
Received: from mail-ew0-f208.google.com ([209.85.219.208]:38218 "EHLO
	mail-ew0-f208.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752827AbZJLGX7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Oct 2009 02:23:59 -0400
Received: by ewy4 with SMTP id 4so2204188ewy.37
        for <git@vger.kernel.org>; Sun, 11 Oct 2009 23:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=ss0sFP171P4iTBKMdwizE3GYzHBmbK+dIDc2DDXKmeE=;
        b=beafItwuP+tZdEb/Od90YUUP1EmapunwzLsSaZSCY4Wz5coKiHVthJwxHxTfN5P6f6
         EJlunWrPsdJenuIvgSiqp7cLjxe2CjuyODyXX9BG5XiBrW9m6fGWmfCQjEMIgxF8LYBE
         HtN4fh3CGmZZKYt2jLyeKRWRoyeTxsn/8eCjg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=xjFJ7aB2+xGGLJOMA8Dn0rhJEiOizvIyBy9Xl2cnaeWGJZ6Kj/lu7bsGWVWzOpdq1T
         bBtTYwXT6FVFvafisf3sDeH3dnCVT8PqPhTwq8hMzkvvbNTsDvi5ThBG4E1d9jSWUjwj
         vbdwLFIsb716KAJ1EVTb3wfn94j4VSwSjchBU=
Received: by 10.216.89.139 with SMTP id c11mr1870224wef.198.1255328602123; 
	Sun, 11 Oct 2009 23:23:22 -0700 (PDT)
In-Reply-To: <7vfx9pmhae.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129987>

Heya,

On Mon, Oct 12, 2009 at 05:18, Junio C Hamano <gitster@pobox.com> wrote=
:
> [Stalled]
>
> * sr/gfi-options (2009-09-06) 6 commits.
> =A0- fast-import: test the new option command
> =A0- fast-import: add option command
> =A0- fast-import: test the new feature command
> =A0- fast-import: add feature command
> =A0- fast-import: put marks reading in it's own function
> =A0- fast-import: put option parsing code in separate functions
>
> Ejected from 'next' as fast-import folks still seem to be discussing =
with
> how to proceed.

Thanks, I hope to have this re-rolled before 1.6.6 goes into RC.

--=20
Cheers,

Sverre Rabbelier
