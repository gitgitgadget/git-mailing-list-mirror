From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] Add MYMETA.json to perl/.gitignore
Date: Thu, 29 Dec 2011 10:50:57 +0100
Message-ID: <CACBZZX5kkX3jc-PvSe2=ZWm1DC8tWvsZN9q5G4JabEVnvf6TQA@mail.gmail.com>
References: <1325133725-20671-1-git-send-email-jacknagel@gmail.com>
 <7vty4kx7ol.fsf@alter.siamese.dyndns.org> <7vmxabyiby.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Jack Nagel <jacknagel@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 29 10:51:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RgCdy-0000RY-DE
	for gcvg-git-2@lo.gmane.org; Thu, 29 Dec 2011 10:51:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752421Ab1L2JvW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Dec 2011 04:51:22 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:63867 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752315Ab1L2JvU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Dec 2011 04:51:20 -0500
Received: by eaad14 with SMTP id d14so5856580eaa.19
        for <git@vger.kernel.org>; Thu, 29 Dec 2011 01:51:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=dZV0q0sitLwQ9XASTa4HQIpwbWbUPLbCwnEL9IfczLI=;
        b=mPn+EIlEDERKi1WWaOz56H0q0tY9gApWH2ZQQtGz4Isvt8P4HiSafdipok5f4qzbU9
         WO0TqEKDS/7KsIl2EkE+SHO9HrItW+LBPe8myedLR09SzgEHh3LobQ+jWhNVfCLIXySq
         xvRtfezQ1nriXqowkyDaHQeLdk+C61W4Pdoqg=
Received: by 10.204.128.130 with SMTP id k2mr8192067bks.7.1325152279443; Thu,
 29 Dec 2011 01:51:19 -0800 (PST)
Received: by 10.204.181.83 with HTTP; Thu, 29 Dec 2011 01:50:57 -0800 (PST)
In-Reply-To: <7vmxabyiby.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187777>

On Thu, Dec 29, 2011 at 07:58, Junio C Hamano <gitster@pobox.com> wrote:
> I am simply asking because I do not know.

It'll stay JSON for the forseeable future. It's part of the CPAN META
Specification.
