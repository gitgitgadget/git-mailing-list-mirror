From: =?UTF-8?B?w5h5dmluZCBBLiBIb2xt?= <sunny@sunbase.org>
Subject: Re: Announcing Gitspread - Spread Git commits to several servers with
 a single push
Date: Mon, 25 Apr 2011 13:31:13 +0200
Message-ID: <BANLkTim4g8q=RFiJQjhs+UQARakvioeX9w@mail.gmail.com>
References: <BANLkTikuCfnSuY2r+YzWu1PegP3baniOjA@mail.gmail.com>
	<m3k4eiwrfe.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 25 13:31:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QEK0e-00009C-LI
	for gcvg-git-2@lo.gmane.org; Mon, 25 Apr 2011 13:31:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758496Ab1DYLbP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Apr 2011 07:31:15 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:53653 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758390Ab1DYLbO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Apr 2011 07:31:14 -0400
Received: by vxi39 with SMTP id 39so1710770vxi.19
        for <git@vger.kernel.org>; Mon, 25 Apr 2011 04:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=zIUEw42Tu2SJhu9Y6kKC1HRvrlhcRfdKqXZju8PYHsY=;
        b=QmaUPCO7GhZUgz8rjcCEN/dx2Y7T4/aBfmdBCSpP0HR/ETZ2oCAlibbY8vMqmf8col
         rOXoyEQoArYseBl5dyzYYtTQ0qQ31xH5EN8ohGGPvFSDKA+e5Iib3k0F4ZssIGs6jk8Y
         cZutqgz4uwX5zRjaDCiAFvDEIf9KY489ZjixU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=m20xT+xl3cqAG22ae6dIbFkunCj3MRbKysnnl9SWnlKIfRdl6Kl3eV5sOw1rNnDaIS
         UOrAghbdRd2hl9bAyHhWZ8VZvD4OTksL1V/8KX5mJGy+xqubyJbKT6Zvk7VHTjRtwVpg
         aWCzm5Xnb0eUCsp1W8zN2xb3VOLGNdCeO5tbA=
Received: by 10.52.97.229 with SMTP id ed5mr5834033vdb.237.1303731073971; Mon,
 25 Apr 2011 04:31:13 -0700 (PDT)
Received: by 10.52.181.99 with HTTP; Mon, 25 Apr 2011 04:31:13 -0700 (PDT)
In-Reply-To: <m3k4eiwrfe.fsf@localhost.localdomain>
X-Google-Sender-Auth: Akvy1Cokfz3OLdAuUQ_GTZ-RPHw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172027>

On 25 April 2011 12:35, Jakub Narebski <jnareb@gmail.com> wrote:
> =C3=98yvind A. Holm <sunny@sunbase.org> writes:
> > [Announcement about the Gitspread tool]
>
> Could you please add short info about this tool to
>
> =C2=A0https://git.wiki.kernel.org/index.php/InterfacesFrontendsAndToo=
ls
>
> page on Git Wiki?

Done, it ended up in the Hooks section. Thanks for reminding me about
that page.

Regards,
=C3=98yvind
