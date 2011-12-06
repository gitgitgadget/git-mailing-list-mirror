From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Roadmap for 1.7.9
Date: Tue, 6 Dec 2011 18:16:18 +0700
Message-ID: <CACsJy8DFe2so2gqR_DGAgNkB7J5JBqvGc6pEaxXpDhzZC82cZA@mail.gmail.com>
References: <7vd3c2lr36.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 06 12:16:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RXt15-0002sx-Qz
	for gcvg-git-2@lo.gmane.org; Tue, 06 Dec 2011 12:16:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753815Ab1LFLQv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Dec 2011 06:16:51 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:43477 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753703Ab1LFLQu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Dec 2011 06:16:50 -0500
Received: by eeaq14 with SMTP id q14so2760093eea.19
        for <git@vger.kernel.org>; Tue, 06 Dec 2011 03:16:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=rNN3+tyvehD410zzRouH/Ovre6DVSLVOJMzHmbkgZGg=;
        b=DlAbMiKFV4Vo+mxAUEgm30cAtZxnuYLIcBV9Z01TaJjfJXFetK4D2pOeAsG1LAooL3
         bUjgkL6nsUtM5OAu54CNokTUPo4mYSMwv1LanRo35qbadowC+DyNkd8MvAq+GvR22Cpm
         vQbIBG2Yp6Ee6MC+gqPve17X1WV33Zeu/G5Xg=
Received: by 10.14.10.222 with SMTP id 70mr2276547eev.131.1323170209388; Tue,
 06 Dec 2011 03:16:49 -0800 (PST)
Received: by 10.204.23.2 with HTTP; Tue, 6 Dec 2011 03:16:18 -0800 (PST)
In-Reply-To: <7vd3c2lr36.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186341>

On Tue, Dec 6, 2011 at 3:07 AM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> I expect the following will not make much progress without further
> discussion:
>
> =C2=A0* Ignored vs Precious (Nguyen Thai Ngoc Duy)

I'm working on adding --exclude-standard and --exclude-from to
read-tree. Apart from that I don't plan on supporting precious files
because I don't use them.
--=20
Duy
