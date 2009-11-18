From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: What's cooking in git.git (Nov 2009, #04; Tue, 17)
Date: Wed, 18 Nov 2009 16:22:44 +0800
Message-ID: <be6fef0d0911180022r2f6b113ct9527a7abd4a96b2e@mail.gmail.com>
References: <7v7hto46ce.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 18 09:22:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NAfoP-0004C2-Tg
	for gcvg-git-2@lo.gmane.org; Wed, 18 Nov 2009 09:22:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752241AbZKRIWj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 18 Nov 2009 03:22:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752197AbZKRIWj
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Nov 2009 03:22:39 -0500
Received: from mail-iw0-f178.google.com ([209.85.223.178]:55547 "EHLO
	mail-iw0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751706AbZKRIWi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Nov 2009 03:22:38 -0500
Received: by iwn8 with SMTP id 8so722848iwn.33
        for <git@vger.kernel.org>; Wed, 18 Nov 2009 00:22:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=vn1NRqmzV734u6gvSVwSWkGghCb8qmb5heZyxl24lms=;
        b=b2drcHRxWayv/D3gBthp3VS/ge0ljW2J1jmDGfsChhGe5NbhZ/H7IHZQTu5Ezksq9E
         lzMHJbxQLmIexp5OQP8L0Ld73EFU/0sI6DSxAfSKkrvbz4b1GrYhqsziPKm2QypDpcpl
         U4FNWoy8T9lDaHlGa3d4vsK30u1aSCmDMF1oU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=aKasMr907Nl8wTd/uXTc+CZwFaM17dXWpZ6Sbbv6dIsiRIOMX2pang9rPZctjac7oQ
         RrrgWqn4N6znbNdxuYSrDQjrX+rCYYWUsS1oTVru6WXWgmS62EEGaCxow3bcjqbq7fwx
         D7vN0duTziLIuRWRfl9hnLS9lPF2/bI5YuJ68=
Received: by 10.231.157.83 with SMTP id a19mr1618159ibx.41.1258532564367; Wed, 
	18 Nov 2009 00:22:44 -0800 (PST)
In-Reply-To: <7v7hto46ce.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133153>

Hi,

On Wed, Nov 18, 2009 at 3:53 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> * sp/smart-http (2009-11-14) 37 commits
> =A0[snip]
> =A0+ Git-aware CGI to provide dumb HTTP transport

hmm, it appears that this commit (92815b3) has an incorrect subject;
it should instead read "http-backend: Fix symbol clash on AIX 5.3"
(which is the first line in the commit message body).

It's from the email

  From: "Shawn O. Pearce" <spearce@spearce.org>
  To: git@vger.kernel.org
  Subject: [PATCH 1/3] http-backend: Fix symbol clash on AIX 5.3
  Date: Mon,  9 Nov 2009 10:10:35 -0800
  Message-Id: <1257790237-30850-1-git-send-email-spearce@spearce.org>

--=20
Cheers,
Ray Chuan
