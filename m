From: Kevin <ikke@ikke.info>
Subject: Re: Urgent: Issue with GIT ...
Date: Tue, 26 Jun 2012 11:01:10 +0200
Message-ID: <CAO54GHBqe9jj1sZtLcRZRhdJJEWwuTesFNgUBSZVnBnNtJvpCQ@mail.gmail.com>
References: <1340624980925-7562097.post@n2.nabble.com> <slrnjugobd.8ie.andy@atom.gently.org.uk>
 <CAO54GHA=R1CyspFrC1n-JLVbm5eE+roXLBv6hFL5M1BHGAcVBA@mail.gmail.com> <slrnjuiqt9.jhd.andy@atom.gently.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Andy Hawkins <andy@gently.org.uk>
X-From: git-owner@vger.kernel.org Tue Jun 26 11:01:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SjReT-0003YJ-Dh
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jun 2012 11:01:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754131Ab2FZJBd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 Jun 2012 05:01:33 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:56362 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754103Ab2FZJBc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Jun 2012 05:01:32 -0400
Received: by weyu7 with SMTP id u7so3407985wey.19
        for <git@vger.kernel.org>; Tue, 26 Jun 2012 02:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=V0ox9sTPbokhncldHZnzvJ7OKdN3mIh/ggt+phDd+qg=;
        b=DpkTqAu0Owk2INJc3gNnswzqPBzokH9RCT9WA0arAn4UekxJmHJrNYXeQDlxnNdw2H
         LoRapJRTcDG2cUW0G4DRlgjnJkO6l1Ad4t4hVnePmKSJ6VXeG+9aS8QNOzBbRXWOu987
         876PURAz2gRT4KLhQkwoO0kFekprVagUHjYtDNBbWbXhBtmQc1e+LBDODEMLUI/8zlNm
         sJ4Czeah9TExbRWHzIF2+KL3NzQLm1SqkjU4T1priS5KpSpTl0PclnCRHVYeyHPyVpfI
         sdV5a3rfNcKCXXVtPGVh00bj4OB+0ylASGjqtG8b4LsZkEe5bukPdEuGsgxrVWywlQpB
         ireA==
Received: by 10.216.145.24 with SMTP id o24mr7162026wej.110.1340701291385;
 Tue, 26 Jun 2012 02:01:31 -0700 (PDT)
Received: by 10.227.35.202 with HTTP; Tue, 26 Jun 2012 02:01:10 -0700 (PDT)
In-Reply-To: <slrnjuiqt9.jhd.andy@atom.gently.org.uk>
X-Google-Sender-Auth: xdO_GEvBQyQv1AKGAMUm432GuJE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200638>

Yes, indeed. Read over your reply.

On Tue, Jun 26, 2012 at 9:58 AM, Andy Hawkins <andy@gently.org.uk> wrot=
e:
> Hi,
>
> In article <CAO54GHA=3DR1CyspFrC1n-JLVbm5eE+roXLBv6hFL5M1BHGAcVBA@mai=
l.gmail.com>,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Kevin<ikke@ikke.info> wrote:
>> In this setup, you should only pull from both repositories, not push=
 to the
>> other repository. If you want to push things, you should use a bare =
repository
>> that both repositories can access and push to.
>
> Errr, isn't that what I said?
>
> Andy
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
