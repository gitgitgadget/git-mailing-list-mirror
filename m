From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: What's cooking in git.git (Jan 2010, #01; Mon, 04)
Date: Tue, 5 Jan 2010 15:28:22 +0800
Message-ID: <be6fef0d1001042328i70aff96ctf39a02a52fc42bd5@mail.gmail.com>
References: <7vljgei7rs.fsf@alter.siamese.dyndns.org>
	 <7vskal5c11.fsf@alter.siamese.dyndns.org>
	 <20100105064013.GB19025@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jan 05 08:28:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NS3qA-0007aK-QF
	for gcvg-git-2@lo.gmane.org; Tue, 05 Jan 2010 08:28:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754059Ab0AEH20 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 5 Jan 2010 02:28:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753986Ab0AEH20
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jan 2010 02:28:26 -0500
Received: from mail-iw0-f194.google.com ([209.85.223.194]:40814 "EHLO
	mail-iw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751201Ab0AEH2Z convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Jan 2010 02:28:25 -0500
Received: by iwn32 with SMTP id 32so656356iwn.33
        for <git@vger.kernel.org>; Mon, 04 Jan 2010 23:28:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Sl8XAgYDgxBv0d4SDX0gpvX/x+XFoD+nL6Qmnonunjw=;
        b=F3u3G1HMVMvCU7ME2yr1ro8Wj0LH3Icj6Aw0KmxFCRcfFu/1akTxlu3jD4sSaLrSOj
         nLNo4mYY8/VjW5Ns+e1FQHbh7L3B0SLIpXZvJLEiCXvbKgjuJb6YwRLLBjEbfGI7MXNV
         Qlun7IEE36TfW7wSkid4dpWhfCvuztRIsVEqQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=xwcWZXvaofSNKv5G+8dj4Zc0XVH/ooL8/2Lhn/sjFiRP4URpiu0TOdxnLfCwRZ55AU
         pXACGI9o19qNBzIaCv63hg/mBGXPy75UiMVozAfcZmimw2ksrpvkbOOEQH5zBr6PnHMJ
         hdyu1ippnnnRPe0XP7/+fhFQroKqgQLmizo/s=
Received: by 10.231.168.132 with SMTP id u4mr1258iby.54.1262676504046; Mon, 04 
	Jan 2010 23:28:24 -0800 (PST)
In-Reply-To: <20100105064013.GB19025@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136172>

Hi,

On Tue, Jan 5, 2010 at 2:40 PM, Jeff King <peff@peff.net> wrote:
> On Mon, Jan 04, 2010 at 09:57:46PM -0800, Junio C Hamano wrote:
>
>> =A0* tr/http-push-ref-status (2009-12-24) 6 commits
>> =A0 =A0Daniel and Jeff commented on the earlier rounds; is everybody=
 happy with
>> =A0 =A0this v3? =A0If so let's move it to 'next'. =A0If not, please =
complain.
>
> I just posted a few comments, but I suspect the response will just
> involve Tay explaining why I'm wrong or confused. :) So no serious
> objections, but let's wait for this round of discussion.

thanks for taking the time to look at them; I'll be addressing your
concerns soon.

--=20
Cheers,
Ray Chuan
