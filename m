From: Kevin <ikke@ikke.info>
Subject: Re: cvs2git migration
Date: Tue, 14 Feb 2012 20:50:09 +0100
Message-ID: <CAO54GHCYN=YX2wjcJ8vRcsFPirtjHJ=5ZFvqQbEtcNoM_awBGg@mail.gmail.com>
References: <1329220866066-7283631.post@n2.nabble.com> <1329244386868-7285021.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: supadhyay <supadhyay@imany.com>
X-From: git-owner@vger.kernel.org Tue Feb 14 20:50:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RxOOb-0003H6-94
	for gcvg-git-2@plane.gmane.org; Tue, 14 Feb 2012 20:50:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759805Ab2BNTuc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Feb 2012 14:50:32 -0500
Received: from mail-we0-f174.google.com ([74.125.82.174]:63533 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754994Ab2BNTub convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Feb 2012 14:50:31 -0500
Received: by werb13 with SMTP id b13so182580wer.19
        for <git@vger.kernel.org>; Tue, 14 Feb 2012 11:50:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=gILsTYKUF0sstjQrQ/Imxh5sv2Nvce32JMMiqkaN+OA=;
        b=hCrk10Tpci8JRH9VH26yYRJvNCIRTHmxhQkZxnRZI0sbUX4ihnQtLqE1w5Sr1iRwpn
         aAFUhIfM2TCN2znFDGOSwrvVtJndsT7wvYcGojoaNQq0wuEMgMmcMpdb4Mwp6EFvDijH
         QGoOuSRLtxNyvyNNPpMvT/mZYKn0Rzz+j5VyM=
Received: by 10.181.11.227 with SMTP id el3mr31048056wid.18.1329249030179;
 Tue, 14 Feb 2012 11:50:30 -0800 (PST)
Received: by 10.227.113.74 with HTTP; Tue, 14 Feb 2012 11:50:09 -0800 (PST)
In-Reply-To: <1329244386868-7285021.post@n2.nabble.com>
X-Google-Sender-Auth: 3zImRSL4Sqr-rOQab2dN8DfHjAE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190740>

I see that you have already asked this question before on the mailing l=
ist

See http://git.661346.n2.nabble.com/User-authentication-in-GIT-td726134=
9.html


On Tue, Feb 14, 2012 at 7:33 PM, supadhyay <supadhyay@imany.com> wrote:
> Hi All,
>
> Can any one please update me what would be the method/steps to migrat=
e
> existing CVS users to GIT in CVS2GIT migration? User migration is pos=
sible
> or not?
>
> Thanks in advance...
>
> --
> View this message in context: http://git.661346.n2.nabble.com/cvs2git=
-migration-tp7283631p7285021.html
> Sent from the git mailing list archive at Nabble.com.
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
